import 'package:app/core/theme/app_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:app/routes.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Conta'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.goNamed(AppRouteNames.login);
            }
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.spacingLg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: AppDimensions.spacingLg),
                Text(
                  'Crie sua conta Aya',
                  style: theme.textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppDimensions.spacingMd),
                Text(
                  'Preencha os campos abaixo para iniciar sua jornada.',
                  style: theme.textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppDimensions.spacing2xl),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Nome completo'),
                ),
                const SizedBox(height: AppDimensions.spacingLg),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Seu melhor e-mail',
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: AppDimensions.spacingLg),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Crie uma senha forte',
                  ),
                ),
                const SizedBox(height: AppDimensions.spacingLg),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Confirme sua senha',
                  ),
                ),
                const SizedBox(height: AppDimensions.spacing2xl),
                ElevatedButton(
                  onPressed: () {
                    // TODO: Implementar lógica de cadastro
                  },
                  child: const Text('Criar Minha Conta'),
                ),
                const SizedBox(height: AppDimensions.spacingLg),
                TextButton(
                  onPressed: () {
                    context.goNamed(AppRouteNames.login);
                  },
                  child: Text(
                    'Já tem uma conta? Entre aqui',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
