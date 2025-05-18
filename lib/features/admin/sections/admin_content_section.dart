import 'package:flutter/material.dart';

class AdminContentSection extends StatelessWidget {
  const AdminContentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Conteúdo', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        const Text('Gerencie módulos, pastas e aulas aqui.'),
        const SizedBox(height: 32),
        // TODO: Listagem e CRUD de módulos, pastas e aulas
        Center(child: Text('Funcionalidade em desenvolvimento...')),
      ],
    );
  }
} 