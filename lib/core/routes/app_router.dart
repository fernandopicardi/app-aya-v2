import 'package:flutter/material.dart';
import '../../features/dashboard/screens/dashboard_screen.dart';
import '../../features/lessons/screens/lessons_list_screen.dart';
import '../../features/lessons/screens/lesson_page.dart';
import '../../features/lessons/models/lesson.dart';
import '../../features/auth/services/auth_service.dart';

class AppRouter {
  static const String dashboard = '/dashboard';
  static const String lessons = '/lessons';
  static const String lesson = '/lesson';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case dashboard:
        return MaterialPageRoute(
          builder: (_) => DashboardScreen(
            authService: AuthService(),
            child: const HomeTabWidget(),
          ),
        );
      case lessons:
        return MaterialPageRoute(
          builder: (_) => const LessonsListScreen(),
        );
      case lesson:
        final lesson = settings.arguments as Lesson;
        return MaterialPageRoute(
          builder: (_) => LessonPage(lesson: lesson),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('Rota não encontrada: ${settings.name}'),
            ),
          ),
        );
    }
  }
}
