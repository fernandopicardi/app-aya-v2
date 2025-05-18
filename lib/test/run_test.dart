import 'package:flutter/material.dart';
import 'package:app_aya_v2/services/test_data_service.dart';
import 'package:app_aya_v2/services/auth_service.dart';
import 'package:app_aya_v2/services/download_service.dart';
import 'package:app_aya_v2/services/metadata_service.dart';

class TestRunner {
  static Future<void> runFullTest() async {
    try {
      debugPrint('Iniciando teste completo...');

      // 1. Login
      debugPrint('1. Realizando login...');
      final auth = AuthService();
      await auth.signInWithEmail(
        email: 'teste@example.com',
        password: 'teste123',
      );
      debugPrint('Login realizado com sucesso!');

      // 2. Adicionar dados de teste
      debugPrint('2. Adicionando dados de teste...');
      await TestDataService().addTestData();
      debugPrint('Dados de teste adicionados com sucesso!');

      // 3. Baixar uma aula
      debugPrint('3. Baixando uma aula...');
      final download = DownloadService();
      final metadata = await MetadataService().getAllDownloads();
      if (metadata.isNotEmpty) {
        final lesson = metadata.first;
        await download.downloadLesson(
          lessonId: lesson['lesson_id'],
          moduleId: lesson['module_id'],
          folderId: lesson['folder_id'],
          subfolderId: lesson['subfolder_id'],
          fileType: lesson['file_type'],
          fileName: lesson['title'] ?? 'Aula de Teste',
        );
        debugPrint('Aula baixada com sucesso!');
      }

      // 4. Verificar downloads
      debugPrint('4. Verificando downloads...');
      final downloads = await MetadataService().getAllDownloads();
      debugPrint('Total de downloads: ${downloads.length}');
      debugPrint('Tamanho total: ${await MetadataService().getTotalDownloadsSize()} bytes');

      debugPrint('Teste completo finalizado com sucesso!');
    } catch (e) {
      debugPrint('Erro durante o teste: $e');
      rethrow;
    }
  }
} 