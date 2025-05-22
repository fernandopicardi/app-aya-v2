import 'package:flutter/material.dart';
import 'package:app_aya_v2/core/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:app_aya_v2/config/routes.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AyaColors.background,
      body: CustomScrollView(
        slivers: [
          // Enhanced AppBar with user progress
          SliverAppBar(
            expandedHeight: 120,
            floating: true,
            pinned: true,
            backgroundColor: AyaColors.textPrimary80,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AyaColors.surface,
                      AyaColors.surface.withAlpha(242),
                    ],
                  ),
                ),
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Olá, Maria!',
                      style: TextStyle(
                        color: AyaColors.textPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(Icons.waving_hand,
                        color: AyaColors.turquoise, size: 20),
                  ],
                ),
                GestureDetector(
                  onTap: () => context.push(AppRouter.profile),
                  child: Row(
                    children: [
                      Text(
                        'Caminhante',
                        style: TextStyle(
                          color: AyaColors.textPrimary.withAlpha(230),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '| 250/500 pts',
                        style: TextStyle(
                          color: AyaColors.turquoise,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(Icons.auto_awesome,
                          color: AyaColors.turquoise, size: 14),
                    ],
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.notifications_outlined,
                    color: AyaColors.textPrimary),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.person_outline, color: AyaColors.textPrimary),
                onPressed: () => context.push(AppRouter.profile),
              ),
              const SizedBox(width: 8),
            ],
          ),
          // Main Content
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Continue from where you left off section
                _SectionHeader(
                  title: 'Continue de Onde Parou',
                  icon: Icons.play_circle_outline,
                ),
                _ContinueProgressCard(),
                const SizedBox(height: 32),

                // Recommended for you section
                _SectionHeader(
                  title: 'Recomendado para Você',
                  icon: Icons.auto_awesome,
                ),
                _RecommendedContentList(),
                const SizedBox(height: 32),

                // Categories section
                _SectionHeader(
                  title: 'Explore por Categorias',
                  icon: Icons.category_outlined,
                ),
                _CategoriesGrid(),
                const SizedBox(height: 32),

                // Favorites section
                _SectionHeader(
                  title: 'Seus Favoritos',
                  icon: Icons.favorite_outline,
                ),
                _FavoritesList(),
                const SizedBox(height: 32),

                // Active Challenges section
                _SectionHeader(
                  title: 'Desafios Ativos',
                  icon: Icons.emoji_events_outlined,
                ),
                _ActiveChallengesList(),
                const SizedBox(height: 32),

                // Community section
                _SectionHeader(
                  title: 'Sua Comunidade',
                  icon: Icons.people_outline,
                ),
                _CommunityUpdatesList(),
                const SizedBox(height: 32),

                // AI Chat section
                _AIChatCard(),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;

  const _SectionHeader({
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
      child: Row(
        children: [
          Icon(icon, color: AyaColors.turquoise, size: 24),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              color: AyaColors.textPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class _ContinueProgressCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF2A2939),
            const Color(0xFF474C72),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AyaColors.turquoise.withAlpha(25),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Thumbnail
            Positioned.fill(
              child: Image.asset(
                'assets/images/meditation_thumbnail.jpg',
                fit: BoxFit.cover,
                opacity: const AlwaysStoppedAnimation(0.7),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Meditação para Aliviar a Ansiedade',
                    style: TextStyle(
                      color: AyaColors.textPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: 0.7,
                      backgroundColor: AyaColors.textPrimary.withAlpha(51),
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AyaColors.turquoise),
                      minHeight: 4,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '70% Concluído',
                    style: TextStyle(
                      color: AyaColors.textPrimary.withAlpha(230),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.play_arrow_rounded),
                    label: const Text('Continuar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AyaColors.turquoise,
                      foregroundColor: AyaColors.textPrimary,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RecommendedContentList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) => _ContentCard(
          title: 'Jornada da Gratidão - Dia ${index + 1}',
          type: index % 2 == 0 ? 'Áudio' : 'Vídeo',
          duration: '${15 + index * 5} min',
          isPremium: index % 3 == 0,
          image: 'assets/images/content_${index + 1}.jpg',
        ),
      ),
    );
  }
}

class _ContentCard extends StatelessWidget {
  final String title;
  final String type;
  final String duration;
  final bool isPremium;
  final String image;

  const _ContentCard({
    required this.title,
    required this.type,
    required this.duration,
    required this.isPremium,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF8DB1D1),
            const Color(0xFF78C7B4),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AyaColors.turquoise.withAlpha(25),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Thumbnail
            Positioned.fill(
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
            // Content
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      AyaColors.surface.withAlpha(242),
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: AyaColors.textPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          type == 'Áudio'
                              ? Icons.headphones
                              : Icons.play_circle_outline,
                          color: AyaColors.textPrimary.withAlpha(230),
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '$type • $duration',
                          style: TextStyle(
                            color: AyaColors.textPrimary.withAlpha(230),
                            fontSize: 12,
                          ),
                        ),
                        if (isPremium) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: AyaColors.turquoise,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.lock,
                                    color: AyaColors.textPrimary, size: 12),
                                const SizedBox(width: 2),
                                Text(
                                  'Premium',
                                  style: TextStyle(
                                    color: AyaColors.textPrimary,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoriesGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = [
      {
        'name': 'Meditação Guiada',
        'icon': Icons.self_improvement,
        'count': '24 aulas'
      },
      {
        'name': 'Autoconhecimento',
        'icon': Icons.psychology_alt,
        'count': '18 aulas'
      },
      {'name': 'Mindfulness', 'icon': Icons.spa, 'count': '15 aulas'},
      {'name': 'Bem-estar', 'icon': Icons.favorite, 'count': '12 aulas'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Container(
            decoration: BoxDecoration(
              color: AyaColors.surface.withAlpha(179),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AyaColors.turquoise.withAlpha(25),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        category['icon'] as IconData,
                        color: AyaColors.turquoise,
                        size: 32,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        category['name'] as String,
                        style: const TextStyle(
                          color: AyaColors.textPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        category['count'] as String,
                        style: TextStyle(
                          color: AyaColors.textPrimary.withAlpha(230),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _FavoritesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Placeholder for empty state
    return Container(
      height: 200,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AyaColors.surface.withAlpha(179),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border,
              color: AyaColors.turquoise,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              'Suas aulas favoritas aparecerão aqui',
              style: TextStyle(
                color: AyaColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Explore e salve o que mais te inspirar! ✨',
              style: TextStyle(
                color: AyaColors.textPrimary.withAlpha(230),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActiveChallengesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) => Container(
          width: 280,
          decoration: BoxDecoration(
            color: AyaColors.surface.withAlpha(179),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AyaColors.turquoise.withAlpha(25),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.emoji_events,
                        color: AyaColors.turquoise, size: 24),
                    const SizedBox(width: 8),
                    Text(
                      'Desafio da Semana',
                      style: TextStyle(
                        color: AyaColors.textPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  '7 dias de meditação guiada',
                  style: TextStyle(
                    color: AyaColors.textPrimary.withAlpha(230),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: 0.4,
                    backgroundColor: AyaColors.textPrimary.withAlpha(51),
                    valueColor:
                        AlwaysStoppedAnimation<Color>(AyaColors.turquoise),
                    minHeight: 4,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '3 de 7 dias completos',
                  style: TextStyle(
                    color: AyaColors.textPrimary.withAlpha(230),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CommunityUpdatesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _CommunityUpdateCard(
            title: 'Última atividade no fórum',
            subtitle: 'Meditação em Grupo',
            icon: Icons.forum_outlined,
          ),
          const SizedBox(height: 12),
          _CommunityUpdateCard(
            title: 'Novo post popular',
            subtitle: 'Como manter a constância na prática',
            icon: Icons.trending_up,
          ),
          const SizedBox(height: 12),
          _CommunityUpdateCard(
            title: 'Top do Leaderboard',
            subtitle: 'Veja quem está em destaque esta semana',
            icon: Icons.emoji_events,
          ),
        ],
      ),
    );
  }
}

class _CommunityUpdateCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const _CommunityUpdateCard({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AyaColors.surface.withAlpha(179),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(icon, color: AyaColors.turquoise, size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: AyaColors.textPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: AyaColors.textPrimary.withAlpha(230),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: AyaColors.textPrimary.withAlpha(230),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AIChatCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AyaColors.turquoise.withAlpha(25),
            AyaColors.lavenderVibrant.withAlpha(25),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => context.push(AppRouter.chatbot),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AyaColors.turquoise.withAlpha(25),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.chat_bubble_outline,
                    color: AyaColors.turquoise,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Fale com Aya',
                        style: TextStyle(
                          color: AyaColors.textPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Precisa de uma sugestão ou tem alguma dúvida? Converse com Aya!',
                        style: TextStyle(
                          color: AyaColors.textPrimary.withAlpha(230),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: AyaColors.turquoise,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
