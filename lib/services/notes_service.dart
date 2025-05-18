import 'package:supabase_flutter/supabase_flutter.dart';

class NotesService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getNotes() async {
    final user = _supabase.auth.currentUser;
    if (user == null) throw Exception('Usuário não autenticado');
    final response = await _supabase
        .from('notes')
        .select('id, content_id, note_text, created_at, updated_at')
        .eq('user_id', user.id)
        .order('updated_at', ascending: false);
    return List<Map<String, dynamic>>.from(response);
  }

  Future<void> addNote(String contentId, String noteText) async {
    final user = _supabase.auth.currentUser;
    if (user == null) throw Exception('Usuário não autenticado');
    await _supabase.from('notes').insert({
      'user_id': user.id,
      'content_id': contentId,
      'note_text': noteText,
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    });
  }

  Future<void> updateNote(String noteId, String noteText) async {
    final user = _supabase.auth.currentUser;
    if (user == null) throw Exception('Usuário não autenticado');
    await _supabase
        .from('notes')
        .update({
          'note_text': noteText,
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('id', noteId)
        .eq('user_id', user.id);
  }

  Future<void> removeNote(String noteId) async {
    final user = _supabase.auth.currentUser;
    if (user == null) throw Exception('Usuário não autenticado');
    await _supabase
        .from('notes')
        .delete()
        .eq('id', noteId)
        .eq('user_id', user.id);
  }
}
