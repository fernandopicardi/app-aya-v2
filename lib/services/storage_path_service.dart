import 'package:supabase_flutter/supabase_flutter.dart';

class StoragePathService {
  static final StoragePathService _instance = StoragePathService._internal();
  factory StoragePathService() => _instance;
  StoragePathService._internal();

  final _supabase = Supabase.instance.client;

  // Constantes para buckets
  static const String bucketContent = 'aya-content';
  static const String bucketUIAssets = 'ui-assets';
  static const String bucketUserAvatars = 'user-avatars';
  static const String bucketBadgeIcons = 'badges-icons';

  // Constantes para tipos de arquivo
  static const String fileTypeVideo = 'video';
  static const String fileTypeAudio = 'audio';
  static const String fileTypePDF = 'pdf';
  static const String fileTypeImage = 'image';
  // Método para obter URL assinada para conteúdo de aula
  Future<String> getSignedUrlForLessonContent({
    required String lessonId,
    required String moduleId,
    required String fileType,
    String? folderId,
    String? subfolderId,
    String? fileName,
    int expirySeconds = 300,
  }) async {
    final path = buildLessonContentPath(
      moduleId: moduleId,
      lessonId: lessonId,
      folderId: folderId,
      subfolderId: subfolderId,
      fileType: fileType,
    );

    final finalPath = fileName != null
        ? '$path/$fileName'
        : '$path/${_getDefaultFileName(fileType)}';

    return await _supabase.storage
        .from(bucketContent)
        .createSignedUrl(finalPath, expirySeconds);
  }

  // Método para obter URL assinada para thumbnail de aula
  Future<String> getSignedUrlForLessonThumbnail({
    required String moduleId,
    required String lessonId,
    String? folderId,
    String? subfolderId,
    int expirySeconds = 300,
  }) async {
    final path = buildLessonThumbnailPath(
      moduleId: moduleId,
      lessonId: lessonId,
      folderId: folderId,
      subfolderId: subfolderId,
    );

    return await _supabase.storage
        .from(bucketContent)
        .createSignedUrl(path, expirySeconds);
  }

  // Método para obter URL assinada para capa de módulo
  Future<String> getSignedUrlForModuleCover({
    required String moduleId,
    int expirySeconds = 300,
  }) async {
    final path = 'modules/$moduleId/cover.jpg';
    return await _supabase.storage
        .from(bucketContent)
        .createSignedUrl(path, expirySeconds);
  }

  // Método para obter URL assinada para capa de pasta
  Future<String> getSignedUrlForFolderCover({
    required String moduleId,
    required String folderId,
    int expirySeconds = 300,
  }) async {
    final path = 'modules/$moduleId/folders/$folderId/cover.jpg';
    return await _supabase.storage
        .from(bucketContent)
        .createSignedUrl(path, expirySeconds);
  }

  // Método para obter URL assinada para capa de subpasta
  Future<String> getSignedUrlForSubfolderCover({
    required String moduleId,
    required String folderId,
    required String subfolderId,
    int expirySeconds = 300,
  }) async {
    final path =
        'modules/$moduleId/folders/$folderId/subfolders/$subfolderId/cover.jpg';
    return await _supabase.storage
        .from(bucketContent)
        .createSignedUrl(path, expirySeconds);
  }

  // Método para obter URL assinada para avatar do usuário
  Future<String> getSignedUrlForUserAvatar({
    required String userId,
    int expirySeconds = 300,
  }) async {
    final path = '$userId/avatar.jpg';
    return await _supabase.storage
        .from(bucketUserAvatars)
        .createSignedUrl(path, expirySeconds);
  }

  // Método para obter URL assinada para ícone de badge
  Future<String> getSignedUrlForBadgeIcon({
    required String badgeId,
    int expirySeconds = 300,
  }) async {
    final path = '$badgeId/icon.svg';
    return await _supabase.storage
        .from(bucketBadgeIcons)
        .createSignedUrl(path, expirySeconds);
  }

  // Método para construir caminho do conteúdo da aula
  String buildLessonContentPath({
    required String moduleId,
    required String lessonId,
    String? folderId,
    String? subfolderId,
    required String fileType,
  }) {
    final parts = <String>[
      'modules',
      moduleId,
      if (folderId != null) 'folders',
      if (folderId != null) folderId,
      if (subfolderId != null) 'subfolders',
      if (subfolderId != null) subfolderId,
      'lessons',
      lessonId,
      'content',
      fileType,
    ];

    return parts.join('/');
  }

  // Método para construir caminho do thumbnail da aula
  String buildLessonThumbnailPath({
    required String moduleId,
    required String lessonId,
    String? folderId,
    String? subfolderId,
  }) {
    final buffer = StringBuffer('modules/$moduleId/');

    if (folderId != null) {
      buffer.write('folders/$folderId/');

      if (subfolderId != null) {
        buffer.write('subfolders/$subfolderId/');
      }
    }

    buffer.write('lessons/$lessonId/thumbnail_aula.jpg');
    return buffer.toString();
  }

  // Método para obter nome padrão do arquivo baseado no tipo
  String _getDefaultFileName(String fileType) {
    switch (fileType) {
      case fileTypeVideo:
        return 'video.mp4';
      case fileTypeAudio:
        return 'audio.mp3';
      case fileTypePDF:
        return 'material_apoio.pdf';
      case fileTypeImage:
        return 'thumbnail_aula.jpg';
      default:
        return 'content.dat';
    }
  }
}
