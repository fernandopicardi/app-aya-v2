import 'dart:async'; // For StreamSubscription
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // For Supabase auth state

// Importação da página inicial
import '../features/home/home_page.dart';
// Importação das páginas de autenticação
import '../features/auth/login_page.dart';
import '../features/auth/register_page.dart';
import '../features/auth/forgot_password_page.dart'; // Importar a nova página
import '../features/content/pages/content_modules_page.dart';
import '../features/landing/landing_page.dart';
import '../features/subscription/subscription_plans_page.dart';
import '../features/auth/simple_register_page.dart';
import '../features/subscription/payment_page.dart';
import '../features/dashboard/user_dashboard_page.dart';
import '../features/admin/admin_dashboard_page.dart';

// Helper class to convert a Stream to a Listenable for GoRouter
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

/// Configuração das rotas do aplicativo usando go_router
class AppRouter {
  // Definição das rotas nomeadas para facilitar a navegação
  static const String home = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String profile = '/profile';
  static const String contentModules = '/content/modules';
  static const String contentFolders = '/content/modules/:moduleId/folders';
  static const String contentLessons = '/content/folders/:folderId/lessons';
  static const String meditation = '/meditation';
  static const String community = '/community';
  static const String chatbot = '/chatbot';
  static const String forgotPassword = '/forgot-password'; // Nova rota
  static const String landing = '/';
  static const String subscriptionPlans = '/plans';
  static const String simpleRegister = '/simple-register';
  static const String payment = '/payment';
  static const String dashboard = '/dashboard';
  static const String adminDashboard = '/admin';
  
  // Configuração do router
  static final GoRouter router = GoRouter(
    initialLocation: landing,
    debugLogDiagnostics: true,
    refreshListenable: GoRouterRefreshStream(Supabase.instance.client.auth.onAuthStateChange),
    redirect: (BuildContext context, GoRouterState state) {
      final supabase = Supabase.instance.client;
      final loggedIn = supabase.auth.currentUser != null;
      final loggingIn = state.matchedLocation == AppRouter.login || 
                       state.matchedLocation == AppRouter.register ||
                       state.matchedLocation == AppRouter.forgotPassword;
      final isLanding = state.matchedLocation == AppRouter.landing;

      // Permite acesso público à LandingPage
      if (!loggedIn && !loggingIn && !isLanding) {
        return AppRouter.login;
      }

      // Se já está logado e tentando acessar login/register, redireciona para dashboard
      if (loggedIn && loggingIn) {
        return AppRouter.dashboard;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: landing,
        name: 'landing',
        builder: (context, state) => const LandingPage(),
      ),
      GoRoute(
        path: home,
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: login,
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: register,
        name: 'register',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: forgotPassword,
        name: 'forgotPassword',
        builder: (context, state) => const ForgotPasswordPage(),
      ),
      GoRoute(
        path: contentModules,
        name: 'contentModules',
        builder: (context, state) => const ContentModulesPage(),
      ),
      GoRoute(
        path: subscriptionPlans,
        name: 'subscriptionPlans',
        builder: (context, state) => const SubscriptionPlansPage(),
      ),
      GoRoute(
        path: simpleRegister,
        name: 'simpleRegister',
        builder: (context, state) => const SimpleRegisterPage(),
      ),
      GoRoute(
        path: payment,
        name: 'payment',
        builder: (context, state) {
          final plan = state.extra is Map ? (state.extra as Map)['plan'] as String : '';
          final price = state.extra is Map ? (state.extra as Map)['price'] as String : '';
          final benefits = state.extra is Map ? (state.extra as Map)['benefits'] as List<String> : <String>[];
          return PaymentPage(plan: plan, price: price, benefits: benefits);
        },
      ),
      GoRoute(
        path: dashboard,
        name: 'dashboard',
        builder: (context, state) => const UserDashboardPage(),
      ),
      GoRoute(
        path: adminDashboard,
        name: 'adminDashboard',
        builder: (context, state) => const AdminDashboardPage(),
      ),
      // Outras rotas serão adicionadas conforme o desenvolvimento do aplicativo
    ],
    // Tratamento de erros de navegação
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text(
          'Página não encontrada: ${state.uri}',
          style: const TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
}