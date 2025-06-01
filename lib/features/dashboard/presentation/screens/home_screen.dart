import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Aya - Início')),
      body: const Center(child: Text('Conteúdo da Home Screen')),
    );
  }
}
