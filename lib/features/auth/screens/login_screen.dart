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
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();
  bool _isLoading = false;

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

  Future<void> _handleLogin(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      try {
        // Store context before async operation
        final navigator = Navigator.of(context);
        final messenger = ScaffoldMessenger.of(context);

        // Perform login
        await Future.delayed(const Duration(seconds: 2)); // Simulated login

        // Use stored context references
        navigator.pushReplacementNamed('/home');
      } catch (e) {
        // Use stored context reference
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${e.toString()}')),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  Future<void> _handleGoogleSignIn() async {
    setState(() => _isLoading = true);
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
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
}
