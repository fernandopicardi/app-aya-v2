// App Widget - Root widget of the MaterialApp

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'routes.dart'; // Importar o goRouterProvider

class AppWidget extends ConsumerWidget {
  // Mudar para ConsumerWidget
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Adicionar WidgetRef ref
    final router = ref.watch(goRouterProvider); // Ler o provider do GoRouter

    return MaterialApp.router(
      title: 'App Aya',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      routerConfig: router, // Usar routerConfig
    );
  }
}
