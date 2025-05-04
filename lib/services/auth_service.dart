import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

<<<<<<< Updated upstream
class AuthService {
  final SupabaseClient _supabaseClient;
  final GoogleSignIn _googleSignIn;
=======
class AuthService extends ChangeNotifier {
  Uri? _pendingDeepLink;
  bool _isProcessingCallback = false; // Add this flag
  final _authStateNotifier = ValueNotifier<bool?>(null);
  ValueNotifier<bool?> get authStateNotifier => _authStateNotifier;
>>>>>>> Stashed changes

  GoogleSignInAccount? _googleUser;

  AuthService()
      : _supabaseClient = Supabase.instance.client,
        _googleSignIn = GoogleSignIn(
          scopes: ['email', 'profile'],
          serverClientId: dotenv.env['GOOGLE_CLIENT_ID']!,
        );

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      _googleUser = googleUser; // Simpan user

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthResponse response = await _supabaseClient.auth
          .signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: googleAuth.idToken!,
        accessToken: googleAuth.accessToken,
      );

<<<<<<< Updated upstream
      return response.user;
=======
      // Process pending deep link if any
      if (_pendingDeepLink != null) {
        await _handleAuthCallback(_pendingDeepLink!);
        _pendingDeepLink = null;
      }
>>>>>>> Stashed changes
    } catch (e) {
      print('Error during Google sign in: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _supabaseClient.auth.signOut();
    _googleUser = null; // Reset juga
  }

  User? get currentUser => _supabaseClient.auth.currentUser;

  GoogleSignInAccount? get googleUser => _googleUser; // Getter tambahan

  Stream<AuthState> get authStateChanges =>
      _supabaseClient.auth.onAuthStateChange;
}
