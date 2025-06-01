import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

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
