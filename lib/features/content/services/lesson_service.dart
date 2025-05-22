import 'dart:async';
import 'package:app_aya_v2/services/storage_service.dart';
import 'package:app_aya_v2/services/share_service.dart';
import 'package:app_aya_v2/services/download_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/services/logging_service.dart';

class LessonService {
  static final LessonService _instance = LessonService._internal();
  factory LessonService() => _instance;
  LessonService._internal();

  final _storage = StorageService();
  final _share = ShareService();
  final _download = DownloadService();
  final _supabase = Supabase.instance.client;
  final _logger = LoggingService();

  // Stream controllers para gerenciar estados
  final _favoriteController = StreamController<bool>.broadcast();
  final _playbackController = StreamController<PlaybackState>.broadcast();
  final _commentsController = StreamController<List<Comment>>.broadcast();

  // Estado inicial
  bool _isFavorite = false;
  PlaybackState _playbackState = PlaybackState();
  List<Comment> _comments = [];

  // Getters para streams
  Stream<bool> get favoriteStream => _favoriteController.stream;
  Stream<PlaybackState> get playbackStream => _playbackController.stream;
  Stream<List<Comment>> get commentsStream => _commentsController.stream;

  // Métodos para favoritos
  Future<void> toggleFavorite(String lessonId) async {
    try {
      if (_isFavorite) {
        await _storage.removeFavorite(lessonId);
      } else {
        await _storage.addFavorite(lessonId);
      }
      _isFavorite = !_isFavorite;
      _favoriteController.add(_isFavorite);
    } catch (e) {
      _logger.error('Erro ao alternar favorito', e);
      rethrow;
    }
  }

  // Métodos para reprodução
  Future<void> play(String lessonId) async {
    try {
      _playbackState = _playbackState.copyWith(isPlaying: true);
      _playbackController.add(_playbackState);
    } catch (e) {
      _logger.error('Erro ao iniciar reprodução', e);
      rethrow;
    }
  }

  Future<void> pause(String lessonId) async {
    try {
      _playbackState = _playbackState.copyWith(isPlaying: false);
      _playbackController.add(_playbackState);
      await _storage.saveLessonProgress(
          lessonId, _playbackState.currentPosition);
    } catch (e) {
      _logger.error('Erro ao pausar reprodução', e);
      rethrow;
    }
  }

  Future<void> seekTo(String lessonId, Duration position) async {
    try {
      _playbackState = _playbackState.copyWith(currentPosition: position);
      _playbackController.add(_playbackState);
      await _storage.saveLessonProgress(lessonId, position);
    } catch (e) {
      _logger.error('Erro ao buscar posição', e);
      rethrow;
    }
  }

  // Métodos para comentários
  Future<void> addComment(String lessonId, String text) async {
    try {
      final newComment = Comment(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: 'current_user_id', // TODO: Implementar autenticação
        userName: 'Usuário Atual',
        userAvatar: 'assets/images/user1.jpg',
        text: text,
        timestamp: DateTime.now(),
        likes: 0,
      );
      _comments = [..._comments, newComment];
      _commentsController.add(_comments);
    } catch (e) {
      _logger.error('Erro ao adicionar comentário', e);
      rethrow;
    }
  }

  Future<void> toggleLikeComment(String lessonId, String commentId) async {
    try {
      final likedComments = await _storage.getLikedComments();
      final isLiked = likedComments.contains(commentId);

      if (isLiked) {
        await _storage.removeLikedComment(commentId);
      } else {
        await _storage.addLikedComment(commentId);
      }

      _comments = _comments.map((comment) {
        if (comment.id == commentId) {
          return comment.copyWith(
            likes: comment.likes + (isLiked ? -1 : 1),
            isLiked: !isLiked,
          );
        }
        return comment;
      }).toList();
      _commentsController.add(_comments);
    } catch (e) {
      _logger.error('Erro ao curtir comentário', e);
      rethrow;
    }
  }

  Future<void> replyToComment(
      String lessonId, String commentId, String text) async {
    try {
      final newReply = Comment(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: 'current_user_id', // TODO: Implementar autenticação
        userName: 'Usuário Atual',
        userAvatar: 'assets/images/user1.jpg',
        text: text,
        timestamp: DateTime.now(),
        likes: 0,
        parentId: commentId,
      );
      _comments = [..._comments, newReply];
      _commentsController.add(_comments);
    } catch (e) {
      _logger.error('Erro ao responder comentário', e);
      rethrow;
    }
  }

  // Métodos para download
  Future<void> downloadLesson(
    String lessonId, {
    required String moduleId,
    required String fileName,
    required String fileType,
    String? folderId,
    String? subfolderId,
  }) async {
    try {
      await _download.downloadLesson(
        lessonId: lessonId,
        moduleId: moduleId,
        folderId: folderId,
        subfolderId: subfolderId,
        fileName: fileName,
        fileType: fileType,
      );
      await _storage.addDownloadedLesson(lessonId);
      _logger.info('Aula baixada com sucesso');
    } catch (e) {
      _logger.error('Erro ao baixar aula', e);
      rethrow;
    }
  }

  Stream<double> getDownloadProgress(String lessonId) {
    return _download.getDownloadProgress(lessonId);
  }

  Future<void> cancelDownload(String lessonId) async {
    try {
      await _download.cancelDownload(lessonId);
    } catch (e) {
      _logger.error('Erro ao cancelar download', e);
      rethrow;
    }
  }

  Future<bool> isLessonDownloaded(String lessonId) async {
    try {
      return await _download.isLessonDownloaded(lessonId);
    } catch (e) {
      _logger.error('Erro ao verificar download', e);
      return false;
    }
  }

  Future<void> removeDownloadedLesson(String lessonId) async {
    try {
      await _download.removeDownloadedLesson(lessonId);
      await _storage.removeDownloadedLesson(lessonId);
    } catch (e) {
      _logger.error('Erro ao remover aula baixada', e);
      rethrow;
    }
  }

  // Métodos para compartilhamento
  Future<void> shareLesson(String lessonId) async {
    try {
      await _share.shareLesson(lessonId, 'Aula do Aya');
    } catch (e) {
      _logger.error('Erro ao compartilhar aula', e);
      rethrow;
    }
  }

  // Métodos para navegação
  Future<String?> getNextLessonId(String currentLessonId) async {
    try {
      // TODO: Implementar chamada à API
      return 'next_lesson_id';
    } catch (e) {
      _logger.error('Erro ao obter próxima aula', e);
      rethrow;
    }
  }

  // Carregar estado inicial
  Future<void> loadInitialState(String lessonId) async {
    try {
      // Carregar favorito
      final favorites = await _storage.getFavorites();
      _isFavorite = favorites.contains(lessonId);
      _favoriteController.add(_isFavorite);

      // Carregar progresso
      final progress = await _storage.getLessonProgress();
      final savedPosition = progress[lessonId];
      if (savedPosition != null) {
        _playbackState = _playbackState.copyWith(
          currentPosition: Duration(seconds: savedPosition),
        );
        _playbackController.add(_playbackState);
      }

      // Carregar comentários curtidos
      final likedComments = await _storage.getLikedComments();
      _comments = _comments.map((comment) {
        return comment.copyWith(
          isLiked: likedComments.contains(comment.id),
        );
      }).toList();
      _commentsController.add(_comments);
    } catch (e) {
      _logger.error('Erro ao carregar estado inicial', e);
      rethrow;
    }
  }

  // Limpeza
  void dispose() {
    _favoriteController.close();
    _playbackController.close();
    _commentsController.close();
  }

  Future<List<Map<String, dynamic>>> getLessons() async {
    try {
      final response = await _supabase
          .from('lessons')
          .select()
          .order('created_at', ascending: false);
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      _logger.error('Erro ao buscar aulas', e);
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getLesson(String id) async {
    try {
      final response =
          await _supabase.from('lessons').select().eq('id', id).single();
      return response;
    } catch (e) {
      _logger.error('Erro ao buscar aula', e);
      rethrow;
    }
  }

  Future<void> createLesson(Map<String, dynamic> lesson) async {
    try {
      await _supabase.from('lessons').insert(lesson);
      _logger.info('Aula criada com sucesso');
    } catch (e) {
      _logger.error('Erro ao criar aula', e);
      rethrow;
    }
  }

  Future<void> updateLesson(String id, Map<String, dynamic> lesson) async {
    try {
      await _supabase.from('lessons').update(lesson).eq('id', id);
      _logger.info('Aula atualizada com sucesso');
    } catch (e) {
      _logger.error('Erro ao atualizar aula', e);
      rethrow;
    }
  }

  Future<void> deleteLesson(String id) async {
    try {
      await _supabase.from('lessons').delete().eq('id', id);
      _logger.info('Aula deletada com sucesso');
    } catch (e) {
      _logger.error('Erro ao deletar aula', e);
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getLessonsByModule(String moduleId) async {
    try {
      final response = await _supabase
          .from('lessons')
          .select()
          .eq('module_id', moduleId)
          .order('created_at', ascending: false);
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      _logger.error('Erro ao buscar aulas do módulo', e);
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getLessonsByFolder(String folderId) async {
    try {
      final response = await _supabase
          .from('lessons')
          .select()
          .eq('folder_id', folderId)
          .order('created_at', ascending: false);
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      _logger.error('Erro ao buscar aulas da pasta', e);
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getLessonsBySubfolder(
      String subfolderId) async {
    try {
      final response = await _supabase
          .from('lessons')
          .select()
          .eq('subfolder_id', subfolderId)
          .order('created_at', ascending: false);
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      _logger.error('Erro ao buscar aulas da subpasta', e);
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> searchLessons(String query) async {
    try {
      final response = await _supabase
          .from('lessons')
          .select()
          .ilike('title', '%$query%')
          .order('created_at', ascending: false);
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      _logger.error('Erro ao buscar aulas por termo', e);
      rethrow;
    }
  }
}

class PlaybackState {
  final bool isPlaying;
  final Duration currentPosition;
  final Duration duration;

  const PlaybackState({
    this.isPlaying = false,
    this.currentPosition = Duration.zero,
    this.duration = Duration.zero,
  });

  PlaybackState copyWith({
    bool? isPlaying,
    Duration? currentPosition,
    Duration? duration,
  }) {
    return PlaybackState(
      isPlaying: isPlaying ?? this.isPlaying,
      currentPosition: currentPosition ?? this.currentPosition,
      duration: duration ?? this.duration,
    );
  }
}

class Comment {
  final String id;
  final String userId;
  final String userName;
  final String userAvatar;
  final String text;
  final DateTime timestamp;
  final int likes;
  final String? parentId;
  final bool isLiked;

  const Comment({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userAvatar,
    required this.text,
    required this.timestamp,
    required this.likes,
    this.parentId,
    this.isLiked = false,
  });

  Comment copyWith({
    String? id,
    String? userId,
    String? userName,
    String? userAvatar,
    String? text,
    DateTime? timestamp,
    int? likes,
    String? parentId,
    bool? isLiked,
  }) {
    return Comment(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userAvatar: userAvatar ?? this.userAvatar,
      text: text ?? this.text,
      timestamp: timestamp ?? this.timestamp,
      likes: likes ?? this.likes,
      parentId: parentId ?? this.parentId,
      isLiked: isLiked ?? this.isLiked,
    );
  }

  String get timeAgo {
    final difference = DateTime.now().difference(timestamp);
    if (difference.inDays > 0) {
      return '${difference.inDays}d';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m';
    } else {
      return 'agora';
    }
  }
}
