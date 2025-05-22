import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb, kDebugMode;
import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// TODO: Reativar para implementação OAuth
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
// import 'dart:io' show Platform; // Não utilizado atualmente
import '../../../core/services/logging_service.dart';
import 'package:flutter/foundation.dart' show debugPrint;

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final _supabase = Supabase.instance.client;
  final _auth = Supabase.instance.client.auth;
  final _logger = LoggingService();
  StreamSubscription? _linkSubscription;
  // TODO: Reativar e utilizar para implementação OAuth
  // final _googleSignIn = GoogleSignIn(
  //   clientId: kIsWeb ? dotenv.env['GOOGLE_CLIENT_ID_WEB'] : null,
  //   serverClientId: kIsWeb ? dotenv.env['GOOGLE_CLIENT_ID_WEB'] : null,
  // );

  // Mock state
  final bool _mockIsAuthenticated = true;
  User? _mockUser;
  Session? _mockSession;
  final _authController = StreamController<AuthState>.broadcast();

  // Stream para o estado de autenticação
  Stream<AuthState> get authStateChanges {
    _logger.debug('AuthService: authStateChanges called');
    if (_mockIsAuthenticated && _mockSession != null) {
      return Stream.value(
          AuthState(AuthChangeEvent.initialSession, _mockSession));
    }
    return _authController.stream;
  }

  // Método para obter o usuário atual
  User? getCurrentUser() {
    _logger.debug('AuthService: getCurrentUser called');
    if (_mockIsAuthenticated) {
      if (_mockUser == null) {
        _mockUser = User(
          id: 'default_mock_user_id',
          appMetadata: {'provider': 'email'},
          userMetadata: {
            'username': 'mockUser',
            'role': 'user',
            'email': 'mock@example.com',
          },
          aud: 'authenticated',
          createdAt: DateTime.now().toIso8601String(),
        );
      }
      return _mockUser;
    }
    return _auth.currentUser;
  }

  // Método para cadastro com email e senha
  Future<User?> signUpWithEmailAndPassword({
    required String email,
    required String password,
    String? username,
    Map<String, dynamic>? userMetadata,
  }) async {
    _logger.debug('AuthService: signUpWithEmailAndPassword called');
    try {
      if (_mockIsAuthenticated) {
        _mockUser = User(
          id: 'mock_user_id_${DateTime.now().millisecondsSinceEpoch}',
          appMetadata: {'provider': 'email'},
          userMetadata: {
            ...?userMetadata,
            if (username != null) 'username': username,
            'email': email,
          },
          aud: 'authenticated',
          createdAt: DateTime.now().toIso8601String(),
        );
        _mockSession = Session(
          accessToken: 'mock_access_token',
          refreshToken: 'mock_refresh_token',
          tokenType: 'bearer',
          user: _mockUser!,
        );
        _authController.add(AuthState(AuthChangeEvent.signedIn, _mockSession));
        return _mockUser;
      }

      final AuthResponse response = await _auth.signUp(
        email: email,
        password: password,
        data: {
          ...?userMetadata,
          if (username != null) 'username': username,
        },
      );

      if (response.user == null) {
        throw Exception('Erro ao criar conta');
      }

      return response.user;
    } on AuthException catch (e) {
      _logger.error('AuthService signUp Error', e);
      throw Exception('Falha no cadastro: ${e.message}');
    } catch (e) {
      _logger.error('AuthService signUp Unexpected Error', e);
      throw Exception('Ocorreu um erro inesperado durante o cadastro.');
    }
  }

  // Método para login com email e senha
  Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    _logger.debug('AuthService: signInWithEmailAndPassword called');
    try {
      if (_mockIsAuthenticated) {
        final mockId =
            email == 'admin@aya.com' ? 'mock_admin_id' : 'mock_user_id_login';
        final mockRole = email == 'admin@aya.com' ? 'admin' : 'user';

        _mockUser = User(
          id: mockId,
          appMetadata: {'provider': 'email'},
          userMetadata: {
            'username': email.split('@')[0],
            'role': mockRole,
            'email': email,
          },
          aud: 'authenticated',
          createdAt: DateTime.now().toIso8601String(),
        );
        _mockSession = Session(
          accessToken: 'mock_access_token',
          refreshToken: 'mock_refresh_token',
          tokenType: 'bearer',
          user: _mockUser!,
        );
        _authController.add(AuthState(AuthChangeEvent.signedIn, _mockSession));
        return _mockUser;
      }

      final AuthResponse response = await _auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw Exception('Erro ao fazer login');
      }

      return response.user;
    } on AuthException catch (e) {
      _logger.error('AuthService signIn Error', e);
      throw Exception('Falha no login: ${e.message}');
    } catch (e) {
      _logger.error('AuthService signIn Unexpected Error', e);
      throw Exception('Ocorreu um erro inesperado durante o login.');
    }
  }

  // Método para enviar email de recuperação de senha
  Future<void> sendPasswordResetEmail({required String email}) async {
    debugPrint('AuthService: sendPasswordResetEmail called with email: $email');
    try {
      if (kDebugMode) {
        // Mock implementation for development
        await Future.delayed(const Duration(seconds: 1));
        debugPrint('Mock: Password reset email sent to $email');
        return;
      }

      // TODO: Implement real password reset email sending
      throw UnimplementedError(
          'Password reset email sending not implemented yet');
    } catch (e) {
      debugPrint('AuthService: Error sending password reset email: $e');
      rethrow;
    }
  }

  // Método para logout
  Future<void> signOut() async {
    _logger.debug('AuthService: signOut called');
    try {
      if (_mockIsAuthenticated) {
        _mockUser = null;
        _mockSession = null;
        _authController.add(AuthState(AuthChangeEvent.signedOut, null));
        return;
      }

      await _auth.signOut();
      _logger.info('AuthService: User signed out');
    } on AuthException catch (e) {
      _logger.error('AuthService signOut Error', e);
      throw Exception('Falha ao sair: ${e.message}');
    } catch (e) {
      _logger.error('AuthService signOut Unexpected Error', e);
      throw Exception('Ocorreu um erro inesperado ao sair.');
    }
  }

  // Método para login com Google
  Future<User?> signInWithGoogle() async {
    _logger.debug('AuthService: signInWithGoogle called');
    try {
      if (_mockIsAuthenticated) {
        _mockUser = User(
          id: 'mock_user_id_${DateTime.now().millisecondsSinceEpoch}',
          appMetadata: {},
          userMetadata: {
            'name': 'Usuário Google',
            'email': 'google.user@example.com',
          },
          aud: 'authenticated',
          createdAt: DateTime.now().toIso8601String(),
        );
        _mockSession = Session(
          accessToken: 'mock_access_token',
          refreshToken: 'mock_refresh_token',
          tokenType: 'bearer',
          user: _mockUser!,
        );
        _authController.add(AuthState(AuthChangeEvent.signedIn, _mockSession));
        return _mockUser;
      }

      if (kIsWeb) {
        final redirectUrl = dotenv.env['REDIRECT_URI_WEB'];
        await _auth.signInWithOAuth(
          OAuthProvider.google,
          redirectTo: redirectUrl,
        );
      } else {
        // TODO: Reativar e utilizar para implementação OAuth
        // final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
        // if (googleUser == null) return null;

        // final GoogleSignInAuthentication googleAuth =
        //     await googleUser.authentication;

        // final accessToken = googleAuth.accessToken;
        // final idToken = googleAuth.idToken;

        // if (accessToken == null || idToken == null) {
        //   throw Exception('No access token or id token found');
        // }

        // final AuthResponse response = await _auth.signInWithIdToken(
        //   provider: OAuthProvider.google,
        //   idToken: idToken,
        //   accessToken: accessToken,
        // );

        // return response.user;
      }
    } on AuthException catch (e) {
      _logger.error('AuthService signInWithGoogle Error', e);
      throw Exception('Falha no login com Google: ${e.message}');
    } catch (e) {
      _logger.error('AuthService signInWithGoogle Unexpected Error', e);
      throw Exception('Ocorreu um erro inesperado durante o login com Google.');
    }
  }

  // Método para login com Apple
  Future<User?> signInWithApple() async {
    _logger.debug('AuthService: signInWithApple called');
    try {
      if (_mockIsAuthenticated) {
        _mockUser = User(
          id: 'mock_user_id_${DateTime.now().millisecondsSinceEpoch}',
          appMetadata: {},
          userMetadata: {
            'name': 'Usuário Apple',
            'email': 'apple.user@example.com',
          },
          aud: 'authenticated',
          createdAt: DateTime.now().toIso8601String(),
        );
        _mockSession = Session(
          accessToken: 'mock_access_token',
          refreshToken: 'mock_refresh_token',
          tokenType: 'bearer',
          user: _mockUser!,
        );
        _authController.add(AuthState(AuthChangeEvent.signedIn, _mockSession));
        return _mockUser;
      }

      if (kIsWeb) {
        final redirectUrl = dotenv.env['REDIRECT_URI_WEB'];
        await _auth.signInWithOAuth(
          OAuthProvider.apple,
          redirectTo: redirectUrl,
        );
      } else {
        final credential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
        );

        final AuthResponse response = await _auth.signInWithIdToken(
          provider: OAuthProvider.apple,
          idToken: credential.identityToken!,
          accessToken: credential.authorizationCode,
        );

        return response.user;
      }
    } on AuthException catch (e) {
      _logger.error('AuthService signInWithApple Error', e);
      throw Exception('Falha no login com Apple: ${e.message}');
    } catch (e) {
      _logger.error('AuthService signInWithApple Unexpected Error', e);
      throw Exception('Ocorreu um erro inesperado durante o login com Apple.');
    }
  }

  // Método para obter o perfil do usuário atual
  Future<Map<String, dynamic>?> getCurrentUserProfile() async {
    _logger.debug('AuthService: getCurrentUserProfile called');
    try {
      if (_mockIsAuthenticated) {
        return {
          'id': _mockUser?.id ?? 'mock_user_id',
          'name': _mockUser?.userMetadata?['name'] ?? 'Usuário Teste',
          'email': _mockUser?.userMetadata?['email'] ?? 'test@example.com',
          'avatar_url': null,
          'role': 'user',
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        };
      }

      final user = getCurrentUser();
      if (user == null) return null;

      final response =
          await _supabase.from('profiles').select().eq('id', user.id).single();

      return response;
    } catch (e) {
      _logger.error('AuthService getCurrentUserProfile Error', e);
      return null;
    }
  }

  // Método para atualizar o perfil do usuário
  Future<void> updateUserProfile({
    required String name,
    String? avatarUrl,
  }) async {
    _logger.debug('AuthService: updateUserProfile called');
    try {
      if (_mockIsAuthenticated) {
        _mockUser = User(
          id: _mockUser?.id ?? 'mock_user_id',
          appMetadata: _mockUser?.appMetadata ?? {},
          userMetadata: {
            ...?_mockUser?.userMetadata,
            'name': name,
            if (avatarUrl != null) 'avatar_url': avatarUrl,
          },
          aud: 'authenticated',
          createdAt: _mockUser?.createdAt ?? DateTime.now().toIso8601String(),
        );
        return;
      }

      final user = getCurrentUser();
      if (user == null) {
        throw Exception('Usuário não autenticado');
      }

      await _supabase.from('profiles').update({
        'name': name,
        if (avatarUrl != null) 'avatar_url': avatarUrl,
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('id', user.id);
    } catch (e) {
      _logger.error('AuthService updateUserProfile Error', e);
      throw Exception('Erro ao atualizar perfil: $e');
    }
  }

  // Método para limpar recursos
  void dispose() {
    _linkSubscription?.cancel();
    _authController.close();
  }

  // Método para cadastro com email e senha
  Future<User?> register({
    required String email,
    required String password,
    String? name,
    String? username,
    Map<String, dynamic>? userMetadata,
  }) async {
    _logger.debug('AuthService: register called');
    return signUpWithEmailAndPassword(
      email: email,
      password: password,
      username: username,
      userMetadata: {
        ...?userMetadata,
        if (name != null) 'name': name,
      },
    );
  }
}
