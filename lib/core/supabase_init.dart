import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app_aya_v2/core/supabase_config.dart';

/// Classe responsável por inicializar o Supabase
class SupabaseInit {
  /// Inicializa o Supabase com as credenciais configuradas
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: SupabaseConfig.supabaseUrl,
      anonKey: SupabaseConfig.supabaseAnonKey,
    );
  }
} 