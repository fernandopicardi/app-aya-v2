// Routes configuration using GoRouter

import 'package:app/app_widget.dart'; // Placeholder, pode ser uma tela de erro real depois
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// TODO: Definir telas de placeholder para / e /login
// import 'package:app/features/auth/presentation/screens/login_screen.dart';
// import 'package:app/features/dashboard/presentation/screens/dashboard_screen.dart';

// Nomes de Rotas (exemplo, será expandido em core/constants/)
class AppRouteNames {
  static const String splash = '/'; // Ou home/dashboard inicial
  static const String login = '/login';
  // Adicionar outras conforme necessário
}

final goRouterProvider = Provider<GoRouter>((ref) {
  // Criar como um Provider para fácil acesso/mocking
  return GoRouter(
    initialLocation: AppRouteNames
        .splash, // Mude para /login se não houver lógica de splash/auth check ainda
    debugLogDiagnostics: true, // Útil para depuração de rotas
    routes: <RouteBase>[
      GoRoute(
        path: AppRouteNames.splash,
        name: AppRouteNames.splash,
        builder: (BuildContext context, GoRouterState state) {
          // TODO: Implementar tela de Splash ou Home/Dashboard
          return Scaffold(
            appBar: AppBar(title: const Text('App Aya - Splash/Home')),
            body: const Center(child: Text('Conteúdo Splash/Home')),
          );
        },
      ),
      GoRoute(
        path: AppRouteNames.login,
        name: AppRouteNames.login,
        builder: (BuildContext context, GoRouterState state) {
          // TODO: Implementar LoginScreen real
          return Scaffold(
            appBar: AppBar(title: const Text('Login')),
            body: const Center(child: Text('Conteúdo Login')),
          );
        },
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
