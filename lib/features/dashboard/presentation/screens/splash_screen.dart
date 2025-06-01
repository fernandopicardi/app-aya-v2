import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:app/routes.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      // TODO: Implement proper auth check later
      // For now, navigate directly to home
      context.goNamed(AppRouteNames.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Implementar lógica de splash (verificar auth, carregar dados iniciais, etc.)
    // Por enquanto, apenas uma tela simples.
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 20),
            Text('App Aya', style: Theme.of(context).textTheme.headlineSmall),
            const Text('Carregando sua jornada...'),
          ],
        ),
      ),
    );
  }
}
