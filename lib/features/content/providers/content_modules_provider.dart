import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_aya_v2/core/supabase_config.dart';
import 'package:app_aya_v2/features/content/models/content_module.dart';

final contentModulesProvider = StateNotifierProvider<ContentModulesNotifier, AsyncValue<List<ContentModule>>>((ref) {
  return ContentModulesNotifier();
});

class ContentModulesNotifier extends StateNotifier<AsyncValue<List<ContentModule>>> {
  ContentModulesNotifier() : super(const AsyncValue.loading()) {
    _loadModules();
  }

  Future<void> _loadModules() async {
    try {
      final modulesData = await SupabaseConfig.getContentModules();
      final modules = modulesData.map((data) => ContentModule.fromJson(data)).toList();
      state = AsyncValue.data(modules);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    await _loadModules();
  }
} 