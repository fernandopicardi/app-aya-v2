import 'dart:io';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app_aya_v2/services/storage_path_service.dart';
import 'package:path/path.dart' as path;

class UploadService {
  static final UploadService _instance = UploadService._internal();
  factory UploadService() => _instance;
  UploadService._internal();

  final _supabase = Supabase.instance.client;
  final _storagePath = StoragePathService();

  // Método para fazer upload de conteúdo de aula
  Future<String> uploadLessonContent({
    required String moduleId,
    required String lessonId,
    required File file,
    String? folderId,
    String? subfolderId,
    String fileType = StoragePathService.fileTypeVideo,
    String? fileName,
    void Function(double)? onProgress,
  }) async {
    try {
      final path = _storagePath.buildLessonContentPath(
        moduleId: moduleId,
        lessonId: lessonId,
        folderId: folderId,
        subfolderId: subfolderId,
        fileType: fileType,
      );

      final response = await _supabase.storage
          .from(StoragePathService.bucketContent)
          .uploadBinary(
            path,
            await file.readAsBytes(),
            fileOptions: FileOptions(
              contentType: _getContentType(fileType),
            ),
          );

      return response;
    } catch (e) {
      debugPrint('Erro ao fazer upload do conteúdo da aula: $e');
      rethrow;
    }
  }

  // Método para fazer upload de thumbnail de aula
  Future<String> uploadLessonThumbnail({
    required String moduleId,
    required String lessonId,
    required File file,
    String? folderId,
    String? subfolderId,
    void Function(double)? onProgress,
  }) async {
    try {
      final path = _storagePath.buildLessonThumbnailPath(
        moduleId: moduleId,
        lessonId: lessonId,
        folderId: folderId,
        subfolderId: subfolderId,
      );

      final response = await _supabase.storage
          .from(StoragePathService.bucketContent)
          .uploadBinary(
            path,
            await file.readAsBytes(),
            fileOptions: FileOptions(
              contentType: 'image/jpeg',
            ),
          );

      return response;
    } catch (e) {
      debugPrint('Erro ao fazer upload do thumbnail da aula: $e');
      rethrow;
    }
  }

  // Método para fazer upload de capa de módulo
  Future<String> uploadModuleCover({
    required String moduleId,
    required File file,
    void Function(double)? onProgress,
  }) async {
    try {
      final path = 'modules/$moduleId/cover.jpg';
      final response = await _supabase.storage
          .from(StoragePathService.bucketContent)
          .uploadBinary(
            path,
            await file.readAsBytes(),
            fileOptions: FileOptions(
              contentType: 'image/jpeg',
            ),
          );

      return response;
    } catch (e) {
      debugPrint('Erro ao fazer upload da capa do módulo: $e');
      rethrow;
    }
  }

  // Método para fazer upload de capa de pasta
  Future<String> uploadFolderCover({
    required String moduleId,
    required String folderId,
    required File file,
    void Function(double)? onProgress,
  }) async {
    try {
      final path = 'modules/$moduleId/folders/$folderId/cover.jpg';
      final response = await _supabase.storage
          .from(StoragePathService.bucketContent)
          .uploadBinary(
            path,
            await file.readAsBytes(),
            fileOptions: FileOptions(
              contentType: 'image/jpeg',
            ),
          );

      return response;
    } catch (e) {
      debugPrint('Erro ao fazer upload da capa da pasta: $e');
      rethrow;
    }
  }

  // Método para fazer upload de capa de subpasta
  Future<String> uploadSubfolderCover({
    required String moduleId,
    required String folderId,
    required String subfolderId,
    required File file,
    void Function(double)? onProgress,
  }) async {
    try {
      final path =
          'modules/$moduleId/folders/$folderId/subfolders/$subfolderId/cover.jpg';
      final response = await _supabase.storage
          .from(StoragePathService.bucketContent)
          .uploadBinary(
            path,
            await file.readAsBytes(),
            fileOptions: FileOptions(
              contentType: 'image/jpeg',
            ),
          );

      return response;
    } catch (e) {
      debugPrint('Erro ao fazer upload da capa da subpasta: $e');
      rethrow;
    }
  }

  // Método para fazer upload de avatar do usuário
  Future<String> uploadUserAvatar({
    required String userId,
    required File file,
    void Function(double)? onProgress,
  }) async {
    try {
      final path = '$userId/avatar.jpg';
      final response = await _supabase.storage
          .from(StoragePathService.bucketUserAvatars)
          .uploadBinary(
            path,
            await file.readAsBytes(),
            fileOptions: FileOptions(
              contentType: 'image/jpeg',
            ),
          );

      return response;
    } catch (e) {
      debugPrint('Erro ao fazer upload do avatar do usuário: $e');
      rethrow;
    }
  }

  // Método para fazer upload de ícone de badge
  Future<String> uploadBadgeIcon({
    required String badgeId,
    required File file,
    void Function(double)? onProgress,
  }) async {
    try {
      final path = '$badgeId/icon.svg';
      final response = await _supabase.storage
          .from(StoragePathService.bucketBadgeIcons)
          .uploadBinary(
            path,
            await file.readAsBytes(),
            fileOptions: FileOptions(
              contentType: 'image/svg+xml',
            ),
          );

      return response;
    } catch (e) {
      debugPrint('Erro ao fazer upload do ícone do badge: $e');
      rethrow;
    }
  }

  // Método para obter o content type baseado no tipo de arquivo
  String _getContentType(String fileType) {
    switch (fileType) {
      case StoragePathService.fileTypeVideo:
        return 'video/mp4';
      case StoragePathService.fileTypeAudio:
        return 'audio/mpeg';
      case StoragePathService.fileTypePDF:
        return 'application/pdf';
      case StoragePathService.fileTypeImage:
        return 'image/jpeg';
      default:
        return 'application/octet-stream';
    }
  }

  // Método para validar arquivo antes do upload
  Future<bool> validateFile({
    required File file,
    required String fileType,
    int? maxSizeInBytes,
  }) async {
    try {
      // Verifica se o arquivo existe
      if (!await file.exists()) {
        throw Exception('Arquivo não encontrado');
      }

      // Verifica o tamanho do arquivo
      if (maxSizeInBytes != null) {
        final fileSize = await file.length();
        if (fileSize > maxSizeInBytes) {
          throw Exception(
              'Arquivo muito grande. Tamanho máximo: ${maxSizeInBytes ~/ (1024 * 1024)}MB');
        }
      }

      // Verifica a extensão do arquivo
      final extension = path.extension(file.path).toLowerCase();
      switch (fileType) {
        case StoragePathService.fileTypeVideo:
          if (!['.mp4', '.mov', '.avi'].contains(extension)) {
            throw Exception('Formato de vídeo não suportado');
          }
          break;
        case StoragePathService.fileTypeAudio:
          if (!['.mp3', '.wav', '.ogg'].contains(extension)) {
            throw Exception('Formato de áudio não suportado');
          }
          break;
        case StoragePathService.fileTypePDF:
          if (extension != '.pdf') {
            throw Exception('Formato de PDF não suportado');
          }
          break;
        case StoragePathService.fileTypeImage:
          if (!['.jpg', '.jpeg', '.png', '.gif'].contains(extension)) {
            throw Exception('Formato de imagem não suportado');
          }
          break;
      }

      return true;
    } catch (e) {
      debugPrint('Erro ao validar arquivo: $e');
      rethrow;
    }
  }
}
