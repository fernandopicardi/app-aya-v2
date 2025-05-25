import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'
    show kIsWeb, defaultTargetPlatform, TargetPlatform;
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Google Sign In Button
            ElevatedButton(
              onPressed: _handleGoogleSignIn,
              child: const Text('Entrar com Google'),
            ),
            const SizedBox(height: 16),
            // Apple Sign In Button (iOS/macOS only)
            if (!kIsWeb &&
                (defaultTargetPlatform == TargetPlatform.iOS ||
                    defaultTargetPlatform == TargetPlatform.macOS))
              ElevatedButton(
                onPressed: () async {
                  try {
                    final user = await _authService.signInWithApple();
                    if (user != null && mounted) {
                      // Navigate to dashboard or home screen
                      Navigator.pushReplacementNamed(context, '/dashboard');
                    }
                  } catch (e) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Erro no login: $e')),
                      );
                    }
                  }
                },
                child: const Text('Entrar com Apple'),
              ),
            const SizedBox(height: 16),
            // Show current user ID if logged in
            StreamBuilder(
              stream: _authService.authStateChanges,
              builder: (context, snapshot) {
                final user = _authService.getCurrentUser();
                if (user != null) {
                  return Text('Usuário logado: ${user.id}');
                }
                return const Text('Não logado');
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleGoogleSignIn() async {
    try {
      final navigator = Navigator.of(context);
      await _authService.signInWithGoogle();
      if (mounted) {
        navigator.pushReplacementNamed('/dashboard');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }
}
