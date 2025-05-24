import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/dashboard_models.dart';

class DashboardService {
  final _supabase = Supabase.instance.client;

  Future<DashboardData> getDashboardData() async {
    // Simulando dados mockados
    return DashboardData(
      continueLearning: [
        Lesson(
          id: '1',
          title: 'Introdução à Meditação',
          description: 'Aprenda os fundamentos da meditação',
          thumbnailUrl: 'https://picsum.photos/seed/meditation1/400/300',
          durationMinutes: 15,
          isPremium: false,
          progress: 0.3,
        ),
        Lesson(
          id: '2',
          title: 'Técnicas de Respiração',
          description: 'Exercícios para melhorar sua respiração',
          thumbnailUrl: 'https://picsum.photos/seed/meditation2/400/300',
          durationMinutes: 20,
          isPremium: false,
          progress: 0.0,
        ),
      ],
      recommendedLessons: [
        Lesson(
          id: '3',
          title: 'Meditação para Ansiedade',
          description: 'Técnicas específicas para reduzir a ansiedade',
          thumbnailUrl: 'https://picsum.photos/seed/meditation3/400/300',
          durationMinutes: 25,
          isPremium: true,
          progress: 0.0,
        ),
        Lesson(
          id: '4',
          title: 'Mindfulness no Trabalho',
          description: 'Pratique mindfulness durante sua jornada',
          thumbnailUrl: 'https://picsum.photos/seed/meditation4/400/300',
          durationMinutes: 30,
          isPremium: false,
          progress: 0.0,
        ),
      ],
      modules: [
        Module(
          id: '1',
          title: 'Meditação para Iniciantes',
          description: 'Aprenda técnicas básicas de meditação',
          coverUrl: 'https://picsum.photos/seed/module1/800/400',
          isPremium: false,
          progress: 0.4,
          totalLessons: 10,
          completedLessons: 4,
        ),
      ],
      challenges: [
        Challenge(
          id: '1',
          title: 'Desafio da Meditação Diária',
          description: 'Medite por 7 dias consecutivos',
          points: 100,
          startDate: DateTime.now(),
          endDate: DateTime.now().add(const Duration(days: 7)),
          progress: 0.3,
          totalParticipants: 100,
          completedParticipants: 30,
        ),
      ],
      dailyTip: DailyTip(
        message:
            'A meditação regular pode reduzir o estresse e melhorar o foco.',
        author: 'Aya',
      ),
      userProgress: UserProgress(
        level: 'Iniciante',
        currentPoints: 250,
        nextLevelPoints: 500,
        progressPercentage: 0.5,
      ),
    );
  }

  // TODO: Implement daily tip functionality
  /*
  Future<String> _getDailyTip() async {
    // Implementation needed
    return 'Daily tip placeholder';
  }
  */

  // TODO: Implement last accessed lesson functionality
  /*
  Future<Lesson> _getLastAccessedLesson() async {
    // Implementation needed
    return Lesson(
      id: '1',
      title: 'Last accessed lesson',
      description: 'Description',
      duration: 30,
      difficulty: 'Beginner',
      category: 'Category',
      thumbnailUrl: 'https://example.com/thumbnail.jpg',
    );
  }
  */

  // TODO: Implement recommended lessons functionality
  /*
  Future<List<Lesson>> _getRecommendedLessons() async {
    // Implementation needed
    return [];
  }
  */

  // TODO: Implement modules functionality
  /*
  Future<List<Module>> _getModules() async {
    // Implementation needed
    return [];
  }
  */

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
