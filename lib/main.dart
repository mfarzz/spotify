import 'package:flutter/material.dart';
import 'package:spotify/screens/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:spotify/screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://qzzpxghkkflqolpijzhu.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InF6enB4Z2hra2ZscW9scGlqemh1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDE3NjU5MjAsImV4cCI6MjA1NzM0MTkyMH0.tGnY3f4WFDl0KgzpcPukYgOWqSOzd8-0Ork7s0Mq58Q',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spotify Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: AuthCheck(), // Ganti initialRoute dengan widget pengecekan
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
      },
      onUnknownRoute:
          (settings) => MaterialPageRoute(
            builder:
                (_) =>
                    const Scaffold(body: Center(child: Text('Page not found'))),
          ),
    );
  }
}

class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  @override
  Widget build(BuildContext context) {
    final session = Supabase.instance.client.auth.currentSession;
    // Jika ada sesi (berarti user sudah login), langsung ke HomeScreen
    if (session != null) {
      return const HomeScreen();
    } else {
      return const LoginScreen();
    }
  }
}
