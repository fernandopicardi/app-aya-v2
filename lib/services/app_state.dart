import 'dart:async';
import 'package:flutter/material.dart';
import '../core/services/logging_service.dart';

class AppState extends ChangeNotifier {
  static final AppState _instance = AppState._internal();
  factory AppState() => _instance;
  AppState._internal();

  final _logger = LoggingService();

  // Stream controllers
  final _themeController = StreamController<ThemeMode>.broadcast();
  final _userController = StreamController<User?>.broadcast();
  final _pointsController = StreamController<int>.broadcast();

  // Estado inicial
  ThemeMode _themeMode = ThemeMode.system;
  User? _user;
  int _points = 0;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Getters para streams
  Stream<ThemeMode> get themeStream => _themeController.stream;
  Stream<User?> get userStream => _userController.stream;
  Stream<int> get pointsStream => _pointsController.stream;

  // Getters para estado atual
  ThemeMode get themeMode => _themeMode;
  User? get user => _user;
  int get points => _points;

  // Métodos para tema
  Future<void> setThemeMode(ThemeMode mode) async {
    try {
      // TODO: Persistir preferência do usuário
      _themeMode = mode;
      _themeController.add(_themeMode);
      _logger.info('Theme mode changed to: ${mode.name}');
    } catch (e, stackTrace) {
      _logger.error('Error setting theme mode', e, stackTrace);
      rethrow;
    }
  }

  // Métodos para usuário
  Future<void> login(String email, String password) async {
    try {
      // TODO: Implementar autenticação
      _user = User(
        id: 'user_id',
        name: 'Usuário Teste',
        email: email,
        avatar: 'assets/images/user1.jpg',
      );
      _userController.add(_user);
      _logger.info('User logged in: ${_user?.email}');
    } catch (e, stackTrace) {
      _logger.error('Error during login', e, stackTrace);
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      // TODO: Implementar logout
      final email = _user?.email;
      _user = null;
      _userController.add(_user);
      _logger.info('User logged out: $email');
    } catch (e, stackTrace) {
      _logger.error('Error during logout', e, stackTrace);
      rethrow;
    }
  }

  Future<void> updateProfile(Map<String, dynamic> profile) async {
    try {
      // TODO: Implementar atualização do perfil
      _logger.info('Perfil atualizado com sucesso');
    } catch (e) {
      _logger.error('Erro ao atualizar perfil', e);
      rethrow;
    }
  }

  // Métodos para pontos
  Future<void> addPoints(int points) async {
    try {
      // TODO: Implementar adição de pontos
      _points += points;
      _pointsController.add(_points);
      _logger.info('Pontos adicionados com sucesso: $points');
    } catch (e) {
      _logger.error('Erro ao adicionar pontos', e);
      rethrow;
    }
  }

  Future<void> removePoints(int points) async {
    try {
      // TODO: Implementar remoção de pontos
      _points = (_points - points).clamp(0, double.infinity).toInt();
      _pointsController.add(_points);
      _logger.info('Pontos removidos com sucesso: $points');
    } catch (e) {
      _logger.error('Erro ao remover pontos', e);
      rethrow;
    }
  }

  // Limpeza
  @override
  void dispose() {
    _themeController.close();
    _userController.close();
    _pointsController.close();
    super.dispose();
  }

  void setLoading(bool value) {
    _isLoading = value;
    _logger.info('Estado de carregamento alterado: $value');
    notifyListeners();
  }

  void showError(String message) {
    _logger.error('Erro na aplicação: $message');
    // TODO: Implementar exibição de erro na UI
  }

  void showSuccess(String message) {
    _logger.info('Sucesso na aplicação: $message');
    // TODO: Implementar exibição de sucesso na UI
  }
}

class User {
  final String id;
  final String name;
  final String email;
  final String avatar;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.avatar,
  });

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? avatar,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
    );
  }
}
