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
