import 'package:flutter/material.dart';

class AdminLogsSection extends StatelessWidget {
  const AdminLogsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Logs de Auditoria', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        const Text('Acompanhe ações administrativas importantes.'),
        const SizedBox(height: 32),
        // TODO: Listagem de logs de ações administrativas
        Container(
          height: 400,
          alignment: Alignment.center,
          child: const Text('Funcionalidade em desenvolvimento...'),
        ),
      ],
    );
  }
} 