import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import '../../../core/theme/app_theme.dart';
import '../../../features/auth/services/auth_service.dart';
import '../widgets/aya_app_bar.dart';
import '../widgets/aya_bottom_nav.dart';
import '../widgets/aya_drawer.dart';
import '../../lessons/screens/lessons_list_screen.dart';
import '../../../core/theme/app_constants.dart';
import 'package:shimmer/shimmer.dart';
import '../../../widgets/aya_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/rendering.dart';
import '../../../core/widgets/aya_bottom_sheet.dart';
import '../../../features/dashboard/services/dashboard_service.dart';

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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: _buildContinueLearningSection(),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: _buildRecommendedSection(),
        ),
        const SizedBox(height: 24),
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
    // TODO: Criar componente de feed da comunidade
    return const Center(child: Text('Comunidade'));
  }

  Widget _buildChatTab() {
    // TODO: Criar componente de chat
    return const Center(child: Text('Aya Chat'));
  }

  Widget _buildProfileTab() {
    return CustomScrollView(
      slivers: [
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
    final height = MediaQuery.of(context).size.height * 0.28;
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
                    // Background Image with Blur
                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular(AppConstants.radius32),
                      child: ImageFiltered(
                        imageFilter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                        child: CachedNetworkImage(
                          imageUrl: slide['img']!,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              color: Colors.white,
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: Colors.grey[300],
                            child: const Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                    // Glassy Overlay
                    Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(AppConstants.radius32),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.4),
                            Colors.black.withValues(alpha: 0.8),
                          ],
                          stops: const [0.3, 1.0],
                        ),
                      ),
                    ),
                    // Content
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              slide['title']!,
                              style: AyaTypography.getTextTheme(context)
                                  .displaySmall
                                  ?.copyWith(
                                color: AyaColors.textPrimary,
                                shadows: [
                                  Shadow(
                                    color: AyaColors.black60,
                                    offset: const Offset(0, 2),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Flexible(
                            child: Text(
                              slide['desc']!,
                              style: AyaTypography.getTextTheme(context)
                                  .bodyLarge
                                  ?.copyWith(
                                color: AyaColors.white85,
                                shadows: [
                                  Shadow(
                                    color: AyaColors.black60,
                                    offset: const Offset(0, 1),
                                    blurRadius: 2,
                                  ),
                                ],
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 24),
                          // Modern Glassy Button
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  AyaColors.lavenderVibrant.withOpacity(0.8),
                                  AyaColors.lavenderSoft.withOpacity(0.9),
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AyaColors.lavenderVibrant
                                      .withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {},
                                borderRadius: BorderRadius.circular(16),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 12,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        slide['cta']!,
                                        style:
                                            AyaTypography.getTextTheme(context)
                                                .labelLarge
                                                ?.copyWith(
                                                  color: AyaColors.textPrimary,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                      ),
                                      const SizedBox(width: 8),
                                      Icon(
                                        Icons.arrow_forward,
                                        color: AyaColors.textPrimary,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
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
        const SizedBox(height: 16),
        // Modern Page Indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_heroSlides.length, (i) {
            final selected = i == _heroPage;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: selected ? 24 : 8,
              height: 8,
              decoration: BoxDecoration(
                gradient: selected
                    ? LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AyaColors.lavenderVibrant,
                          AyaColors.turquoise,
                        ],
                      )
                    : null,
                color: selected ? null : AyaColors.textPrimary40,
                borderRadius: BorderRadius.circular(8),
                boxShadow: selected
                    ? [
                        BoxShadow(
                          color: AyaColors.lavenderVibrant.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
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
          style: AyaTypography.getTextTheme(context).headlineMedium?.copyWith(
                color: AyaColors.textPrimary,
              ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 180,
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
                      color: AyaColors.overlayDark,
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: CachedNetworkImage(
                        imageUrl: lesson['img']!,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            color: Colors.white,
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.grey[300],
                          child: const Icon(Icons.error),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.4),
                            Colors.black.withValues(alpha: 0.8),
                          ],
                          stops: const [0.4, 1.0],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: _buildPlanTag(lesson['plan']!),
                          ),
                          const Spacer(),
                          Text(
                            lesson['title']!,
                            style: AyaTypography.getTextTheme(context)
                                .titleSmall
                                ?.copyWith(
                                  color: AyaColors.textPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            lesson['subtitle']!,
                            style: AyaTypography.getTextTheme(context)
                                .bodySmall
                                ?.copyWith(
                                  color: AyaColors.textPrimary80,
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
          style: AyaTypography.getTextTheme(context).headlineMedium?.copyWith(
                color: AyaColors.textPrimary,
              ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 180,
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
                      color: AyaColors.overlayDark,
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: CachedNetworkImage(
                        imageUrl: lesson['img']!,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            color: Colors.white,
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.grey[300],
                          child: const Icon(Icons.error),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.4),
                            Colors.black.withValues(alpha: 0.8),
                          ],
                          stops: const [0.4, 1.0],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: _buildPlanTag(lesson['plan']!),
                          ),
                          const Spacer(),
                          Text(
                            lesson['title']!,
                            style: AyaTypography.getTextTheme(context)
                                .titleSmall
                                ?.copyWith(
                                  color: AyaColors.textPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            lesson['subtitle']!,
                            style: AyaTypography.getTextTheme(context)
                                .bodySmall
                                ?.copyWith(
                                  color: AyaColors.textPrimary80,
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
          color: AyaColors.lavenderVibrant30,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AyaColors.lavenderVibrant.withOpacity(0.3),
            width: 1,
          ),
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
              style: AyaTypography.getTextTheme(context).labelSmall?.copyWith(
                    color: AyaColors.textPrimary,
                  ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: AyaColors.turquoise30,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AyaColors.turquoise.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Text(
          'Gratuito',
          style: AyaTypography.getTextTheme(context).labelSmall?.copyWith(
                color: AyaColors.textPrimary,
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
    // TODO: Implementar lista de downloads reais
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
    // TODO: Implementar tela de configurações completa
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
