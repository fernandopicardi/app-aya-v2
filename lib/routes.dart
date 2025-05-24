import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'features/auth/screens/login_screen.dart';
import 'features/auth/screens/register_screen.dart';
import 'features/auth/screens/forgot_password_page.dart';
import 'features/dashboard/screens/dashboard_screen.dart';
import 'features/lessons/screens/lessons_list_screen.dart';
// TODO: Implement lesson page
// import 'features/lessons/screens/lesson_page.dart';
import 'features/admin/screens/admin_dashboard_screen.dart';
import 'features/admin/screens/admin_analytics_screen.dart';
import 'features/admin/screens/admin_settings_screen.dart';
// TODO: Implement drawer
// import 'features/dashboard/widgets/aya_drawer.dart';
import 'features/auth/services/auth_service.dart';

class Routes {
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String dashboard = '/dashboard';
  static const String library = '/dashboard/library';
  static const String community = '/dashboard/community';
  static const String chat = '/dashboard/chat';
  static const String adminDashboard = '/admin/dashboard';
  static const String adminUsers = '/admin/users';
  static const String adminContent = '/admin/content';
  static const String adminGamification = '/admin/gamification';
  static const String adminAnalytics = '/admin/analytics';
  static const String adminSettings = '/admin/settings';

  static final router = GoRouter(
    initialLocation: '/dashboard',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) => const ForgotPasswordPage(),
      ),
      // Main dashboard with nested routes
      ShellRoute(
        builder: (context, state, child) {
          final authService = AuthService();
          return DashboardScreen(
            authService: authService,
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: '/dashboard',
            builder: (context, state) => const HomeTabWidget(),
          ),
          GoRoute(
            path: '/dashboard/library',
            builder: (context, state) => const LessonsListScreen(),
          ),
          GoRoute(
            path: '/dashboard/community',
            builder: (context, state) =>
                const Center(child: Text('Comunidade')),
          ),
          GoRoute(
            path: '/dashboard/chat',
            builder: (context, state) => const Center(child: Text('Aya Chat')),
          ),
        ],
      ),
      // Admin routes
      GoRoute(
        path: '/admin/dashboard',
        builder: (context, state) => const AdminDashboardScreen(),
      ),
      GoRoute(
        path: '/admin/users',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Admin Users Screen - TODO')),
        ),
      ),
      GoRoute(
        path: '/admin/content',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Admin Content Screen - TODO')),
        ),
      ),
      GoRoute(
        path: '/admin/gamification',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Admin Gamification Screen - TODO')),
        ),
      ),
      GoRoute(
        path: '/admin/analytics',
        builder: (context, state) => const AdminAnalyticsScreen(),
      ),
      GoRoute(
        path: '/admin/settings',
        builder: (context, state) => const AdminSettingsScreen(),
      ),
    ],
  );
}
