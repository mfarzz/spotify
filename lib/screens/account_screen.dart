import 'package:flutter/material.dart';
import 'package:spotify/constants.dart';
import 'package:spotify/services/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    final user = Supabase.instance.client.auth.currentUser;

    final email = user?.email ?? 'No email';
    final displayName = user?.userMetadata?['full_name'] ?? 'Unknown';
    final photoUrl = user?.userMetadata?['avatar_url'] ?? '';

    return Scaffold(
      backgroundColor: darkGrey,
      appBar: AppBar(
        backgroundColor: darkGrey,
        title: const Text(
          'Account',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: photoUrl.isNotEmpty
                  ? NetworkImage(photoUrl)
                  : const AssetImage('assets/profile.jpg') as ImageProvider,
            ),
            const SizedBox(height: 16),
            Text(
              displayName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              email,
              style: const TextStyle(color: textGrey, fontSize: 16),
            ),
            const Spacer(),
            InkWell(
              onTap: () async {
                await authService.signOut();
                Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.logout, color: Colors.redAccent),
                  SizedBox(width: 8),
                  Text(
                    'Logout',
                    style: TextStyle(color: Colors.redAccent, fontSize: 18),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
