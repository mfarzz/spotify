import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:spotify/services/auth_service.dart';
import 'package:spotify/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  
  // Create and initialize the auth service
  final authService = AuthService();
  await authService.init();
  
  runApp(MyApp(authService: authService));
}

// Main App class that can be used with either a real or mock auth service
class MyApp extends StatelessWidget {
  final AuthService? authService;
  
  // Constructor that allows creating with or without explicit authService
  const MyApp({Key? key, this.authService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use provided authService or create a new one if none is provided
    final effectiveAuthService = authService ?? AuthService();
    
    return ChangeNotifierProvider.value(
      value: effectiveAuthService,
      child: MaterialApp.router(
        title: 'Spotify App',
        theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routerConfig: getAppRouter(effectiveAuthService),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}