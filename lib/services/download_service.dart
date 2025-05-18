import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app_aya_v2/services/metadata_service.dart';
import 'package:app_aya_v2/services/encryption_service.dart';
import 'package:app_aya_v2/services/storage_path_service.dart';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

class DownloadService {
  static final DownloadService _instance = DownloadService._internal();
  factory DownloadService() => _instance;
  DownloadService._internal();

  final _supabase = Supabase.instance.client;
  final _metadata = MetadataService();
  final _encryption = EncryptionService();
  final _storagePath = StoragePathService();
  final Map<String, StreamController<double>> _downloadProgressControllers = {};

  static const _bucketName = 'aya-content';
  static const _maxDownloads = 100;
  static const _maxStorageSize = 1024 * 1024 * 1024; // 1GB

  Future<void> downloadLesson({
    required String lessonId,
    required String moduleId,
    String? folderId,
    String? subfolderId,
    required String fileType,
    required String fileName,
  }) async {
    try {
      // Verifica limites de download
      await _checkDownloadLimits();

      // Obtém a URL assinada para o arquivo
      final signedUrl = await _storagePath.getSignedUrlForLessonContent(
        moduleId: moduleId,
        lessonId: lessonId,
        folderId: folderId,
        subfolderId: subfolderId,
        fileType: fileType,
      );

      // Faz o download do arquivo
      final response = await http.get(Uri.parse(signedUrl));
      if (response.statusCode != 200) {
        throw Exception('Erro ao baixar arquivo: ${response.statusCode}');
      }

      // Criptografa o conteúdo
      final encryptedData = await _encryption.encryptFile(response.bodyBytes);

      // Gera um nome de arquivo hash
      final hashedName = _generateHashedFileName(lessonId, fileType);

      // Salva o arquivo localmente
      final file = File(await _getLocalFilePath(hashedName));
      await file.writeAsBytes(encryptedData);

      // Salva os metadados
      await _metadata.saveDownloadMetadata(
        lessonId: lessonId,
        moduleId: moduleId,
        folderId: folderId,
        subfolderId: subfolderId,
        localPath: file.path,
        title: fileName,
        type: fileType,
        fileSize: file.lengthSync(),
      );
    } catch (e) {
      throw Exception('Erro ao baixar aula: $e');
    }
  }

  Future<void> _checkDownloadLimits() async {
    final totalSize = await _metadata.getTotalDownloadsSize();
    final count = await _metadata.getDownloadsCount();

    if (count >= _maxDownloads) {
      throw Exception('Limite máximo de downloads atingido');
    }

    if (totalSize >= _maxStorageSize) {
      throw Exception('Limite máximo de armazenamento atingido');
    }
  }

  String _generateHashedFileName(String lessonId, String fileType) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final input = '$lessonId$timestamp';
    final bytes = utf8.encode(input);
    final hash = sha256.convert(bytes);
    return '${hash.toString()}.$fileType';
  }

  Future<String> _getLocalFilePath(String fileName) async {
    final appDir = await getApplicationDocumentsDirectory();
    final downloadsDir = Directory('${appDir.path}/downloads');
    if (!await downloadsDir.exists()) {
      await downloadsDir.create(recursive: true);
    }
    return '${downloadsDir.path}/$fileName';
  }

  Future<bool> isLessonDownloaded(String lessonId) async {
    final metadata = await _metadata.getDownloadMetadata(lessonId);
    return metadata != null;
  }

  Future<void> removeDownloadedLesson(String lessonId) async {
    final metadata = await _metadata.getDownloadMetadata(lessonId);
    if (metadata != null) {
      final file = File(metadata['local_path']);
      if (await file.exists()) {
        await file.delete();
      }
      await _metadata.removeDownloadMetadata(lessonId);
    }
  }

  Future<Uint8List> getDecryptedLessonData(String lessonId) async {
    final metadata = await _metadata.getDownloadMetadata(lessonId);
    if (metadata == null) {
      throw Exception('Aula não encontrada');
    }

    final file = File(metadata['local_path']);
    if (!await file.exists()) {
      throw Exception('Arquivo não encontrado');
    }

    final encryptedData = await file.readAsBytes();
    return await _encryption.decryptFile(encryptedData);
  }

  Future<void> clearAllDownloads() async {
    final metadata = await _metadata.getAllDownloads();
    for (final item in metadata) {
      final file = File(item['local_path']);
      if (await file.exists()) {
        await file.delete();
      }
    }
    await _metadata.clearAll();
  }

  // Método para obter o progresso do download
  Stream<double> getDownloadProgress(String lessonId) {
    return _downloadProgressControllers[lessonId]?.stream ?? Stream.value(0.0);
  }

  // Método para cancelar o download
  Future<void> cancelDownload(String lessonId) async {
    try {
      await _downloadProgressControllers[lessonId]?.close();
      _downloadProgressControllers.remove(lessonId);
    } catch (e) {
      debugPrint('Erro ao cancelar download: $e');
      rethrow;
    }
  }

  // Método para obter dados descriptografados
  Future<Uint8List> getDecryptedData(String lessonId) async {
    try {
      final metadata = await _metadata.getDownloadMetadata(lessonId);
      if (metadata == null) {
        throw Exception('Aula não encontrada');
      }

      final file = File(metadata['local_path']);
      if (!await file.exists()) {
        throw Exception('Arquivo não encontrado');
      }

      final encryptedBytes = await file.readAsBytes();
      return await _encryption.decryptFile(encryptedBytes);
    } catch (e) {
      debugPrint('Erro ao obter dados descriptografados: $e');
      rethrow;
    }
  }
}
