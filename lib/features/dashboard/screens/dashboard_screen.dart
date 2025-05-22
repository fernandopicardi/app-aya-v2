import 'package:flutter/material.dart';
import '../../../features/auth/services/auth_service.dart';
import '../../../core/theme/app_theme.dart';
import '../widgets/aya_app_bar.dart';
import '../widgets/aya_bottom_nav.dart';
import '../widgets/aya_drawer.dart';
import '../widgets/aya_cards.dart';
import '../../../core/routes/app_router.dart';
import '../../lessons/screens/lessons_list_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _authService = AuthService();
  int _selectedIndex = 0;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AyaAppBar(
        onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
        notificationCount: 3, // TODO: Get from notification service
      ),
      drawer: AyaDrawer(authService: _authService),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildHomeTab(),
          _buildLibraryTab(),
          _buildCommunityTab(),
          _buildChatTab(),
          _buildProfileTab(),
        ],
      ),
      bottomNavigationBar: AyaBottomNav(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
        },
      ),
    );
  }

  Widget _buildHomeTab() {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          title: Text('AYA'),
          floating: true,
          snap: true,
          backgroundColor: AyaColors.surface,
          foregroundColor: AyaColors.textPrimary,
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              _buildWelcomeCard(),
              const SizedBox(height: 24),
              _buildContinueLearningSection(),
              const SizedBox(height: 24),
              _buildRecommendedSection(),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildLibraryTab() {
    return Navigator(
      onGenerateRoute: (settings) {
        if (settings.name == '/') {
          return MaterialPageRoute(
            builder: (_) => const LessonsListScreen(),
          );
        }
        return null;
      },
    );
  }

  Widget _buildCommunityTab() {
    return const Center(child: Text('Comunidade'));
  }

  Widget _buildChatTab() {
    return const Center(child: Text('Chat IA'));
  }

  Widget _buildProfileTab() {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          title: Text('Meu Perfil'),
          floating: true,
          snap: true,
          backgroundColor: AyaColors.surface,
          foregroundColor: AyaColors.textPrimary,
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              _buildProfileCard(),
              const SizedBox(height: 24),
              _buildDownloadsSection(),
              const SizedBox(height: 24),
              _buildSettingsSection(),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildWelcomeCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AyaColors.lavenderSoft,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bem-vindo(a) ao AYA',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AyaColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Explore nosso conteúdo e comece sua jornada de autoconhecimento.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AyaColors.textPrimary60,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueLearningSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Continue Aprendendo',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AyaColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        // TODO: Implementar lista de aulas em progresso
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: AyaColors.lavenderSoft,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Center(
            child: Text('Nenhuma aula em progresso'),
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recomendados para Você',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AyaColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        // TODO: Implementar lista de aulas recomendadas
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: AyaColors.lavenderSoft,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Center(
            child: Text('Nenhuma recomendação disponível'),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AyaColors.lavenderSoft,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 48,
            backgroundColor: AyaColors.turquoise,
            child: Icon(
              Icons.person,
              size: 48,
              color: AyaColors.surface,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Usuário AYA',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AyaColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'usuario@aya.com',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AyaColors.textPrimary60,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildDownloadsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Downloads',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AyaColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        // TODO: Implementar lista de downloads
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: AyaColors.lavenderSoft,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Center(
            child: Text('Nenhum download disponível'),
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Configurações',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AyaColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: AyaColors.lavenderSoft,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.notifications_outlined),
                title: const Text('Notificações'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  // TODO: Implementar configurações de notificações
                },
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.dark_mode_outlined),
                title: const Text('Tema'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  // TODO: Implementar configurações de tema
                },
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Sair'),
                onTap: () {
                  // TODO: Implementar logout
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
