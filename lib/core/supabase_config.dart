import 'package:supabase_flutter/supabase_flutter.dart';

/// Classe de configuração para o Supabase
class SupabaseConfig {
  // Constantes para configuração do Supabase
  static const String supabaseUrl = 'https://qgtatnghjavytyvzgbpr.supabase.co';
  static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFndGF0bmdoamF2eXR5dnpnYnByIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDc0NDU3NzQsImV4cCI6MjA2MzAyMTc3NH0.Tw91nMvdahw4GaKpgdyk_HjOzVkFUXr5PPv4JjnLD70';
  
  // Cliente Supabase para acesso global
  static final SupabaseClient client = Supabase.instance.client;
  
  // Métodos de autenticação
  
  /// Login com email e senha
  static Future<AuthResponse> signInWithEmail({
    required String email,
    required String password,
  }) async {
    return await client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }
  
  /// Registro com email e senha
  static Future<AuthResponse> signUpWithEmail({
    required String email,
    required String password,
    Map<String, dynamic>? userData,
  }) async {
    return await client.auth.signUp(
      email: email,
      password: password,
      data: userData,
    );
  }
  
  /// Logout
  static Future<void> signOut() async {
    await client.auth.signOut();
  }
  
  /// Verificar se o usuário está autenticado
  static bool isAuthenticated() {
    return client.auth.currentUser != null;
  }
  
  /// Obter usuário atual
  static User? getCurrentUser() {
    return client.auth.currentUser;
  }
  
  /// Obter sessão atual
  static Session? getCurrentSession() {
    return client.auth.currentSession;
  }

  // Métodos para perfis de usuário
  
  /// Obter perfil do usuário atual
  static Future<Map<String, dynamic>?> getCurrentProfile() async {
    final user = getCurrentUser();
    if (user == null) return null;
    
    final response = await client
        .from('profiles')
        .select()
        .eq('id', user.id)
        .single();
    
    return response;
  }
  
  /// Atualizar perfil do usuário
  static Future<void> updateProfile(Map<String, dynamic> data) async {
    final user = getCurrentUser();
    if (user == null) throw Exception('Usuário não autenticado');
    
    await client
        .from('profiles')
        .update(data)
        .eq('id', user.id);
  }

  // Métodos para conteúdo
  
  /// Obter todos os módulos de conteúdo
  static Future<List<Map<String, dynamic>>> getContentModules() async {
    final response = await client
        .from('content_modules')
        .select()
        .order('order');
    
    return List<Map<String, dynamic>>.from(response);
  }
  
  /// Obter pastas de um módulo
  static Future<List<Map<String, dynamic>>> getContentFolders(String moduleId) async {
    final response = await client
        .from('content_folders')
        .select()
        .eq('module_id', moduleId)
        .order('order_index');
    
    return List<Map<String, dynamic>>.from(response);
  }
  
  /// Obter aulas de uma pasta
  static Future<List<Map<String, dynamic>>> getContentLessons(String folderId) async {
    final response = await client
        .from('content_lessons')
        .select()
        .eq('folder_id', folderId)
        .order('order_index');
    
    return List<Map<String, dynamic>>.from(response);
  }
}