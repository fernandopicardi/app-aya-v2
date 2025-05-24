import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// TODO: Implement app theme
import 'core/theme/app_theme.dart';
// TODO: Implement routes
import 'routes.dart';
// TODO: Implement auth service
import 'features/auth/services/auth_service.dart';
// TODO: Implement dashboard service
// import 'features/dashboard/services/dashboard_service.dart';
// TODO: Implement lessons service
// import 'features/lessons/services/lessons_service.dart';
// TODO: Implement community service
// import 'features/community/services/community_service.dart';
// TODO: Implement chat service
// import 'features/chat/services/chat_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'YOUR_SUPABASE_URL',
    anonKey: 'YOUR_SUPABASE_ANON_KEY',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Aya',
      theme: AyaTheme.theme,
      themeMode: ThemeMode.system,
      routerConfig: Routes.router,
      debugShowCheckedModeBanner: false,
    );
  }
}
