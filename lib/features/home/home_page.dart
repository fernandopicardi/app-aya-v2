import 'package:flutter/material.dart';
import 'package:app_aya_v2/config/theme.dart';
import 'package:app_aya_v2/shared/widgets/gradient_button.dart';
import 'package:go_router/go_router.dart';
import 'package:app_aya_v2/config/routes.dart';
import 'package:app_aya_v2/core/supabase_config.dart';

/// Página inicial do aplicativo
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> _testSupabaseConnection(BuildContext context) async {
    try {
      final modules = await SupabaseConfig.getContentModules();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Conexão bem sucedida! Módulos encontrados: ${modules.length}'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro na conexão: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            color: AppTheme.secondary.withOpacity(0.95),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Logo
                Row(
                  children: [
                    Icon(Icons.spa, color: AppTheme.primary, size: 32),
                    const SizedBox(width: 8),
                    Text(
                      'App Aya',
                      style: TextStyle(
                        color: AppTheme.textPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
                // Menu
                Row(
                  children: [
                    _HeaderButton(
                      label: 'Início',
                      onTap: () {},
                      selected: true,
                    ),
                    _HeaderButton(
                      label: 'Comunidade',
                      onTap: () {},
                    ),
                    _HeaderButton(
                      label: 'Buscar',
                      onTap: () {},
                    ),
                    const SizedBox(width: 8),
                    GradientButton(
                      text: 'Entrar',
                      height: 36,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      onPressed: () {
                        context.push(AppRouter.login);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Banner
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 32),
                  // Banner com imagem e texto
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: AppTheme.secondary.withOpacity(0.2),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Imagem (placeholder)
                          Container(
                            width: 220,
                            height: 220,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              image: const DecorationImage(
                                image: AssetImage('assets/images/banner_gorilla.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 24),
                          // Texto de destaque
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'App Aya',
                                  style: TextStyle(
                                    color: AppTheme.textPrimary,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Aprenda a construir hábitos saudáveis para alcançar um futuro com saúde física e mental',
                                  style: TextStyle(
                                    color: AppTheme.textPrimary.withOpacity(0.9),
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Card de chamada
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: AppTheme.secondary.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bem vindo(a)',
                            style: TextStyle(
                              color: AppTheme.textPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Aprenda a construir hábitos saudáveis para alcançar um futuro com saúde física e mental',
                            style: TextStyle(
                              color: AppTheme.textPrimary.withOpacity(0.9),
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              GradientButton(
                                text: 'Assine o App Aya!',
                                onPressed: () {},
                                height: 44,
                                padding: const EdgeInsets.symmetric(horizontal: 24),
                              ),
                              const SizedBox(width: 16),
                              OutlinedButton(
                                onPressed: () {
                                  context.push(AppRouter.login);
                                },
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(color: AppTheme.primary, width: 2),
                                  foregroundColor: AppTheme.primary,
                                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Espaço para cards de módulos ou outras seções futuras
                  // ...
                  const SizedBox(height: 32),
                  // Rodapé
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Text(
                      'Criado com ♥ por App Aya',
                      style: TextStyle(
                        color: AppTheme.textPrimary.withOpacity(0.7),
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool selected;
  const _HeaderButton({required this.label, required this.onTap, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          label,
          style: TextStyle(
            color: selected ? AppTheme.primary : AppTheme.textPrimary.withOpacity(0.8),
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}