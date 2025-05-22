import 'package:flutter/material.dart';
import 'features/auth/screens/login_screen.dart';
import 'features/auth/screens/register_screen.dart';
import 'features/auth/screens/forgot_password_page.dart';
import 'features/dashboard/screens/dashboard_screen.dart';
import 'features/admin/screens/admin_dashboard_screen.dart';
import 'features/admin/screens/admin_users_screen.dart';
import 'features/admin/screens/admin_content_screen.dart';
import 'features/admin/screens/admin_gamification_screen.dart';
import 'features/admin/screens/admin_analytics_screen.dart';
import 'features/admin/screens/admin_settings_screen.dart';

class Routes {
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String dashboard = '/dashboard';
  static const String adminDashboard = '/admin/dashboard';
  static const String adminUsers = '/admin/users';
  static const String adminContent = '/admin/content';
  static const String adminGamification = '/admin/gamification';
  static const String adminAnalytics = '/admin/analytics';
  static const String adminSettings = '/admin/settings';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      login: (context) => const LoginScreen(),
      register: (context) => const RegisterScreen(),
      forgotPassword: (context) => const ForgotPasswordPage(),
      dashboard: (context) => const DashboardScreen(),
      adminDashboard: (context) => const AdminDashboardScreen(),
      adminUsers: (context) => const AdminUsersScreen(),
      adminContent: (context) => const AdminContentScreen(),
      adminGamification: (context) => const AdminGamificationScreen(),
      adminAnalytics: (context) => const AdminAnalyticsScreen(),
      adminSettings: (context) => const AdminSettingsScreen(),
    };
  }
}
