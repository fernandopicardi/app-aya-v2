import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:app_aya_v2/core/theme/app_theme.dart';
import 'package:app_aya_v2/config/routes.dart';
import 'package:app_aya_v2/widgets/aya_bottom_nav.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'admin_menu.dart';
import 'package:app_aya_v2/features/auth/services/auth_service.dart';
import 'package:app_aya_v2/widgets/aya_glass_container.dart';
import 'package:app_aya_v2/widgets/aya_glass_dialog.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;

import 'sections/admin_dashboard_overview.dart';
// TODO: Criar este componente/página
// import 'sections/admin_analytics_screen.dart';
// TODO: Criar este componente/página
// import 'sections/admin_settings_screen.dart';
import 'sections/admin_users_section.dart';
import 'sections/admin_content_section.dart';
// TODO: Criar este componente/página
// import 'sections/admin_moderation_section.dart';
// TODO: Criar este componente/página
// import 'sections/admin_gamification_section.dart';
// TODO: Criar este componente/página
// import 'sections/admin_logs_section.dart';
import 'sections/admin_settings_section.dart';

class GlassmorphicAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool centerTitle;
  final double elevation;

  const GlassmorphicAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.centerTitle = true,
    this.elevation = 0,
  });

  @override
  Widget build(BuildContext context) {
    return AyaGlassContainer(
      borderRadius: 0,
      blurRadius: 15,
      padding: EdgeInsets.zero,
      child: AppBar(
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AyaColors.textPrimary,
            shadows: [
              Shadow(
                color: AyaColors.black60,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: centerTitle,
        leading: leading,
        actions: actions,
        elevation: elevation,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({super.key});

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  bool _isLoading = true;
  final bool _isAdmin = false;
  int _selectedIndex = 0;

  final List<AyaBottomNavItem> _navItems = [
    AyaBottomNavItem(
      label: 'Dashboard',
      iconoirIcon: const iconoir.Dashboard(),
      selectedIconoirIcon: const iconoir.Dashboard(),
    ),
    AyaBottomNavItem(
      label: 'Users',
      iconoirIcon: const iconoir.Group(),
      selectedIconoirIcon: const iconoir.Group(),
    ),
    AyaBottomNavItem(
      label: 'Settings',
      iconoirIcon: const iconoir.Settings(),
      selectedIconoirIcon: const iconoir.Settings(),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
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

  Future<void> _handleSignOut() async {
    try {
      final navigator = Navigator.of(context);
      await Supabase.instance.client.auth.signOut();
      if (mounted) {
        navigator.pushReplacementNamed('/login');
      }
    } catch (e) {
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AyaGlassAlertDialog(
            title: 'Erro',
            message: e.toString(),
          ),
        );
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
      // TODO: Criar este componente/página
      // case 3:
      //   return const AdminModerationSection();
      // TODO: Criar este componente/página
      // case 4:
      //   return const AdminGamificationSection();
      // TODO: Criar este componente/página
      // case 5:
      //   return const AdminLogsSection();
      case 6:
        return const AdminSettingsSection();
      default:
        return const AdminDashboardOverview();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: AyaColors.background,
        body: Center(
          child: AyaGlassContainer(
            borderRadius: 16,
            blurRadius: 15,
            padding: const EdgeInsets.all(24),
            child: const CircularProgressIndicator(),
          ),
        ),
      );
    }

    if (!_isAdmin) {
      return Scaffold(
        backgroundColor: AyaColors.background,
        appBar: GlassmorphicAppBar(title: 'Admin'),
        body: Center(
          child: AyaGlassContainer(
            borderRadius: 16,
            blurRadius: 15,
            padding: const EdgeInsets.all(24),
            child: const Text(
              'Acesso restrito apenas para administradores.',
              style: TextStyle(
                color: AyaColors.textPrimary,
                fontSize: 16,
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AyaColors.background,
      appBar: GlassmorphicAppBar(
        title: 'Painel de Administração',
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AyaGlassConfirmDialog(
                  title: 'Sair',
                  message: 'Tem certeza que deseja sair?',
                  onConfirm: _handleSignOut,
                ),
              );
            },
          ),
        ],
      ),
      drawer: AyaGlassContainer(
        borderRadius: 0,
        blurRadius: 15,
        padding: EdgeInsets.zero,
        child: AdminMenu(
          selectedIndex: _selectedIndex,
          onItemSelected: (i) => setState(() => _selectedIndex = i),
        ),
      ),
      bottomNavigationBar: AyaGlassContainer(
        borderRadius: 0,
        blurRadius: 15,
        padding: EdgeInsets.zero,
        child: AyaBottomNav(
          currentIndex: _selectedIndex,
          items: _navItems,
          onTap: (index) => setState(() => _selectedIndex = index),
        ),
      ),
      body: Row(
        children: [
          if (MediaQuery.of(context).size.width > 900)
            SizedBox(
              width: 240,
              child: AyaGlassContainer(
                borderRadius: 0,
                blurRadius: 15,
                padding: EdgeInsets.zero,
                child: AdminMenu(
                  selectedIndex: _selectedIndex,
                  onItemSelected: (i) => setState(() => _selectedIndex = i),
                ),
              ),
            ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: AyaGlassContainer(
                borderRadius: 16,
                blurRadius: 15,
                padding: const EdgeInsets.all(24),
                child: _getSection(_selectedIndex),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
