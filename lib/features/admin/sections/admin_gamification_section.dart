import 'package:flutter/material.dart';

class AdminGamificationSection extends StatelessWidget {
  const AdminGamificationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Gamificação', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        const Text('Gerencie desafios e badges.'),
        const SizedBox(height: 32),
        // TODO: Listagem e CRUD de desafios e badges
        Container(
          height: 400,
          alignment: Alignment.center,
          child: const Text('Funcionalidade em desenvolvimento...'),
        ),
      ],
    );
  }
} 