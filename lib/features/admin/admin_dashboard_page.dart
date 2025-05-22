import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:app_aya_v2/theme/aya_theme.dart';
import 'package:app_aya_v2/config/routes.dart';
import 'package:app_aya_v2/widgets/aya_bottom_nav.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'admin_menu.dart';

import 'sections/admin_dashboard_overview.dart';
import 'sections/admin_users_section.dart';
import 'sections/admin_content_section.dart';
import 'sections/admin_moderation_section.dart';
import 'sections/admin_gamification_section.dart';
import 'sections/admin_logs_section.dart';
import 'sections/admin_settings_section.dart';

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({Key? key}) : super(key: key);

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  bool _isLoading = true;
  final bool _isAdmin = false;
  int _selectedIndex = 0;

  final List<AyaBottomNavItem> _navItems = [
    const AyaBottomNavItem(
      label: 'Dashboard',
      icon: Icons.dashboard_outlined,
      selectedIcon: Icons.dashboard,
    ),
    const AyaBottomNavItem(
      label: 'Users',
      icon: Icons.people_outline,
      selectedIcon: Icons.people,
    ),
    const AyaBottomNavItem(
      label: 'Settings',
      icon: Icons.settings_outlined,
      selectedIcon: Icons.settings,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      // Simular carregamento
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Widget _getSection(int index) {
    switch (index) {
      case 0:
        return const AdminDashboardOverview();
      case 1:
        return const AdminUsersSection();
      case 2:
        return const AdminContentSection();
      case 3:
        return const AdminModerationSection();
      case 4:
        return const AdminGamificationSection();
      case 5:
        return const AdminLogsSection();
      case 6:
        return const AdminSettingsSection();
      default:
        return const AdminDashboardOverview();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (!_isAdmin) {
      return Scaffold(
        appBar: AppBar(title: const Text('Admin')),
        body: const Center(
            child: Text('Acesso restrito apenas para administradores.')),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Painel de Administração'),
        backgroundColor: AyaColors.turquoise,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await Supabase.instance.client.auth.signOut();
              if (mounted) {
                context.go(AppRouter.login);
              }
            },
          ),
        ],
      ),
      drawer: AdminMenu(
        selectedIndex: _selectedIndex,
        onItemSelected: (i) => setState(() => _selectedIndex = i),
      ),
      bottomNavigationBar: AyaBottomNav(
        currentIndex: _selectedIndex,
        items: _navItems,
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
      backgroundColor: AyaColors.background,
      body: Row(
        children: [
          if (MediaQuery.of(context).size.width > 900)
            SizedBox(
              width: 240,
              child: AdminMenu(
                selectedIndex: _selectedIndex,
                onItemSelected: (i) => setState(() => _selectedIndex = i),
              ),
            ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: _getSection(_selectedIndex),
            ),
          ),
        ],
      ),
    );
  }
}
