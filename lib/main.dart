import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'services/auth_service.dart';
import 'providers/cart_provider.dart';
import 'providers/favorites_provider.dart';
import 'app_routes.dart';

import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';
import 'screens/admin_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const CupHubApp());
}

class CupHubApp extends StatelessWidget {
  const CupHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CupHub',
        theme: ThemeData(
          primarySwatch: Colors.brown,
          scaffoldBackgroundColor: const Color(0xFFF7F3EF),
          fontFamily: 'Roboto',
        ),
        home: const AuthChecker(),
        routes: {
          AppRoutes.splash: (context) =>  SplashScreen(),
          AppRoutes.login: (context) => LoginScreen(),
          AppRoutes.signup: (context) => SignupScreen(),
          AppRoutes.home: (context) => const HomeScreen(),
          AppRoutes.admin: (context) => const AdminScreen(),
        },
      ),
    );
  }
}

class AuthChecker extends StatelessWidget {
  const AuthChecker({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();

    return StreamBuilder<User?>(
      stream: authService.authStateChanges,
      builder: (context, snapshot) {
        // Loading - Show Splash Screen
        if (snapshot.connectionState == ConnectionState.waiting) {
          return  SplashScreen();
        }

        // User Logged In - Route to Home or Admin
        if (snapshot.hasData) {
          final isAdmin = authService.isAdmin(snapshot.data?.email);
          return isAdmin ? const AdminScreen() : const HomeScreen();
        }

        // User Not Logged In - Show Login
        return LoginScreen();
      },
    );
  }
}
