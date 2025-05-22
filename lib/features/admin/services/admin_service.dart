import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/admin_models.dart';
import '../../../../core/services/logging_service.dart';

class AdminService {
  static final AdminService _instance = AdminService._internal();
  factory AdminService() => _instance;
  AdminService._internal();

  final _supabase = Supabase.instance.client;
  final _logger = LoggingService();

  Future<AdminStats> getStats() async {
    try {
      // Buscar total de usuários
      final usersResponse = await _supabase.from('profiles').select('id');
      final totalUsers = usersResponse.length;

      // Buscar total de assinantes
      final subscribersResponse = await _supabase
          .from('profiles')
          .select('id')
          .eq('is_subscriber', true);
      final totalSubscribers = subscribersResponse.length;

      // Buscar conteúdos recentes (últimos 7 dias)
      final recentContentsResponse = await _supabase
          .from('contents')
          .select('id')
          .gte(
              'created_at',
              DateTime.now()
                  .subtract(const Duration(days: 7))
                  .toIso8601String());
      final recentContents = recentContentsResponse.length;

      // Buscar itens pendentes de moderação
      final pendingModerationResponse =
          await _supabase.from('contents').select('id').eq('status', 'pending');
      final pendingModeration = pendingModerationResponse.length;

      _logger.info('Admin stats loaded successfully');
      return AdminStats(
        totalUsers: totalUsers,
        totalSubscribers: totalSubscribers,
        recentContents: recentContents,
        pendingModeration: pendingModeration,
      );
    } catch (e, stackTrace) {
      _logger.error('Error loading admin stats', e, stackTrace);
      rethrow;
    }
  }

  Future<List<AdminUser>> getUsers({String? search}) async {
    try {
      // TODO: Implementar busca de usuários funcional com filtro no backend
      final response = await _supabase
          .from('profiles')
          .select()
          .order('created_at', ascending: false)
          .limit(50);

      return (response as List)
          .map((user) => AdminUser.fromJson(user))
          .toList();
    } catch (e, stackTrace) {
      _logger.error('Erro ao buscar usuários', e, stackTrace);
      rethrow;
    }
  }

  Future<void> updateUserRole(String userId, String role) async {
    try {
      await _supabase.from('users').update({'role': role}).eq('id', userId);
      _logger.info('Função do usuário atualizada com sucesso');
    } catch (e) {
      _logger.error('Erro ao atualizar função do usuário', e);
      rethrow;
    }
  }

  Future<void> deleteUser(String userId) async {
    await _supabase.from('users').delete().eq('id', userId);
  }

  Future<List<AdminLesson>> getLessons() async {
    final response = await _supabase
        .from('lessons')
        .select()
        .order('created_at', ascending: false);

    return (response as List)
        .map((lesson) => AdminLesson.fromJson(lesson))
        .toList();
  }

  Future<void> createLesson(AdminLesson lesson) async {
    await _supabase.from('lessons').insert(lesson.toJson());
  }

  Future<void> updateLesson(AdminLesson lesson) async {
    await _supabase.from('lessons').update(lesson.toJson()).eq('id', lesson.id);
  }

  Future<void> deleteLesson(String lessonId) async {
    await _supabase.from('lessons').delete().eq('id', lessonId);
  }

  Future<List<AdminModule>> getModules() async {
    final response = await _supabase
        .from('modules')
        .select()
        .order('created_at', ascending: false);

    return (response as List)
        .map((module) => AdminModule.fromJson(module))
        .toList();
  }

  Future<void> createModule(AdminModule module) async {
    await _supabase.from('modules').insert(module.toJson());
  }

  Future<void> updateModule(AdminModule module) async {
    await _supabase.from('modules').update(module.toJson()).eq('id', module.id);
  }

  Future<void> deleteModule(String moduleId) async {
    await _supabase.from('modules').delete().eq('id', moduleId);
  }

  Future<List<AdminChallenge>> getChallenges() async {
    final response = await _supabase
        .from('challenges')
        .select()
        .order('created_at', ascending: false);

    return (response as List)
        .map((challenge) => AdminChallenge.fromJson(challenge))
        .toList();
  }

  Future<void> createChallenge(AdminChallenge challenge) async {
    await _supabase.from('challenges').insert(challenge.toJson());
  }

  Future<void> updateChallenge(AdminChallenge challenge) async {
    await _supabase
        .from('challenges')
        .update(challenge.toJson())
        .eq('id', challenge.id);
  }

  Future<void> deleteChallenge(String challengeId) async {
    await _supabase.from('challenges').delete().eq('id', challengeId);
  }

  Future<List<AdminBadge>> getBadges() async {
    final response = await _supabase
        .from('badges')
        .select()
        .order('created_at', ascending: false);

    return (response as List)
        .map((badge) => AdminBadge.fromJson(badge))
        .toList();
  }

  Future<void> createBadge(AdminBadge badge) async {
    await _supabase.from('badges').insert(badge.toJson());
  }

  Future<void> updateBadge(AdminBadge badge) async {
    await _supabase.from('badges').update(badge.toJson()).eq('id', badge.id);
  }

  Future<void> deleteBadge(String badgeId) async {
    await _supabase.from('badges').delete().eq('id', badgeId);
  }

  Future<AdminSettings> getSettings() async {
    final response = await _supabase.from('settings').select().single();

    return AdminSettings.fromJson(response);
  }

  Future<void> updateSettings({
    required bool isDarkMode,
    required String language,
    required bool notificationsEnabled,
    required bool autoSaveEnabled,
    required int autoSaveInterval,
  }) async {
    await _supabase.from('settings').update({
      'is_dark_mode': isDarkMode,
      'language': language,
      'notifications_enabled': notificationsEnabled,
      'auto_save_enabled': autoSaveEnabled,
      'auto_save_interval': autoSaveInterval,
    }).eq('id', 'global');
  }

  Future<AdminAnalytics> getAnalytics() async {
    final response = await _supabase.from('analytics').select().single();

    return AdminAnalytics.fromJson(response);
  }

  Future<List<AdminContent>> getContents(
      {String? type, String? parentId}) async {
    try {
      var query = _supabase.from('contents').select();

      if (type != null) {
        query = query.eq('type', type);
      }

      if (parentId != null) {
        query = query.eq('parent_id', parentId);
      }

      final response = await query.order('created_at', ascending: false);

      return (response as List)
          .map((content) => AdminContent(
                id: content['id'],
                title: content['title'],
                type: content['type'],
                parentId: content['parent_id'],
                isPublished: content['is_published'],
                createdAt: DateTime.parse(content['created_at']),
                updatedAt: content['updated_at'] != null
                    ? DateTime.parse(content['updated_at'])
                    : null,
                authorId: content['author_id'],
                authorName: content['author_name'],
              ))
          .toList();
    } catch (e) {
      _logger.error('Erro ao buscar conteúdos', e);
      throw Exception('Falha ao buscar conteúdos');
    }
  }

  Future<void> deleteContent(String contentId) async {
    try {
      await _supabase.from('contents').delete().eq('id', contentId);
    } catch (e) {
      _logger.error('Erro ao deletar conteúdo', e);
      throw Exception('Falha ao deletar conteúdo');
    }
  }

  Future<List<AdminComment>> getComments(
      {String? contentType,
      String? contentId,
      bool? isReported,
      bool? isApproved}) async {
    try {
      var query = _supabase.from('comments').select();

      if (contentType != null) {
        query = query.eq('content_type', contentType);
      }

      if (contentId != null) {
        query = query.eq('content_id', contentId);
      }

      if (isReported != null) {
        query = query.eq('is_reported', isReported);
      }

      if (isApproved != null) {
        query = query.eq('is_approved', isApproved);
      }

      final response = await query.order('created_at', ascending: false);

      return (response as List)
          .map((comment) => AdminComment(
                id: comment['id'],
                content: comment['content'],
                authorId: comment['author_id'],
                authorName: comment['author_name'],
                contentType: comment['content_type'],
                contentId: comment['content_id'],
                contentTitle: comment['content_title'],
                isReported: comment['is_reported'],
                isApproved: comment['is_approved'],
                createdAt: DateTime.parse(comment['created_at']),
              ))
          .toList();
    } catch (e) {
      _logger.error('Erro ao buscar comentários', e);
      throw Exception('Falha ao buscar comentários');
    }
  }

  Future<void> approveComment(String commentId) async {
    try {
      await _supabase
          .from('comments')
          .update({'is_approved': true}).eq('id', commentId);
    } catch (e) {
      _logger.error('Erro ao aprovar comentário', e);
      throw Exception('Falha ao aprovar comentário');
    }
  }

  Future<void> deleteComment(String commentId) async {
    try {
      await _supabase.from('comments').delete().eq('id', commentId);
    } catch (e) {
      _logger.error('Erro ao deletar comentário', e);
      throw Exception('Falha ao deletar comentário');
    }
  }

  Future<void> deactivateUser(String userId) async {
    try {
      // Primeiro, atualiza o status na tabela de perfis
      await _supabase
          .from('users')
          .update({'is_active': false}).eq('id', userId);

      // TODO: Implementar chamada para Edge Function que desativa o usuário no Supabase Auth
      // Esta é uma operação que deve ser feita via Edge Function por questões de segurança
      _logger.info(
          'AdminService: deactivateUser($userId) - Implementar chamada para Edge Function');
    } catch (e) {
      _logger.error('Erro ao desativar usuário', e);
      throw Exception('Falha ao desativar usuário');
    }
  }

  Future<void> banUser(String userId) async {
    try {
      await _supabase
          .from('users')
          .update({'is_banned': true}).eq('id', userId);
      _logger.info('Usuário banido com sucesso');
    } catch (e) {
      _logger.error('Erro ao banir usuário', e);
      rethrow;
    }
  }

  Future<void> unbanUser(String userId) async {
    try {
      await _supabase
          .from('users')
          .update({'is_banned': false}).eq('id', userId);
      _logger.info('Usuário desbanido com sucesso');
    } catch (e) {
      _logger.error('Erro ao desbanir usuário', e);
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getReports() async {
    try {
      final response = await _supabase
          .from('reports')
          .select()
          .order('created_at', ascending: false);
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      _logger.error('Erro ao buscar denúncias', e);
      rethrow;
    }
  }

  Future<void> resolveReport(String reportId) async {
    try {
      await _supabase
          .from('reports')
          .update({'status': 'resolved'}).eq('id', reportId);
      _logger.info('Denúncia resolvida com sucesso');
    } catch (e) {
      _logger.error('Erro ao resolver denúncia', e);
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getLogs() async {
    try {
      final response = await _supabase
          .from('logs')
          .select()
          .order('created_at', ascending: false);
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      _logger.error('Erro ao buscar logs', e);
      rethrow;
    }
  }
}
