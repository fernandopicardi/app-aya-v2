import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app_aya_v2/features/landing/landing_page.dart';
import 'package:app_aya_v2/features/auth/screens/login_screen.dart';
import 'package:app_aya_v2/features/auth/screens/signup_screen.dart';
import 'package:app_aya_v2/features/subscription/plans_page.dart';
import 'package:app_aya_v2/features/auth/screens/forgot_password_page.dart';
import 'package:app_aya_v2/features/user/user_profile_screen.dart';
import 'config/env.dart';
// import 'package:app_aya_v2/features/auth/screens/signup_screen.dart'; // será criado
// import 'package:app_aya_v2/features/subscription/plans_page.dart'; // será criado

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa as variáveis de ambiente
  await Env.init();

  // Inicializa o Supabase com as variáveis de ambiente
  await Supabase.initialize(
    url: Env.supabaseUrl,
    anonKey: Env.supabaseAnonKey,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Aya',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.blue, width: 2),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LandingPage(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/plans': (context) => const PlansPage(),
        '/forgot': (context) => const ForgotPasswordPage(),
        '/profile': (context) => const UserProfileScreen(),
        // '/signup': (context) => const SignupScreen(), // será criado
        // '/plans': (context) => const PlansPage(), // será criado
      },
    );
  }
}
