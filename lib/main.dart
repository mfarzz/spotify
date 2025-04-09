import 'package:flutter/material.dart';
import 'package:spotify/screens/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:spotify/screens/home_screen.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://qzzpxghkkflqolpijzhu.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InF6enB4Z2hra2ZscW9scGlqemh1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDE3NjU5MjAsImV4cCI6MjA1NzM0MTkyMH0.tGnY3f4WFDl0KgzpcPukYgOWqSOzd8-0Ork7s0Mq58Q',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spotify Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(), // Tambahkan route home
      },
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(child: Text('Page not found')),
        ),
    ));
  }
}