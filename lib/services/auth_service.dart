import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final SupabaseClient _supabaseClient;
  final GoogleSignIn _googleSignIn;

  AuthService()
    : _supabaseClient = Supabase.instance.client,
      _googleSignIn = GoogleSignIn(
        scopes: ['email', 'profile'],
        serverClientId:
            '937546084944-pplck6kppui7efj78b8k2pk9r2aktbbt.apps.googleusercontent.com', // Untuk Android/iOS
      );

  // Method untuk login dengan Google
  Future<User?> signInWithGoogle() async {
    try {
      // Memulai proses sign in dengan Google
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      // Mendapatkan authentication data dari Google
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Sign in ke Supabase dengan credential Google
      final AuthResponse response = await _supabaseClient.auth
          .signInWithIdToken(
            provider:
                OAuthProvider.google, // Diubah dari Provider ke OAuthProvider
            idToken: googleAuth.idToken!,
            accessToken: googleAuth.accessToken,
          );

      return response.user;
    } catch (e) {
      print('Error during Google sign in: $e');
      return null;
    }
  }

  // Method untuk logout
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _supabaseClient.auth.signOut();
  }

  // Get current user
  User? get currentUser => _supabaseClient.auth.currentUser;

  // Stream untuk memantau perubahan auth state
  Stream<AuthState> get authStateChanges =>
      _supabaseClient.auth.onAuthStateChange;
}
