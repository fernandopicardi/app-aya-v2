import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/dashboard_models.dart';

class DashboardService {
  final _supabase = Supabase.instance.client;

  Future<DashboardData> getDashboardData() async {
    final user = _supabase.auth.currentUser;
    if (user == null) {
      throw Exception('Usuário não autenticado');
    }

    final userName = user.email?.split('@').first ?? 'Amigo(a)';
    final tipOfTheDay = await _getDailyTip();
    final lastLesson = await _getLastAccessedLesson();
    final recommendedLessons = await _getRecommendedLessons();
    final exploreModules = await _getModules();
    final favoriteLessons = await _getFavoriteLessons();
    final activeChallenge = await _getCurrentChallenge();

    return DashboardData(
      userName: userName,
      tipOfTheDay: tipOfTheDay,
      lastLesson: lastLesson,
      recommendedLessons: recommendedLessons,
      exploreModules: exploreModules,
      favoriteLessons: favoriteLessons,
      activeChallenge: activeChallenge,
    );
  }

  Future<String> _getDailyTip() async {
    // TODO: Implementar busca real no Supabase
    return 'A meditação regular pode reduzir o estresse e melhorar o bem-estar geral.';
  }

  Future<Lesson?> _getLastAccessedLesson() async {
    // TODO: Implementar busca real no Supabase
    return Lesson(
      id: '1',
      title: 'Meditação Guiada',
      description: 'Uma meditação guiada para iniciantes',
      thumbnailUrl: 'https://picsum.photos/400/225',
      durationMinutes: 10,
      isPremium: false,
      progress: 0.5,
    );
  }

  Future<List<Lesson>> _getRecommendedLessons() async {
    // TODO: Implementar busca real no Supabase
    return [
      Lesson(
        id: '1',
        title: 'Meditação Guiada',
        description: 'Uma meditação guiada para iniciantes',
        thumbnailUrl: 'https://picsum.photos/400/225',
        durationMinutes: 10,
        isPremium: false,
        progress: 0.0,
      ),
      Lesson(
        id: '2',
        title: 'Mindfulness Básico',
        description: 'Aprenda os fundamentos do mindfulness',
        thumbnailUrl: 'https://picsum.photos/400/225',
        durationMinutes: 15,
        isPremium: true,
        progress: 0.0,
      ),
    ];
  }

  Future<List<Module>> _getModules() async {
    // TODO: Implementar busca real no Supabase
    return [
      Module(
        id: '1',
        title: 'Fundamentos da Meditação',
        description: 'Aprenda os conceitos básicos da meditação',
        coverUrl: 'https://picsum.photos/400/225',
        isPremium: false,
        progress: 0.3,
        totalLessons: 10,
        completedLessons: 3,
      ),
      Module(
        id: '2',
        title: 'Meditação Avançada',
        description: 'Técnicas avançadas de meditação',
        coverUrl: 'https://picsum.photos/400/225',
        isPremium: true,
        progress: 0.0,
        totalLessons: 8,
        completedLessons: 0,
      ),
    ];
  }

  Future<List<Lesson>> _getFavoriteLessons() async {
    // TODO: Implementar busca real no Supabase
    return [
      Lesson(
        id: '1',
        title: 'Meditação Guiada',
        description: 'Uma meditação guiada para iniciantes',
        thumbnailUrl: 'https://picsum.photos/400/225',
        durationMinutes: 10,
        isPremium: false,
        progress: 0.5,
      ),
    ];
  }

  Future<Challenge?> _getCurrentChallenge() async {
    // TODO: Implementar busca real no Supabase
    return Challenge(
      id: '1',
      title: '7 Dias de Mindfulness',
      description: 'Pratique mindfulness por 7 dias consecutivos',
      points: 100,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 7)),
      progress: 0.3,
      totalParticipants: 50,
      completedParticipants: 15,
    );
  }

  Future<bool> isAdmin() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return false;

    final response = await _supabase
        .from('profiles')
        .select('is_admin')
        .eq('id', user.id)
        .single();

    return response['is_admin'] ?? false;
  }
}
