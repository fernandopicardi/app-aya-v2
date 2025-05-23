import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../features/auth/services/auth_service.dart';
import '../widgets/dashboard_widgets.dart';
import '../widgets/aya_app_bar.dart';
import '../widgets/aya_bottom_nav.dart';
import '../widgets/aya_drawer.dart';
import '../widgets/aya_cards.dart';
import '../../../core/routes/app_router.dart';
import '../../lessons/screens/lessons_list_screen.dart';
import '../../../core/theme/app_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import '../../../widgets/aya_button.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _authService = AuthService();
  int _selectedIndex = 0;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int _heroPage = 0;

  final List<Map<String, String>> _heroSlides = [
    {
      'title': 'Bem-vindo(a) ao AYA',
      'desc':
          'Explore nosso conteúdo e comece sua jornada de autoconhecimento.',
      'img':
          'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=800&q=80',
      'cta': 'Começar Agora',
    },
    {
      'title': 'Medite com a gente',
      'desc': 'Práticas guiadas para o seu equilíbrio diário.',
      'img':
          'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=800&q=80',
      'cta': 'Meditar',
    },
    {
      'title': 'Descubra Novos Conteúdos',
      'desc': 'Aulas, artigos e trilhas para seu desenvolvimento.',
      'img':
          'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=800&q=80',
      'cta': 'Explorar',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
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
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        SizedBox(
          height: MediaQuery.of(context).padding.top + kToolbarHeight + 12,
        ),
        _buildHeroSection(),
        const SizedBox(height: 24),
        _buildContinueLearningSection(),
        const SizedBox(height: 24),
        _buildRecommendedSection(),
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

  Widget _buildHeroSection() {
    final height = MediaQuery.of(context).size.height * 0.30;
    return Column(
      children: [
        SizedBox(
          height: height,
          child: PageView.builder(
            itemCount: _heroSlides.length,
            onPageChanged: (i) => setState(() => _heroPage = i),
            itemBuilder: (context, i) {
              final slide = _heroSlides[i];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular(AppConstants.radius32),
                      child: Image.network(
                        slide['img']!,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(AppConstants.radius32),
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.6),
                            Colors.transparent
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            slide['title']!,
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(
                                  color: AyaColors.textPrimary,
                                ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            slide['desc']!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                  color:
                                      AyaColors.textPrimary.withOpacity(0.85),
                                ),
                          ),
                          const SizedBox(height: 16),
                          AyaButton(
                            text: slide['cta']!,
                            onPressed: () {},
                            variant: AyaButtonVariant.primary,
                            isFullWidth: false,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_heroSlides.length, (i) {
            final selected = i == _heroPage;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: selected ? 16 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: selected ? AyaColors.turquoise : AyaColors.textPrimary40,
                borderRadius: BorderRadius.circular(8),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildContinueLearningSection() {
    final List<Map<String, dynamic>> lessons = [
      {
        'title': 'Meditação Guiada',
        'subtitle': 'Continue de onde parou',
        'img': 'https://picsum.photos/seed/aya1/300/200',
        'plan': 'premium',
      },
      {
        'title': 'Respiração Consciente',
        'subtitle': 'Aula 2 de 5',
        'img': 'https://picsum.photos/seed/aya2/300/200',
        'plan': 'free',
      },
      {
        'title': 'Mindfulness para Ansiedade',
        'subtitle': 'Aula 1 de 4',
        'img': 'https://picsum.photos/seed/aya3/300/200',
        'plan': 'premium',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Continue Aprendendo',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: AyaColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 220,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: lessons.length,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, i) {
              final lesson = lessons[i];
              return Container(
                width: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AyaColors.overlayDark.withOpacity(0.10),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: lesson['img']!,
                            width: 160,
                            height: 110,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: AyaColors.lavenderSoft,
                              highlightColor: AyaColors.lavenderVibrant,
                              child: Container(
                                width: 160,
                                height: 110,
                                color: AyaColors.lavenderSoft,
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              width: 160,
                              height: 110,
                              color: AyaColors.lavenderSoft,
                              child: const Icon(Icons.broken_image,
                                  color: Colors.white54),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: _buildPlanTag(lesson['plan']!),
                        ),
                      ],
                    ),
                    Container(
                      width: 160,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AyaColors.surface.withOpacity(0.7),
                            AyaColors.surface.withOpacity(0.5),
                          ],
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(24),
                          bottomRight: Radius.circular(24),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            lesson['title']!,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: AyaColors.textPrimary,
                                  fontWeight: FontWeight.bold,
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            lesson['subtitle']!,
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AyaColors.textSecondary,
                                    ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendedSection() {
    final List<Map<String, dynamic>> lessons = [
      {
        'title': 'Yoga para Iniciantes',
        'subtitle': 'Aula 1 de 6',
        'img': 'https://picsum.photos/seed/aya4/300/200',
        'plan': 'free',
      },
      {
        'title': 'Sono Profundo',
        'subtitle': 'Meditação Noturna',
        'img': 'https://picsum.photos/seed/aya5/300/200',
        'plan': 'premium',
      },
      {
        'title': 'Autocompaixão',
        'subtitle': 'Aula 3 de 5',
        'img': 'https://picsum.photos/seed/aya6/300/200',
        'plan': 'premium',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recomendados para Você',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: AyaColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 220,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: lessons.length,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, i) {
              final lesson = lessons[i];
              return Container(
                width: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AyaColors.overlayDark.withOpacity(0.10),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: lesson['img']!,
                            width: 160,
                            height: 110,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: AyaColors.lavenderSoft,
                              highlightColor: AyaColors.lavenderVibrant,
                              child: Container(
                                width: 160,
                                height: 110,
                                color: AyaColors.lavenderSoft,
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              width: 160,
                              height: 110,
                              color: AyaColors.lavenderSoft,
                              child: const Icon(Icons.broken_image,
                                  color: Colors.white54),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: _buildPlanTag(lesson['plan']!),
                        ),
                      ],
                    ),
                    Container(
                      width: 160,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AyaColors.surface.withOpacity(0.7),
                            AyaColors.surface.withOpacity(0.5),
                          ],
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(24),
                          bottomRight: Radius.circular(24),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            lesson['title']!,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: AyaColors.textPrimary,
                                  fontWeight: FontWeight.bold,
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            lesson['subtitle']!,
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AyaColors.textSecondary,
                                    ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPlanTag(String plan) {
    if (plan == 'premium') {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: AyaColors.lavenderVibrant.withOpacity(0.3),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.lock,
              size: 12,
              color: AyaColors.turquoise,
            ),
            const SizedBox(width: 4),
            Text(
              'Premium',
              style: TextStyle(
                color: AyaColors.textPrimary,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: AyaColors.turquoise.withOpacity(0.3),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          'Gratuito',
          style: TextStyle(
            color: AyaColors.textPrimary,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }
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
