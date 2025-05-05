import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:app_links/app_links.dart';

class AuthService extends ChangeNotifier {
  Uri? _pendingDeepLink;
  bool _isProcessingCallback = false; // Add this flag
  final _authStateNotifier = ValueNotifier<bool?>(null);
  ValueNotifier<bool?> get authStateNotifier => _authStateNotifier;

  static String? get _backendBaseUrl {
    final url = dotenv.env['BACKEND_URL'];
    if (url == null || url.isEmpty) {
      throw Exception('BACKEND_URL is not configured in .env file');
    }
    return url;
  }

  static StreamController<User?> userStreamController =
      StreamController<User?>.broadcast();
  static Stream<User?> get userStream => userStreamController.stream;

  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  User? _currentUser;
  String? _accessToken;
  late AppLinks _appLinks;
  bool _isLoading = false;

  User? get currentUser => _currentUser;
  bool get isAuthenticated => _accessToken != null;
  bool get isLoading => _isLoading || _isProcessingCallback; // Update this
  bool get isProcessingCallback => _isProcessingCallback; // Add this getter

  Future<void> init() async {
    _isLoading = true;
    notifyListeners();

    try {
      _appLinks = AppLinks();
      await _loadUserFromStorage();

      // Set up deep link listener first
      _initDeepLinkListener();

      // Then check for initial link
      final initialLink = await _appLinks.getInitialLink();
      if (initialLink != null) {
        debugPrint('Initial link on init: $initialLink');
        _pendingDeepLink = initialLink;
      }

      // Process pending deep link if any
      if (_pendingDeepLink != null) {
        await _handleAuthCallback(_pendingDeepLink!);
        _pendingDeepLink = null;
      }
    } catch (e) {
      debugPrint('AuthService initialization error: $e');
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
      _updateAuthStateNotifier();
    }
  }

  void _updateAuthStateNotifier() {
    _authStateNotifier.value = isAuthenticated;
  }

  void dispose() {
    userStreamController.close();
    _authStateNotifier.dispose();
    super.dispose();
  }

  Future<void> _loadUserFromStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString('user');
      final token = prefs.getString('token');

      if (userJson != null && token != null) {
        _currentUser = User.fromJson(json.decode(userJson));
        _accessToken = token;
        userStreamController.add(_currentUser);
        _updateAuthStateNotifier();
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Failed to load user from storage: $e');
      await _clearStorage();
      rethrow;
    }
  }

  Future<void> _clearStorage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
    await prefs.remove('token');
  }

  void _initDeepLinkListener() {
    debugPrint('Initializing deep link listeners for spotifyapp://callback');

    _appLinks.uriLinkStream.listen(
      (Uri uri) {
        debugPrint('Deep link received while running: $uri');
        _handleAuthCallback(uri);
      },
      onError: (err) {
        debugPrint('Error in deep link stream: $err');
      },
    );
  }

  Future<void> _handleAuthCallback(Uri uri) async {
    if (!uri.path.contains('/callback')) return;

    debugPrint('Processing auth callback: $uri');
    debugPrint('Query parameters: ${uri.queryParameters}');

    // Set the processing flag
    _isProcessingCallback = true;
    notifyListeners();

    try {
      // Check for error first
      final error = uri.queryParameters['error'];
      if (error != null) {
        debugPrint('Auth error: $error');
        throw Exception('Authentication failed: $error');
      }

      // Check if we have token and user data directly
      final token = uri.queryParameters['token'];
      final userId = uri.queryParameters['userId'];
      final name = uri.queryParameters['name'];
      final email = uri.queryParameters['email'];

      if (token != null && userId != null && name != null && email != null) {
        debugPrint('Direct auth data received - token: $token, userId: $userId');

        _accessToken = token;
        _currentUser = User(
          id: userId,
          name: name,
          email: email,
        );

        // Save to storage
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', _accessToken!);
        await prefs.setString('user', json.encode({
          'id': userId,
          'name': name,
          'email': email,
        }));

        debugPrint('User authenticated directly: ${_currentUser?.name}');

        userStreamController.add(_currentUser);
        _updateAuthStateNotifier();
        notifyListeners();
      } else {
        // Fallback to the old approach using code
        final code = uri.queryParameters['code'];
        if (code == null || code.isEmpty) {
          throw Exception('No authorization code found in callback URI');
        }

        debugPrint('Using code exchange approach with code: $code');
        await _exchangeCodeForToken(code);
      }
    } catch (e) {
      debugPrint('Error handling auth callback: $e');
      userStreamController.addError(e);

      // Clear any partial data
      _currentUser = null;
      _accessToken = null;
      _updateAuthStateNotifier();
    } finally {
      _isProcessingCallback = false;
      notifyListeners();
    }
  }

  Future<void> _exchangeCodeForToken(String code) async {
    if (_isLoading) return;
    _isLoading = true;
    notifyListeners();

    try {
      debugPrint('Exchanging code for token...');

      final response = await http
          .post(
            Uri.parse('$_backendBaseUrl/api/auth/spotify/callback'),
            body: {'code': code},
          )
          .timeout(const Duration(seconds: 30));

      debugPrint('Token exchange response status: ${response.statusCode}');

      if (response.statusCode != 200) {
        throw HttpException(
          'Failed to exchange code for token: ${response.statusCode}',
          statusCode: response.statusCode,
        );
      }

      final data = json.decode(response.body);
      if (data['token'] == null || data['user'] == null) {
        throw Exception('Invalid response format from server');
      }

      _accessToken = data['token'] as String;
      _currentUser = User.fromJson(data['user']);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', _accessToken!);
      await prefs.setString('user', json.encode(data['user']));

      debugPrint('User authenticated: ${_currentUser?.name}');

      userStreamController.add(_currentUser);
      _updateAuthStateNotifier();
      notifyListeners();
    } catch (e) {
      debugPrint('Error exchanging code: $e');
      await _clearStorage();
      _currentUser = null;
      _accessToken = null;
      userStreamController.add(null);
      _updateAuthStateNotifier();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> loginWithSpotify() async {
    try {
      final url = Uri.parse('$_backendBaseUrl/api/auth/spotify/login');
      debugPrint('Launching Spotify login: $url');
      return await launchUrl(url, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint('Failed to launch Spotify login: $e');
      return false;
    }
  }

  Future<void> signOut() async {
    try {
      _currentUser = null;
      _accessToken = null;
      await _clearStorage();
      userStreamController.add(null);
      _updateAuthStateNotifier();
      notifyListeners();
    } catch (e) {
      debugPrint('Error during sign out: $e');
      rethrow;
    }
  }

  Future<Map<String, String>> getAuthHeaders() async {
    if (_accessToken == null) {
      throw Exception('Not authenticated');
    }
    return {
      'Authorization': 'Bearer $_accessToken',
      'Content-Type': 'application/json',
    };
  }
}

class HttpException implements Exception {
  final String message;
  final int? statusCode;

  HttpException(this.message, {this.statusCode});

  @override
  String toString() => 'HttpException: $message (statusCode: $statusCode)';
}

class User {
  final String id;
  final String name;
  final String email;

  User({required this.id, required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
    );
  }
}