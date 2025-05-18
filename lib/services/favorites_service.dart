import 'package:supabase_flutter/supabase_flutter.dart';

class FavoritesService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getFavorites() async {
    final user = _supabase.auth.currentUser;
    if (user == null) throw Exception('Usuário não autenticado');
    final response = await _supabase
        .from('favorites')
        .select('id, content_id, created_at')
        .eq('user_id', user.id)
        .order('created_at', ascending: false);
    return List<Map<String, dynamic>>.from(response);
  }

  Future<void> addFavorite(String contentId) async {
    final user = _supabase.auth.currentUser;
    if (user == null) throw Exception('Usuário não autenticado');
    await _supabase.from('favorites').insert({
      'user_id': user.id,
      'content_id': contentId,
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  Future<void> removeFavorite(String favoriteId) async {
    final user = _supabase.auth.currentUser;
    if (user == null) throw Exception('Usuário não autenticado');
    await _supabase
        .from('favorites')
        .delete()
        .eq('id', favoriteId)
        .eq('user_id', user.id);
  }
}
