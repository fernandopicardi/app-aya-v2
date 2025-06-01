// Routes configuration using GoRouter

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/features/dashboard/presentation/screens/splash_screen.dart';
import 'package:app/features/auth/presentation/screens/login_screen.dart';
import 'package:app/features/auth/presentation/screens/signup_screen.dart';
import 'package:app/features/auth/presentation/screens/user_profile_screen.dart';
import 'package:app/features/dashboard/presentation/screens/home_screen.dart';
import 'package:app/features/content_library/presentation/screens/library_screen.dart';
import 'package:app/features/community/presentation/screens/community_screen.dart';
import 'package:app/features/chat_ia/presentation/screens/chat_ia_screen.dart';
import 'package:app/shared/widgets/main_scaffold_widget.dart';

// TODO: Definir telas de placeholder para / e /login
// import 'package:app/features/auth/presentation/screens/login_screen.dart';
// import 'package:app/features/dashboard/presentation/screens/dashboard_screen.dart';

// Nomes de Rotas (exemplo, será expandido em core/constants/)
class AppRouteNames {
  static const String splash = '/'; // Ou home/dashboard inicial
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String library = '/library';
  static const String community = '/community';
  static const String chatIA = '/chat-ia';
  static const String userProfile = '/profile';
  // Adicionar outras conforme necessário
}

final goRouterProvider = Provider<GoRouter>((ref) {
  // Criar como um Provider para fácil acesso/mocking
  return GoRouter(
    initialLocation: AppRouteNames.splash,
    debugLogDiagnostics: true, // Útil para depuração de rotas
    routes: <RouteBase>[
      GoRoute(
        path: AppRouteNames.splash,
        name: AppRouteNames.splash,
        builder: (BuildContext context, GoRouterState state) {
          return const SplashScreen();
        },
      ),
      GoRoute(
        path: AppRouteNames.login,
        name: AppRouteNames.login,
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: AppRouteNames.signup,
        name: AppRouteNames.signup,
        builder: (BuildContext context, GoRouterState state) {
          return const SignUpScreen();
        },
      ),
      GoRoute(
        path: AppRouteNames.userProfile,
        name: AppRouteNames.userProfile,
        builder: (BuildContext context, GoRouterState state) {
          return const UserProfileScreen();
        },
      ),
      ShellRoute(
        navigatorKey: GlobalKey<NavigatorState>(),
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return MainScaffoldWidget(child: child);
        },
        routes: <RouteBase>[
          GoRoute(
            path: AppRouteNames.home,
            name: AppRouteNames.home,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: HomeScreen()),
          ),
          GoRoute(
            path: AppRouteNames.library,
            name: AppRouteNames.library,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: LibraryScreen()),
          ),
          GoRoute(
            path: AppRouteNames.community,
            name: AppRouteNames.community,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: CommunityScreen()),
          ),
          GoRoute(
            path: AppRouteNames.chatIA,
            name: AppRouteNames.chatIA,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: ChatIAScreen()),
          ),
        ],
      ),
      // TODO: Adicionar outras rotas (dashboard, settings, etc.)
    ],
    errorBuilder: (context, state) => Scaffold(
      // Tela de erro básica
      appBar: AppBar(title: const Text('Erro de Rota')),
      body: Center(
        child: Text('Página não encontrada: ${state.error?.message}'),
      ),
    ),
    // TODO: Adicionar redirect para lógica de autenticação
    // redirect: (BuildContext context, GoRouterState state) {
    //   final bool loggedIn = ref.watch(authProvider).isLoggedIn; // Exemplo
    //   final bool loggingIn = state.matchedLocation == AppRouteNames.login;
    //   if (!loggedIn && !loggingIn) return AppRouteNames.login;
    //   if (loggedIn && loggingIn) return AppRouteNames.splash;
    //   return null;
    // },
  );
});
