import 'package:flutter/material.dart';

class AdminModerationSection extends StatelessWidget {
  const AdminModerationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Moderação', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        const Text('Gerencie comentários e posts da comunidade.'),
        const SizedBox(height: 32),
        // TODO: Listagem e moderação de comentários/posts
        Center(child: Text('Funcionalidade em desenvolvimento...')),
      ],
    );
  }
} 