// App Widget - Root widget of the MaterialApp

import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Aya', // Provisório, será configurado com o tema depois
      debugShowCheckedModeBanner: false, // Vamos remover o banner de debug
      home: Scaffold(
        // Placeholder para a tela inicial
        appBar: AppBar(title: const Text('App Aya - Carregando...')),
        body: const Center(child: Text('Bem-vindo ao App Aya!')),
      ),
      // routerConfig: goRouterProvider, // Será adicionado depois
    );
  }
}
