import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_aya_v2/config/theme.dart';
import 'package:app_aya_v2/features/content/providers/content_modules_provider.dart';
import 'package:app_aya_v2/features/content/models/content_module.dart';
import 'package:go_router/go_router.dart';
import 'package:app_aya_v2/config/routes.dart';

class ContentModulesPage extends ConsumerWidget {
  const ContentModulesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modulesAsync = ref.watch(contentModulesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Módulos'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.backgroundGradient,
        ),
        child: modulesAsync.when(
          data: (modules) => _buildModulesList(context, ref, modules),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(
            child: Text(
              'Erro ao carregar módulos: $error',
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildModulesList(BuildContext context, WidgetRef ref, List<ContentModule> modules) {
    if (modules.isEmpty) {
      return const Center(
        child: Text(
          'Nenhum módulo disponível no momento.',
          style: TextStyle(color: AppTheme.textPrimary),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(contentModulesProvider.notifier).refresh(),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: modules.length,
        itemBuilder: (context, index) {
          final module = modules[index];
          return _buildModuleCard(context, module);
        },
      ),
    );
  }

  Widget _buildModuleCard(BuildContext context, ContentModule module) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: AppTheme.secondary.withAlpha(77), // 0.3 * 255 ≈ 77
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () => context.push('${AppRouter.contentFolders}/${module.id}'),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                module.title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (module.description != null) ...[
                const SizedBox(height: 8),
                Text(
                  module.description!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textPrimary.withAlpha(204), // 0.8 * 255 ≈ 204
                  ),
                ),
              ],
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios),
                    color: AppTheme.textPrimary,
                    onPressed: () => context.push('${AppRouter.contentFolders}/${module.id}'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
} 