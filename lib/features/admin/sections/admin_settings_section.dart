import 'package:flutter/material.dart';

class AdminSettingsSection extends StatelessWidget {
  const AdminSettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Configurações', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        const Text('Ajuste parâmetros globais da plataforma.'),
        const SizedBox(height: 32),
        // TODO: Configurações globais do app
        Container(
          height: 400,
          alignment: Alignment.center,
          child: const Text('Funcionalidade em desenvolvimento...'),
        ),
      ],
    );
  }
} 