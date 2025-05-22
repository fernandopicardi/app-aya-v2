import 'package:flutter/material.dart';
import '../../../features/auth/services/auth_service.dart';
import '../../../core/theme/app_theme.dart';
import '../widgets/aya_app_bar.dart';
import '../widgets/aya_bottom_nav.dart';
import '../widgets/aya_drawer.dart';
import '../widgets/aya_cards.dart';

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
    return ListView(
      children: [
        // Featured Card
        AyaFeaturedCard(
          title: 'Planos de Assinatura',
          description: 'Desbloqueie todo o conteúdo e recursos premium',
          imageUrl: 'https://picsum.photos/800/400',
          buttonText: 'Gerenciar minha assinatura',
          onTap: () {
            Navigator.pushNamed(context, '/subscription');
          },
        ),

        // Comece por Aqui Section
        AyaSectionHeader(
          title: 'Comece por aqui',
          subtitle: 'Aprenda a mergulhar no app',
          onSeeAllPressed: () {
            // TODO: Navigate to all getting started content
          },
        ),
        SizedBox(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              AyaContentCard(
                title: 'Como usar o app',
                subtitle: 'Guia rápido',
                imageUrl: 'https://picsum.photos/200/300',
                onTap: () {
                  // TODO: Navigate to guide
                },
              ),
              AyaContentCard(
                title: 'Primeiros passos',
                subtitle: 'Introdução',
                imageUrl: 'https://picsum.photos/200/301',
                onTap: () {
                  // TODO: Navigate to intro
                },
              ),
              AyaContentCard(
                title: 'Dicas e truques',
                subtitle: 'Aproveite ao máximo',
                imageUrl: 'https://picsum.photos/200/302',
                onTap: () {
                  // TODO: Navigate to tips
                },
              ),
            ],
          ),
        ),

        // Astrologia na Prática Section
        AyaSectionHeader(
          title: 'Astrologia na Prática',
          subtitle: 'Aprenda a interpretar seu mapa astral',
          onSeeAllPressed: () {
            // TODO: Navigate to all astrology content
          },
        ),
        SizedBox(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              AyaContentCard(
                title: 'Introdução à Astrologia',
                subtitle: 'Módulo 1 • Aula 1',
                imageUrl: 'https://picsum.photos/200/303',
                onTap: () {
                  // TODO: Navigate to lesson
                },
              ),
              AyaContentCard(
                title: 'Os 12 Signos',
                subtitle: 'Módulo 1 • Aula 2',
                imageUrl: 'https://picsum.photos/200/304',
                onTap: () {
                  // TODO: Navigate to lesson
                },
              ),
              AyaContentCard(
                title: 'Casas Astrológicas',
                subtitle: 'Módulo 1 • Aula 3',
                imageUrl: 'https://picsum.photos/200/305',
                onTap: () {
                  // TODO: Navigate to lesson
                },
              ),
            ],
          ),
        ),

        // Jornadas de Mindfulness Section
        AyaSectionHeader(
          title: 'Jornadas de Mindfulness',
          subtitle: 'Meditações guiadas e práticas',
          onSeeAllPressed: () {
            // TODO: Navigate to all mindfulness content
          },
        ),
        SizedBox(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              AyaContentCard(
                title: 'Meditação para Iniciantes',
                subtitle: 'Jornada 1 • Aula 1',
                imageUrl: 'https://picsum.photos/200/306',
                onTap: () {
                  // TODO: Navigate to lesson
                },
              ),
              AyaContentCard(
                title: 'Respiração Consciente',
                subtitle: 'Jornada 1 • Aula 2',
                imageUrl: 'https://picsum.photos/200/307',
                onTap: () {
                  // TODO: Navigate to lesson
                },
              ),
              AyaContentCard(
                title: 'Mindfulness no Dia a Dia',
                subtitle: 'Jornada 1 • Aula 3',
                imageUrl: 'https://picsum.photos/200/308',
                onTap: () {
                  // TODO: Navigate to lesson
                },
              ),
            ],
          ),
        ),

        // Seu Progresso Section
        AyaSectionHeader(
          title: 'Seu Progresso',
          subtitle: 'Acompanhe sua jornada',
        ),
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AyaColors.lavenderSoft,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Nível 3',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AyaColors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AyaColors.turquoise,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '750 pontos',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: AyaColors.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: 0.7,
                  backgroundColor: AyaColors.lavenderSoft30,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AyaColors.turquoise,
                  ),
                  minHeight: 8,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '70% do nível atual',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AyaColors.textPrimary60,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLibraryTab() {
    return const Center(child: Text('Biblioteca'));
  }

  Widget _buildCommunityTab() {
    return const Center(child: Text('Comunidade'));
  }

  Widget _buildChatTab() {
    return const Center(child: Text('Chat IA'));
  }

  Widget _buildProfileTab() {
    return const Center(child: Text('Perfil'));
  }
}
