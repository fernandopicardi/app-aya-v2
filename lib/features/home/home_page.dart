import 'package:flutter/material.dart';
import '../dashboard/user_dashboard_page.dart';

/// Página inicial do aplicativo
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Temporarily bypassing authentication
    return const UserDashboardPage();
  }
}
