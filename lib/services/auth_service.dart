import 'package:supabase_flutter/supabase_flutter.dart';
import '../core/services/logging_service.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final _supabase = Supabase.instance.client;
  final _logger = LoggingService();

  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw Exception('Falha no login: usuário não encontrado');
      }
    } catch (e) {
      throw Exception('Erro ao fazer login: $e');
    }
  }

  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required String name,
    String role = 'user', // Role padrão é 'user'
  }) async {
    AuthResponse? authResponse;
    try {
      authResponse = await _supabase.auth.signUp(
        email: email,
        password: password,
      );

      if (authResponse.user == null) {
        throw Exception('Falha no cadastro: não foi possível criar o usuário');
      }

      // Cria o perfil do usuário na tabela profiles
      await _supabase.from('profiles').insert({
        'id': authResponse.user!.id,
        'email': email,
        'name': name,
        'role': role,
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      // Se houver erro ao criar o perfil, tenta remover o usuário da auth
      if (authResponse?.user != null) {
        try {
          await _supabase.auth.admin.deleteUser(authResponse!.user!.id);
        } catch (_) {
          // Ignora erro ao tentar remover usuário
        }
      }
      throw Exception('Erro ao fazer cadastro: $e');
    }
  }

  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
    } catch (e) {
      throw Exception('Erro ao fazer logout: $e');
    }
  }

  User? get currentUser => _supabase.auth.currentUser;
  bool get isAuthenticated => currentUser != null;

  // Método para obter o perfil do usuário atual
  Future<Map<String, dynamic>?> getUserProfile() async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) {
        _logger.warning('Nenhum usuário autenticado');
        return null;
      }

      final response =
          await _supabase.from('profiles').select().eq('id', user.id).single();
      return response;
    } catch (e) {
      _logger.error('Erro ao obter perfil do usuário', e);
      rethrow;
    }
  }

  // Método para atualizar o perfil do usuário
  Future<void> updateUserProfile({
    required String name,
    String? avatarUrl,
  }) async {
    try {
      if (currentUser == null) {
        throw Exception('Usuário não autenticado');
      }

      await _supabase.from('profiles').update({
        'name': name,
        if (avatarUrl != null) 'avatar_url': avatarUrl,
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('id', currentUser!.id);
    } catch (e) {
      throw Exception('Erro ao atualizar perfil: $e');
    }
  }

  // Método para atualizar a role do usuário (apenas admin)
  Future<void> updateUserRole(String userId, String role) async {
    try {
      final profile = await getUserProfile();
      if (profile == null || profile['role'] != 'admin') {
        throw Exception('Apenas administradores podem alterar roles');
      }

      await _supabase.from('profiles').update({
        'role': role,
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('id', userId);
    } catch (e) {
      throw Exception('Erro ao atualizar role: $e');
    }
  }
}
