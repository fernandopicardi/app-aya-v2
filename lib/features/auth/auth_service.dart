import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
// TODO: Reativar para implementação OAuth
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthService extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;
  // TODO: Will be used when implementing Google Sign In
  // ignore: unused_field
  final _googleSignIn = GoogleSignIn();
  User? _user;
  bool _isLoading = false;
  String? _error;

  AuthService() {
    _init();
  }

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => true; // Temporarily always return true

  // Stream para ouvir mudanças no estado de autenticação
  Stream<AuthState> get authStateChanges => _supabase.auth.onAuthStateChange;

  // Usuário atual
  User? get currentUser => _supabase.auth.currentUser;

  Future<void> _init() async {
    // Temporarily set a mock user
    _user = User(
      id: 'mock_user_id',
      appMetadata: {},
      userMetadata: {'name': 'Usuário Teste'},
      aud: 'authenticated',
      createdAt: DateTime.now().toIso8601String(),
    );
    notifyListeners();
  }

  // Keep all OAuth methods ready for future implementation
  Future<void> signInWithEmail(String email, String password) async {
    // Temporarily bypass authentication
    _user = User(
      id: 'mock_user_id',
      appMetadata: {},
      userMetadata: {'name': 'Usuário Teste'},
      aud: 'authenticated',
      createdAt: DateTime.now().toIso8601String(),
    );
    notifyListeners();
  }

  Future<void> signUpWithEmail(
      String email, String password, String name) async {
    // Temporarily bypass registration
    _user = User(
      id: 'mock_user_id',
      appMetadata: {},
      userMetadata: {'name': name},
      aud: 'authenticated',
      createdAt: DateTime.now().toIso8601String(),
    );
    notifyListeners();
  }

  Future<void> signInWithGoogle() async {
    // Temporarily bypass Google sign in
    _user = User(
      id: 'mock_user_id',
      appMetadata: {},
      userMetadata: {'name': 'Usuário Google'},
      aud: 'authenticated',
      createdAt: DateTime.now().toIso8601String(),
    );
    notifyListeners();
  }

  Future<void> signInWithApple() async {
    // Temporarily bypass Apple sign in
    _user = User(
      id: 'mock_user_id',
      appMetadata: {},
      userMetadata: {'name': 'Usuário Apple'},
      aud: 'authenticated',
      createdAt: DateTime.now().toIso8601String(),
    );
    notifyListeners();
  }

  Future<void> signOut() async {
    // Temporarily bypass sign out
    _user = null;
    notifyListeners();
  }

  Future<void> resetPassword(String email) async {
    // Temporarily bypass password reset
    notifyListeners();
  }

  Future<void> updatePassword(String newPassword) async {
    // Temporarily bypass password update
    notifyListeners();
  }

  Future<void> updateProfile({String? name, String? avatarUrl}) async {
    // Temporarily bypass profile update
    if (name != null) {
      _user = User(
        id: _user?.id ?? 'mock_user_id',
        appMetadata: _user?.appMetadata ?? {},
        userMetadata: {'name': name},
        aud: 'authenticated',
        createdAt: _user?.createdAt ?? DateTime.now().toIso8601String(),
      );
    }
    notifyListeners();
  }

  Future<void> deleteAccount() async {
    // Temporarily bypass account deletion
    _user = null;
    notifyListeners();
  }

  Future<Session?> getCurrentSession() async {
    // Return a mock session
    return Session(
      accessToken: 'mock_token',
      refreshToken: 'mock_refresh_token',
      tokenType: 'bearer',
      user: _user ??
          User(
            id: 'mock_user_id',
            appMetadata: {},
            userMetadata: {'name': 'Usuário Teste'},
            aud: 'authenticated',
            createdAt: DateTime.now().toIso8601String(),
          ),
    );
  }

  // Keep these methods ready for future implementation
  Future<String> uploadAvatar(Uint8List bytes, String fileName) async {
    return 'mock_avatar_url';
  }

  Future<Map<String, dynamic>?> getCurrentUserProfile() async {
    return {
      'id': _user?.id ?? 'mock_user_id',
      'name': _user?.userMetadata?['name'] ?? 'Usuário Teste',
      'avatar_url': null,
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    };
  }
}
