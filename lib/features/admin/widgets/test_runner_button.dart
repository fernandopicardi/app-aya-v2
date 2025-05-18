import 'package:flutter/material.dart';
import 'package:app_aya_v2/test/run_test.dart';

class TestRunnerButton extends StatelessWidget {
  const TestRunnerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        try {
          // Mostra um diálogo de carregamento
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Executando teste completo...'),
                ],
              ),
            ),
          );

          // Executa o teste
          await TestRunner.runFullTest();

          // Fecha o diálogo de carregamento
          if (context.mounted) {
            Navigator.of(context).pop();
          }

          // Mostra uma mensagem de sucesso
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Teste completo executado com sucesso!'),
                backgroundColor: Colors.green,
              ),
            );
          }
        } catch (e) {
          // Fecha o diálogo de carregamento
          if (context.mounted) {
            Navigator.of(context).pop();
          }

          // Mostra uma mensagem de erro
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Erro durante o teste: $e'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      },
      child: const Text('Executar Teste Completo'),
    );
  }
} 