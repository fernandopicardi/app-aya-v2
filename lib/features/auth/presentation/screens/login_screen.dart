import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Implementar UI de Login real
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Bem-vindo(a) ao App Aya',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              // Placeholder para campos de email/senha e botões
              const Text('Formulário de Login Aqui'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // TODO: Lógica de login
                },
                child: const Text('Entrar'),
              ),
              TextButton(
                onPressed: () {
                  // TODO: Navegar para tela de cadastro
                },
                child: const Text('Criar Conta'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
