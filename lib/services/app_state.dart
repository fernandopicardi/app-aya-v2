import 'dart:async';
import 'package:flutter/material.dart';

class AppState {
  static final AppState _instance = AppState._internal();
  factory AppState() => _instance;
  AppState._internal();

  // Stream controllers
  final _themeController = StreamController<ThemeMode>.broadcast();
  final _userController = StreamController<User?>.broadcast();
  final _pointsController = StreamController<int>.broadcast();

  // Estado inicial
  ThemeMode _themeMode = ThemeMode.system;
  User? _user;
  int _points = 0;

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
    } catch (e) {
      debugPrint('Erro ao definir tema: $e');
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
    } catch (e) {
      debugPrint('Erro ao fazer login: $e');
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      // TODO: Implementar logout
      _user = null;
      _userController.add(_user);
    } catch (e) {
      debugPrint('Erro ao fazer logout: $e');
      rethrow;
    }
  }

  Future<void> updateProfile(String name, String? avatar) async {
    try {
      if (_user != null) {
        // TODO: Implementar atualização de perfil
        _user = _user!.copyWith(
          name: name,
          avatar: avatar ?? _user!.avatar,
        );
        _userController.add(_user);
      }
    } catch (e) {
      debugPrint('Erro ao atualizar perfil: $e');
      rethrow;
    }
  }

  // Métodos para pontos
  Future<void> addPoints(int amount) async {
    try {
      // TODO: Implementar persistência de pontos
      _points += amount;
      _pointsController.add(_points);
    } catch (e) {
      debugPrint('Erro ao adicionar pontos: $e');
      rethrow;
    }
  }

  Future<void> removePoints(int amount) async {
    try {
      // TODO: Implementar persistência de pontos
      _points = (_points - amount).clamp(0, double.infinity).toInt();
      _pointsController.add(_points);
    } catch (e) {
      debugPrint('Erro ao remover pontos: $e');
      rethrow;
    }
  }

  // Limpeza
  void dispose() {
    _themeController.close();
    _userController.close();
    _pointsController.close();
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
