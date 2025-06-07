import 'package:flutter/material.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import 'package:app/core/theme/app_dimensions.dart';
import 'package:go_router/go_router.dart';
import 'package:app/routes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.spacingLg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppDimensions.spacing2xl),
                Text(
                  'Bem-vinda de volta',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppDimensions.spacingMd),
                Text(
                  'Acesse sua conta para continuar sua jornada',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onSurface.withAlpha((255 * 0.7).round()),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppDimensions.spacing2xl),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Seu e-mail',
                    prefixIcon: iconoir.Mail(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        AppDimensions.borderRadiusMd,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        AppDimensions.borderRadiusMd,
                      ),
                      borderSide: BorderSide(
                        color: colorScheme.primary.withAlpha(
                          (255 * 0.5).round(),
                        ),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        AppDimensions.borderRadiusMd,
                      ),
                      borderSide: BorderSide(
                        color: colorScheme.primary,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppDimensions.spacingLg),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Sua senha',
                    prefixIcon: iconoir.Lock(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        AppDimensions.borderRadiusMd,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        AppDimensions.borderRadiusMd,
                      ),
                      borderSide: BorderSide(
                        color: colorScheme.primary.withAlpha(
                          (255 * 0.5).round(),
                        ),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        AppDimensions.borderRadiusMd,
                      ),
                      borderSide: BorderSide(
                        color: colorScheme.primary,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppDimensions.spacingSm),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // TODO: Implementar recuperação de senha
                    },
                    child: Text(
                      'Esqueci minha senha',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppDimensions.spacingLg),
                ElevatedButton(
                  onPressed: () {
                    // TODO: Implementar lógica de login
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppDimensions.spacingMd,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppDimensions.borderRadiusMd,
                      ),
                    ),
                  ),
                  child: const Text('Entrar'),
                ),
                const SizedBox(height: AppDimensions.spacing2xl),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: colorScheme.onSurface.withAlpha(
                          (255 * 0.2).round(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.spacingMd,
                      ),
                      child: Text(
                        'Ou entre com',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurface.withAlpha(
                            (255 * 0.7).round(),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: colorScheme.onSurface.withAlpha(
                          (255 * 0.2).round(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppDimensions.spacingLg),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        // TODO: Implementar login social
                      },
                      icon: const Icon(Icons.circle),
                    ),
                    const SizedBox(width: AppDimensions.spacingMd),
                    IconButton(
                      onPressed: () {
                        // TODO: Implementar login social
                      },
                      icon: const Icon(Icons.circle),
                    ),
                    const SizedBox(width: AppDimensions.spacingMd),
                    IconButton(
                      onPressed: () {
                        // TODO: Implementar login social
                      },
                      icon: const Icon(Icons.circle),
                    ),
                  ],
                ),
                const SizedBox(height: AppDimensions.spacingLg),
                TextButton(
                  onPressed: () {
                    context.goNamed(AppRouteNames.signup);
                  },
                  child: Text(
                    'Não tem uma conta? Crie aqui',
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
