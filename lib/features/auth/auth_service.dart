import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show OAuthProvider;

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Stream para ouvir mudanças no estado de autenticação
  Stream<AuthState> get authStateChanges => _supabase.auth.onAuthStateChange;

  // Usuário atual
  User? get currentUser => _supabase.auth.currentUser;

  // Método de Login
  Future<AuthResponse> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return response;
    } on AuthException catch (e) {
      // Considerar logar o erro ou retornar uma mensagem mais amigável
      // print('AuthService SignIn Error: ${e.message}');
      throw Exception('Falha no login: ${e.message}');
    } catch (e) {
      // print('AuthService SignIn Unexpected Error: $e');
      throw Exception('Ocorreu um erro inesperado durante o login.');
    }
  }

  // Método de Cadastro
  Future<AuthResponse> signUpWithEmailAndPassword({
    required String email,
    required String password,
    Map<String, dynamic>? data, // Para dados adicionais como nome, etc.
  }) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: data,
      );
      return response;
    } on AuthException catch (e) {
      // print('AuthService SignUp Error: ${e.message}');
      throw Exception('Falha no cadastro: ${e.message}');
    } catch (e) {
      // print('AuthService SignUp Unexpected Error: $e');
      throw Exception('Ocorreu um erro inesperado durante o cadastro.');
    }
  }

  // Método de Logout
  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
    } catch (e) {
      // print('AuthService SignOut Error: $e');
      throw Exception('Ocorreu um erro ao tentar sair.');
    }
  }

  // Método para enviar e-mail de redefinição de senha
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _supabase.auth.resetPasswordForEmail(email);
    } on AuthException catch (e) {
      throw Exception('Falha ao enviar e-mail de redefinição: ${e.message}');
    } catch (e) {
      throw Exception('Ocorreu um erro inesperado ao tentar enviar o e-mail de redefinição.');
    }
  }

  // Login com Google
  Future<AuthResponse?> signInWithGoogle() async {
    try {
      await _supabase.auth.signInWithOAuth(
        OAuthProvider.google,
      );
      return null; // OAuth flow will handle the redirect
    } on AuthException catch (e) {
      throw Exception('Falha no login com Google: ${e.message}');
    } catch (e) {
      throw Exception('Ocorreu um erro inesperado durante o login com Google.');
    }
  }

  // Login com Apple
  Future<AuthResponse?> signInWithApple() async {
    try {
      await _supabase.auth.signInWithOAuth(
        OAuthProvider.apple,
      );
      return null; // OAuth flow will handle the redirect
    } on AuthException catch (e) {
      throw Exception('Falha no login com Apple: ${e.message}');
    } catch (e) {
      throw Exception('Ocorreu um erro inesperado durante o login com Apple.');
    }
  }

  // TODO: Implementar outros métodos de autenticação se necessário (ex: Google, Apple)
}