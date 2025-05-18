import 'package:supabase_flutter/supabase_flutter.dart';

class DashboardService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<Map<String, dynamic>> getDashboardData() async {
    final user = _supabase.auth.currentUser;
    if (user == null) throw Exception('Usuário não autenticado');
    final response = await _supabase
        .from('dashboard')
        .select('total_views, total_likes, total_comments, recent_activity')
        .eq('user_id', user.id)
        .single();
    return response;
  }
}
