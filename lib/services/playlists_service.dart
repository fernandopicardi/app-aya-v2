import 'package:supabase_flutter/supabase_flutter.dart';

class PlaylistsService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getPlaylists() async {
    final user = _supabase.auth.currentUser;
    if (user == null) throw Exception('Usuário não autenticado');
    final response = await _supabase
        .from('playlists')
        .select('id, name, description, created_at, updated_at')
        .eq('user_id', user.id)
        .order('updated_at', ascending: false);
    return List<Map<String, dynamic>>.from(response);
  }

  Future<void> addPlaylist(String name, String description) async {
    final user = _supabase.auth.currentUser;
    if (user == null) throw Exception('Usuário não autenticado');
    await _supabase.from('playlists').insert({
      'user_id': user.id,
      'name': name,
      'description': description,
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    });
  }

  Future<void> updatePlaylist(
      String playlistId, String name, String description) async {
    final user = _supabase.auth.currentUser;
    if (user == null) throw Exception('Usuário não autenticado');
    await _supabase
        .from('playlists')
        .update({
          'name': name,
          'description': description,
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('id', playlistId)
        .eq('user_id', user.id);
  }

  Future<void> removePlaylist(String playlistId) async {
    final user = _supabase.auth.currentUser;
    if (user == null) throw Exception('Usuário não autenticado');
    await _supabase
        .from('playlists')
        .delete()
        .eq('id', playlistId)
        .eq('user_id', user.id);
  }
}
