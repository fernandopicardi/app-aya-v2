import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ShareService {
  static final ShareService _instance = ShareService._internal();
  factory ShareService() => _instance;
  ShareService._internal();

  Future<void> shareLesson(String lessonId, String title) async {
    try {
      final url = 'https://app.aya.com.br/lesson/$lessonId';
      final text = 'Confira esta aula incrível: $title\n$url';
      await _shareText(text);
    } catch (e) {
      debugPrint('Erro ao compartilhar aula: $e');
      rethrow;
    }
  }

  Future<void> shareProfile(String userId, String name) async {
    try {
      final url = 'https://app.aya.com.br/profile/$userId';
      final text = 'Conheça o perfil de $name no Aya\n$url';
      await _shareText(text);
    } catch (e) {
      debugPrint('Erro ao compartilhar perfil: $e');
      rethrow;
    }
  }

  Future<void> shareAchievement(String achievementId, String title) async {
    try {
      final url = 'https://app.aya.com.br/achievement/$achievementId';
      final text = 'Conquistei: $title no Aya!\n$url';
      await _shareText(text);
    } catch (e) {
      debugPrint('Erro ao compartilhar conquista: $e');
      rethrow;
    }
  }

  Future<void> _shareText(String text) async {
    try {
      final uri = Uri.parse('mailto:?subject=Compartilhamento Aya&body=${Uri.encodeComponent(text)}');
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw Exception('Não foi possível abrir o aplicativo de e-mail');
      }
    } catch (e) {
      debugPrint('Erro ao compartilhar texto: $e');
      rethrow;
    }
  }
} 