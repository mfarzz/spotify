import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:spotify/screens/login_screen.dart';
import 'package:spotify/screens/home_screen.dart';
import 'package:spotify/screens/account_screen.dart';
import 'package:spotify/screens/playlist_screen.dart';
import 'package:spotify/screens/playlist_detail_screen.dart';
import 'package:spotify/screens/splash_screen.dart';
import 'package:spotify/services/auth_service.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

GoRouter getAppRouter(AuthService authService) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/splash',
    debugLogDiagnostics: true,
    refreshListenable: authService,
    redirect: (context, state) {
      final isLoading = authService.isLoading;
      final isAuthenticated = authService.isAuthenticated;
      final isProcessingCallback = authService.isProcessingCallback;
      final isSplash = state.uri.path == '/splash';
      final isLogin = state.uri.path == '/login';
      final isCallback = state.uri.path == '/callback' || state.uri.path.contains('/callback');

      // For debugging
      debugPrint('Route state: path=${state.uri.path}, isAuthenticated=$isAuthenticated, isLoading=$isLoading, isProcessingCallback=$isProcessingCallback');

      // Check if this is a callback URL first
      if (isCallback || isProcessingCallback) {
        debugPrint('Callback URL detected or processing callback, showing splash screen');
        return '/splash'; // Show splash screen during callback processing
      }

      // Show splash screen during any loading operations
      if (isLoading) {
        return isSplash ? null : '/splash';
      }

      // Authentication logic after everything is loaded
      if (!isAuthenticated) {
        return isLogin || isSplash ? null : '/login';
      } else {
        // User is authenticated
        if (isLogin || isSplash) {
          debugPrint('User is authenticated, redirecting to /home');
          return '/home';
        }
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return HomeScreen(child: child);
        },
        routes: [
          GoRoute(
            path: '/home',
            builder: (context, state) => const HomeContent(),
          ),
          GoRoute(
            path: '/search',
            builder: (context, state) => const SearchContent(),
          ),
          GoRoute(
            path: '/library',
            builder: (context, state) => const LibraryContent(),
          ),
          GoRoute(
            path: '/account',
            builder: (context, state) => const AccountScreen(),
          ),
        ],
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/playlist/:id',
        builder: (context, state) {
          final playlistId = state.pathParameters['id']!;
          return PlaylistScreen(playlistId: playlistId);
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/playlist/:id/detail',
        builder: (context, state) {
          final playlistId = state.pathParameters['id']!;
          return PlaylistDetailScreen(playlistId: playlistId);
        },
      ),
      // Handle Spotify callback - make this pattern match more flexibly
      GoRoute(
        path: '/callback',
        builder: (context, state) => const CallbackScreen(),
      ),
      GoRoute(
        path: '/callback/:params',
        builder: (context, state) => const CallbackScreen(),
      ),
    ],
  );
}

// Simple screen to show during callback processing
class CallbackScreen extends StatelessWidget {
  const CallbackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Logging in...'),
          ],
        ),
      ),
    );
  }
}