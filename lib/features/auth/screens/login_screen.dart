import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'
    show kIsWeb, defaultTargetPlatform, TargetPlatform;
import '../services/auth_service.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Google Sign In Button
            ElevatedButton(
              onPressed: () async {
                try {
                  final user = await authService.signInWithGoogle();
                  if (user != null) {
                    // Navigate to dashboard or home screen
                    Navigator.pushReplacementNamed(context, '/dashboard');
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Erro no login: $e')),
                  );
                }
              },
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
                    final user = await authService.signInWithApple();
                    if (user != null) {
                      // Navigate to dashboard or home screen
                      Navigator.pushReplacementNamed(context, '/dashboard');
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Erro no login: $e')),
                    );
                  }
                },
                child: const Text('Entrar com Apple'),
              ),
            const SizedBox(height: 16),
            // Show current user ID if logged in
            StreamBuilder(
              stream: authService.authStateChanges,
              builder: (context, snapshot) {
                final user = authService.getCurrentUser();
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
}
