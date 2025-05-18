import 'dart:io';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app_aya_v2/services/upload_service.dart';
import 'package:app_aya_v2/services/storage_path_service.dart';
import 'package:path/path.dart' as path;

class TestDataService {
  static final TestDataService _instance = TestDataService._internal();
  factory TestDataService() => _instance;
  TestDataService._internal();

  final _supabase = Supabase.instance.client;
  final _upload = UploadService();

  // Método para adicionar dados de teste
  Future<void> addTestData() async {
    try {
      // 1. Adiciona um módulo
      final moduleId = await _addTestModule();

      // 2. Adiciona uma pasta no módulo
      final folderId = await _addTestFolder(moduleId);

      // 3. Adiciona uma subpasta na pasta
      final subfolderId = await _addTestSubfolder(moduleId, folderId);

      // 4. Adiciona uma aula na subpasta
      await _addTestLesson(moduleId, folderId, subfolderId);

      // 5. Adiciona uma aula diretamente na pasta
      await _addTestLesson(moduleId, folderId, null);

      // 6. Adiciona uma aula diretamente no módulo
      await _addTestLesson(moduleId, null, null);

      // 7. Adiciona um avatar de usuário
      await _addTestUserAvatar();

      // 8. Adiciona um ícone de badge
      await _addTestBadgeIcon();

      debugPrint('Dados de teste adicionados com sucesso!');
    } catch (e) {
      debugPrint('Erro ao adicionar dados de teste: $e');
      rethrow;
    }
  }

  // Método para adicionar um módulo de teste
  Future<String> _addTestModule() async {
    final moduleId = 'mod_${DateTime.now().millisecondsSinceEpoch}';
    
    // Insere o módulo no banco de dados
    await _supabase.from('modules').insert({
      'id': moduleId,
      'title': 'Módulo de Teste',
      'description': 'Este é um módulo de teste',
      'order': 1,
      'is_active': true,
    });

    // Adiciona uma imagem de capa
    final coverFile = await _createTestImage('Capa do Módulo');
    await _upload.uploadModuleCover(
      moduleId: moduleId,
      file: coverFile,
    );

    return moduleId;
  }

  // Método para adicionar uma pasta de teste
  Future<String> _addTestFolder(String moduleId) async {
    final folderId = 'fold_${DateTime.now().millisecondsSinceEpoch}';
    
    // Insere a pasta no banco de dados
    await _supabase.from('folders').insert({
      'id': folderId,
      'module_id': moduleId,
      'title': 'Pasta de Teste',
      'description': 'Esta é uma pasta de teste',
      'order': 1,
      'is_active': true,
    });

    // Adiciona uma imagem de capa
    final coverFile = await _createTestImage('Capa da Pasta');
    await _upload.uploadFolderCover(
      moduleId: moduleId,
      folderId: folderId,
      file: coverFile,
    );

    return folderId;
  }

  // Método para adicionar uma subpasta de teste
  Future<String> _addTestSubfolder(String moduleId, String folderId) async {
    final subfolderId = 'sub_${DateTime.now().millisecondsSinceEpoch}';
    
    // Insere a subpasta no banco de dados
    await _supabase.from('subfolders').insert({
      'id': subfolderId,
      'folder_id': folderId,
      'title': 'Subpasta de Teste',
      'description': 'Esta é uma subpasta de teste',
      'order': 1,
      'is_active': true,
    });

    // Adiciona uma imagem de capa
    final coverFile = await _createTestImage('Capa da Subpasta');
    await _upload.uploadSubfolderCover(
      moduleId: moduleId,
      folderId: folderId,
      subfolderId: subfolderId,
      file: coverFile,
    );

    return subfolderId;
  }

  // Método para adicionar uma aula de teste
  Future<String> _addTestLesson(
    String moduleId,
    String? folderId,
    String? subfolderId,
  ) async {
    final lessonId = 'less_${DateTime.now().millisecondsSinceEpoch}';
    
    // Insere a aula no banco de dados
    await _supabase.from('lessons').insert({
      'id': lessonId,
      'module_id': moduleId,
      'folder_id': folderId,
      'subfolder_id': subfolderId,
      'title': 'Aula de Teste',
      'description': 'Esta é uma aula de teste',
      'order': 1,
      'is_active': true,
      'duration': 300, // 5 minutos
      'type': 'video',
    });

    // Adiciona um vídeo de exemplo
    final videoFile = await _createTestVideo('Vídeo da Aula');
    await _upload.uploadLessonContent(
      moduleId: moduleId,
      lessonId: lessonId,
      folderId: folderId,
      subfolderId: subfolderId,
      file: videoFile,
      fileType: StoragePathService.fileTypeVideo,
    );

    // Adiciona um thumbnail
    final thumbnailFile = await _createTestImage('Thumbnail da Aula');
    await _upload.uploadLessonThumbnail(
      moduleId: moduleId,
      lessonId: lessonId,
      folderId: folderId,
      subfolderId: subfolderId,
      file: thumbnailFile,
    );

    return lessonId;
  }

  // Método para adicionar um avatar de usuário de teste
  Future<void> _addTestUserAvatar() async {
    final userId = 'user_${DateTime.now().millisecondsSinceEpoch}';
    
    // Insere o usuário no banco de dados
    await _supabase.from('users').insert({
      'id': userId,
      'name': 'Usuário de Teste',
      'email': 'teste@example.com',
    });

    // Adiciona um avatar
    final avatarFile = await _createTestImage('Avatar do Usuário');
    await _upload.uploadUserAvatar(
      userId: userId,
      file: avatarFile,
    );
  }

  // Método para adicionar um ícone de badge de teste
  Future<void> _addTestBadgeIcon() async {
    final badgeId = 'badge_${DateTime.now().millisecondsSinceEpoch}';
    
    // Insere o badge no banco de dados
    await _supabase.from('badges').insert({
      'id': badgeId,
      'title': 'Badge de Teste',
      'description': 'Este é um badge de teste',
      'points': 100,
    });

    // Adiciona um ícone
    final iconFile = await _createTestSvg('Ícone do Badge');
    await _upload.uploadBadgeIcon(
      badgeId: badgeId,
      file: iconFile,
    );
  }

  // Método para criar uma imagem de teste
  Future<File> _createTestImage(String text) async {
    // Aqui você pode implementar a criação de uma imagem real
    // Por enquanto, vamos criar um arquivo vazio
    final tempDir = Directory.systemTemp;
    final file = File('${tempDir.path}/test_image.jpg');
    await file.writeAsBytes([0xFF, 0xD8, 0xFF, 0xE0]); // JPEG header
    return file;
  }

  // Método para criar um vídeo de teste
  Future<File> _createTestVideo(String text) async {
    // Aqui você pode implementar a criação de um vídeo real
    // Por enquanto, vamos criar um arquivo vazio
    final tempDir = Directory.systemTemp;
    final file = File('${tempDir.path}/test_video.mp4');
    await file.writeAsBytes([0x00, 0x00, 0x00, 0x20]); // MP4 header
    return file;
  }

  // Método para criar um SVG de teste
  Future<File> _createTestSvg(String text) async {
    // Aqui você pode implementar a criação de um SVG real
    // Por enquanto, vamos criar um arquivo vazio
    final tempDir = Directory.systemTemp;
    final file = File('${tempDir.path}/test_icon.svg');
    await file.writeAsString('''
      <svg xmlns="http://www.w3.org/2000/svg" width="100" height="100">
        <circle cx="50" cy="50" r="40" fill="gold"/>
        <text x="50" y="50" text-anchor="middle" fill="black">$text</text>
      </svg>
    ''');
    return file;
  }
} 