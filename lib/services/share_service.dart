// import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:share_plus/share_plus.dart'; // TODO: Reativar para implementação de compartilhamento
import '../core/services/logging_service.dart';

class ShareService {
  static final ShareService _instance = ShareService._internal();
  factory ShareService() => _instance;
  ShareService._internal();

  final _logger = LoggingService();

  Future<void> shareLesson(String lessonId, String title) async {
    try {
      final text =
          'Confira esta aula: $title\n\nLink: https://app.aya.com.br/lessons/$lessonId';
      await _shareText(text);
    } catch (e) {
      _logger.error('Erro ao compartilhar aula', e);
      rethrow;
    }
  }

  Future<void> shareProfile(String userId, String username) async {
    try {
      final text =
          'Conheça o perfil de $username\n\nLink: https://app.aya.com.br/profile/$userId';
      await _shareText(text);
    } catch (e) {
      _logger.error('Erro ao compartilhar perfil', e);
      rethrow;
    }
  }

  Future<void> shareAchievement(String achievementId, String title) async {
    try {
      final text =
          'Conquista desbloqueada: $title\n\nLink: https://app.aya.com.br/achievements/$achievementId';
      await _shareText(text);
    } catch (e) {
      _logger.error('Erro ao compartilhar conquista', e);
      rethrow;
    }
  }

  Future<void> _shareText(String text) async {
    try {
      final url = Uri.parse('https://wa.me/?text=${Uri.encodeComponent(text)}');
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw Exception('Não foi possível abrir o WhatsApp');
      }
    } catch (e) {
      _logger.error('Erro ao compartilhar texto', e);
      rethrow;
    }
  }

  // TODO: Reimplementar funcionalidade de compartilhamento com share_plus
  Future<void> shareFile(String filePath) async {
    _logger.info(
        'Funcionalidade de compartilhamento de arquivo temporariamente desabilitada');
    // Implementação futura com share_plus
  }

  // TODO: Reimplementar funcionalidade de compartilhamento com share_plus
  Future<void> shareMultipleFiles(List<String> filePaths) async {
    _logger.info(
        'Funcionalidade de compartilhamento de múltiplos arquivos temporariamente desabilitada');
    // Implementação futura com share_plus
  }

  // TODO: Reimplementar funcionalidade de compartilhamento com share_plus
  Future<void> shareWithResult(String text) async {
    _logger.info(
        'Funcionalidade de compartilhamento com resultado temporariamente desabilitada');
    // Implementação futura com share_plus
  }
}
