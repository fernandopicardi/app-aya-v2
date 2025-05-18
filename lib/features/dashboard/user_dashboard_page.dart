import 'package:flutter/material.dart';
import 'package:app_aya_v2/config/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class UserDashboardPage extends StatefulWidget {
  const UserDashboardPage({super.key});

  @override
  State<UserDashboardPage> createState() => _UserDashboardPageState();
}

class _UserDashboardPageState extends State<UserDashboardPage> {
  // Simulação de nome do usuário
  final String userName = 'Aya';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.backgroundGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                _buildWelcomeSection(),
                _buildRecommendedSection(context),
                _buildCategoriesSection(context),
                _buildFavoritesSection(context),
                _buildCommunitySection(context),
                _buildIASection(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleCardTap(BuildContext context, CardType type) {
    final router = GoRouter.of(context);
    switch (type) {
      case CardType.recommended:
        router.push('/content/modules');
        break;
      case CardType.category:
        router.push('/content/modules');
        break;
      case CardType.favorite:
        router.push('/content/modules');
        break;
      case CardType.community:
        router.push('/community');
        break;
      case CardType.ia:
        router.push('/chatbot');
        break;
    }
  }

  Widget _buildHeader(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Row(
          children: [
            Icon(Icons.spa, color: AppTheme.primary, size: 28),
            const SizedBox(width: 8),
            Text(
              'App Aya',
              style: TextStyle(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none, color: AppTheme.primary),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildWelcomeSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bem-vindo(a)!',
            style: TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Continue sua jornada de autoconhecimento',
            style: TextStyle(
              color: AppTheme.textPrimary.withAlpha(204),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendedSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Recomendado para você',
            style: TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: 3,
            itemBuilder: (context, index) {
              return _buildCard(context, CardType.recommended);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCategoriesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Explore por Categorias',
            style: TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: 3,
            itemBuilder: (context, index) {
              return _buildCard(context, CardType.category);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFavoritesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Seus Favoritos',
            style: TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: 3,
            itemBuilder: (context, index) {
              return _buildCard(context, CardType.favorite);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCommunitySection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Comunidade em Destaque',
            style: TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: 2,
            itemBuilder: (context, index) {
              return _buildCard(context, CardType.community);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildIASection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Seu Agente IA Aya',
            style: TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: 1,
            itemBuilder: (context, index) {
              return _buildCard(context, CardType.ia);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCard(BuildContext context, CardType type) {
    return GestureDetector(
      onTap: () => _handleCardTap(context, type),
      child: Container(
        width: 300,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: AppTheme.secondary,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.primary.withAlpha(26),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Center(
                  child: Icon(
                    _getIconForType(type),
                    color: AppTheme.primary,
                    size: 48,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getTitleForType(type),
                    style: const TextStyle(
                      color: AppTheme.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _getDescriptionForType(type),
                    style: TextStyle(
                      color: AppTheme.textPrimary.withAlpha(204),
                      fontSize: 14,
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

  IconData _getIconForType(CardType type) {
    switch (type) {
      case CardType.recommended:
        return Icons.star;
      case CardType.category:
        return Icons.category;
      case CardType.favorite:
        return Icons.favorite;
      case CardType.community:
        return Icons.people;
      case CardType.ia:
        return Icons.psychology;
    }
  }

  String _getTitleForType(CardType type) {
    switch (type) {
      case CardType.recommended:
        return 'Recomendado para você';
      case CardType.category:
        return 'Categorias';
      case CardType.favorite:
        return 'Favoritos';
      case CardType.community:
        return 'Comunidade';
      case CardType.ia:
        return 'Agente IA Aya';
    }
  }

  String _getDescriptionForType(CardType type) {
    switch (type) {
      case CardType.recommended:
        return 'Conteúdo personalizado baseado no seu perfil';
      case CardType.category:
        return 'Explore por temas e categorias';
      case CardType.favorite:
        return 'Acesse seus conteúdos favoritos';
      case CardType.community:
        return 'Conecte-se com outros usuários';
      case CardType.ia:
        return 'Converse com seu assistente pessoal';
    }
  }
}

class _WebSidebar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;
  const _WebSidebar({required this.selectedIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final items = [
      {'icon': Icons.home, 'label': 'Dashboard'},
      {'icon': Icons.library_books, 'label': 'Biblioteca'},
      {'icon': Icons.forum, 'label': 'Comunidade'},
      {'icon': Icons.smart_toy, 'label': 'Chat IA'},
      {'icon': Icons.person, 'label': 'Perfil'},
    ];
    return Container(
      width: 220,
      color: AppTheme.secondary.withAlpha(242),
      child: Column(
        children: [
          const SizedBox(height: 32),
          ...List.generate(items.length, (i) {
            final item = items[i];
            return ListTile(
              leading: Icon(item['icon'] as IconData, color: i == selectedIndex ? AppTheme.primary : AppTheme.textPrimary.withAlpha(179)),
              title: Text(
                item['label'] as String,
                style: TextStyle(
                  color: i == selectedIndex ? AppTheme.primary : AppTheme.textPrimary.withAlpha(204),
                  fontWeight: i == selectedIndex ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              selected: i == selectedIndex,
              onTap: () => onTap(i),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              selectedTileColor: AppTheme.primary.withAlpha(20),
              hoverColor: AppTheme.primary.withAlpha(31),
            );
          }),
          const Spacer(),
        ],
      ),
    );
  }
}

class _AyaBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;
  const _AyaBottomNavBar({required this.selectedIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final items = [
      {'icon': Icons.home, 'label': 'Dashboard'},
      {'icon': Icons.library_books, 'label': 'Biblioteca'},
      {'icon': Icons.forum, 'label': 'Comunidade'},
      {'icon': Icons.smart_toy, 'label': 'Chat IA'},
      {'icon': Icons.person, 'label': 'Perfil'},
    ];
    return BottomNavigationBar(
      backgroundColor: const Color(0xFF474C72),
      selectedItemColor: const Color(0xFFACA1EF),
      unselectedItemColor: const Color(0xFFF8F8FF),
      currentIndex: selectedIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
      items: [
        for (final item in items)
          BottomNavigationBarItem(
            icon: Icon(item['icon'] as IconData),
            label: item['label'] as String,
          ),
      ],
    );
  }
}

class _HeroCarousel extends StatefulWidget {
  const _HeroCarousel();
  @override
  State<_HeroCarousel> createState() => _HeroCarouselState();
}

class _HeroCarouselState extends State<_HeroCarousel> {
  int _current = 0;
  final PageController _controller = PageController();
  bool _loading = true;

  final List<_HeroSlideData> slides = [
    _HeroSlideData(
      image: 'assets/images/hero_module.jpg',
      title: 'Novo Módulo: Jornada da Gratidão',
      description: 'Descubra práticas diárias para cultivar gratidão e bem-estar. Comece agora sua transformação!',
      cta: 'Quero saber mais',
      onTap: () {},
    ),
    _HeroSlideData(
      image: 'assets/images/hero_event.jpg',
      title: 'Evento Especial: Meditação ao Vivo',
      description: 'Participe do nosso evento exclusivo e medite com a comunidade Aya.',
      cta: 'Inscreva-se',
      onTap: () {},
    ),
    _HeroSlideData(
      image: 'assets/images/hero_challenge.jpg',
      title: 'Desafio da Comunidade',
      description: 'Junte-se ao desafio semanal e compartilhe seu progresso com outras mulheres.',
      cta: 'Participar do Desafio',
      onTap: () {},
    ),
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _loading = false);
    });
  }

  void _goTo(int index) {
    _controller.animateToPage(index, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    if (_loading) {
      return Column(
        children: [
          SizedBox(
            height: isMobile ? 320 : 380,
            child: Shimmer.fromColors(
              baseColor: AppTheme.secondary.withAlpha(77),
              highlightColor: AppTheme.primary.withAlpha(38),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: isMobile ? 12 : 64, vertical: isMobile ? 16 : 32),
                decoration: BoxDecoration(
                  color: AppTheme.secondary,
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 8),
            child: Shimmer.fromColors(
              baseColor: AppTheme.secondary.withAlpha(77),
              highlightColor: AppTheme.primary.withAlpha(38),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (i) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  width: 22,
                  height: 10,
                  decoration: BoxDecoration(
                    color: AppTheme.secondary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                )),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Shimmer.fromColors(
              baseColor: AppTheme.secondary.withAlpha(77),
              highlightColor: AppTheme.primary.withAlpha(38),
              child: Container(
                width: 220,
                height: 48,
                decoration: BoxDecoration(
                  color: AppTheme.secondary,
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
        ],
      );
    }
    return Column(
      children: [
        SizedBox(
          height: isMobile ? 320 : 380,
          child: Stack(
            children: [
              PageView.builder(
                controller: _controller,
                itemCount: slides.length,
                onPageChanged: (i) => setState(() => _current = i),
                itemBuilder: (context, i) {
                  final slide = slides[i];
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: isMobile ? 12 : 64, vertical: isMobile ? 16 : 32),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        image: DecorationImage(
                          image: AssetImage(slide.image),
                          fit: BoxFit.cover,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.primary.withAlpha(33),
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(28),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              const Color(0xFFACA1EF),
                              const Color(0xFF73BDDA).withAlpha(220),
                            ],
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 48, vertical: isMobile ? 28 : 48),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                            children: [
                              Text(
                                slide.title,
                                style: TextStyle(
                                  color: const Color(0xFFF8F8FF),
                                  fontWeight: FontWeight.bold,
                                  fontSize: isMobile ? 22 : 30,
                                  letterSpacing: 1.1,
                                ),
                                textAlign: isMobile ? TextAlign.center : TextAlign.left,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                slide.description,
                                style: TextStyle(
                                  color: const Color(0xFFF8F8FF),
                                  fontSize: isMobile ? 15 : 18,
                                ),
                                textAlign: isMobile ? TextAlign.center : TextAlign.left,
                              ),
                              const SizedBox(height: 28),
                              ElevatedButton(
                                onPressed: slide.onTap,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFACA1EF),
                                  foregroundColor: const Color(0xFFF8F8FF),
                                  elevation: 0,
                                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: Text(
                                  slide.cta,
                                  style: const TextStyle(
                                    color: Color(0xFFF8F8FF),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
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
              // Setas laterais
              if (!isMobile) ...[
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: Colors.white.withAlpha(200)),
                    onPressed: () => _goTo((_current - 1 + slides.length) % slides.length),
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: IconButton(
                    icon: Icon(Icons.arrow_forward_ios, color: Colors.white.withAlpha(200)),
                    onPressed: () => _goTo((_current + 1) % slides.length),
                  ),
                ),
              ],
            ],
          ),
        ),
        // Indicadores de slide
        Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              slides.length,
              (i) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 6),
                width: _current == i ? 22 : 10,
                height: 10,
                decoration: BoxDecoration(
                  color: _current == i ? const Color(0xFFACA1EF) : const Color(0xFFF8F8FF).withAlpha(120),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ),
        // Botão de acesso rápido
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: SizedBox(
            width: 220,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.playlist_play, color: Color(0xFFF8F8FF)),
              label: const Text('Minhas Playlists IA'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF474C72),
                foregroundColor: Color(0xFFF8F8FF),
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _HeroSlideData {
  final String image;
  final String title;
  final String description;
  final String cta;
  final VoidCallback onTap;
  const _HeroSlideData({required this.image, required this.title, required this.description, required this.cta, required this.onTap});
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: Text(
        title,
        style: TextStyle(
          color: AppTheme.textPrimary,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }
}

enum CardType { recommended, category, favorite, community, ia }

class _HorizontalCardList extends StatelessWidget {
  final int itemCount;
  final CardType cardType;
  const _HorizontalCardList({required this.itemCount, required this.cardType});

  @override
  Widget build(BuildContext context) {
    // Simula carregamento
    final isLoading = false; // Troque para true para ver o shimmer
    if (isLoading) {
      return SizedBox(
        height: 200,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: itemCount,
          separatorBuilder: (_, __) => const SizedBox(width: 16),
          itemBuilder: (context, i) => Shimmer.fromColors(
            baseColor: AppTheme.secondary.withAlpha(77),
            highlightColor: AppTheme.primary.withAlpha(38),
            child: Container(
              width: 140,
              height: 200,
              decoration: BoxDecoration(
                color: AppTheme.secondary,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ),
      );
    }
    return SizedBox(
      height: 200,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) => _DashboardCard(cardType: cardType, index: index),
      ),
    );
  }
}

class _DashboardCard extends StatelessWidget {
  final CardType cardType;
  final int index;
  const _DashboardCard({required this.cardType, required this.index});

  void _handleCardTap(BuildContext context) {
    final router = GoRouter.of(context);
    switch (cardType) {
      case CardType.recommended:
      case CardType.category:
      case CardType.favorite:
        router.push('/content/modules');
        break;
      case CardType.community:
        router.push('/community');
        break;
      case CardType.ia:
        router.push('/chatbot');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Exemplos de imagens (substitua pelos assets reais depois)
    final images = [
      'assets/images/card1.jpg',
      'assets/images/card2.jpg',
      'assets/images/card3.jpg',
      'assets/images/card4.jpg',
    ];
    final image = images[index % images.length];
    final titles = {
      CardType.recommended: 'Aula Recomendada',
      CardType.category: 'Categoria',
      CardType.favorite: 'Favorito',
      CardType.community: 'Tópico da Comunidade',
      CardType.ia: 'Converse com Aya',
    };
    final subtitles = {
      CardType.recommended: 'Descubra algo novo',
      CardType.category: 'Explore conteúdos',
      CardType.favorite: 'Acesse rapidamente',
      CardType.community: 'Participe da discussão',
      CardType.ia: 'Sua assistente pessoal',
    };
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => _handleCardTap(context),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeInOut,
        width: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primary.withAlpha(33),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      AppTheme.secondary.withAlpha(217),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titles[cardType]!,
                    style: TextStyle(
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitles[cardType]!,
                    style: TextStyle(
                      color: AppTheme.textPrimary.withAlpha(230),
                      fontSize: 12,
                    ),
                  ),
                  if (cardType == CardType.recommended && index == 0)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Row(
                        children: [
                          Icon(Icons.lock, color: AppTheme.primary, size: 16),
                          const SizedBox(width: 4),
                          Text('Premium', style: TextStyle(color: AppTheme.primary, fontSize: 12)),
                        ],
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

class _ContinueJourneyList extends StatelessWidget {
  final bool loading;
  const _ContinueJourneyList({this.loading = false});
  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    final items = [
      {
        'image': 'assets/images/content_1.jpg',
        'title': 'Meditação para Aliviar a Ansiedade',
        'type': 'Vídeo',
        'duration': '15 min',
        'progress': 0.7,
      },
      {
        'image': 'assets/images/content_2.jpg',
        'title': 'Jornada da Gratidão - Dia 2',
        'type': 'Áudio',
        'duration': '12 min',
        'progress': 0.3,
      },
      {
        'image': 'assets/images/content_3.jpg',
        'title': 'Respiração Consciente',
        'type': 'Vídeo',
        'duration': '8 min',
        'progress': 0.5,
      },
    ];
    if (loading) {
      return SizedBox(
        height: isMobile ? 210 : 230,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: 3,
          separatorBuilder: (_, __) => const SizedBox(width: 18),
          itemBuilder: (context, i) => Shimmer.fromColors(
            baseColor: AppTheme.secondary.withAlpha(77),
            highlightColor: AppTheme.primary.withAlpha(38),
            child: Container(
              width: isMobile ? 220 : 260,
              decoration: BoxDecoration(
                color: AppTheme.secondary,
                borderRadius: BorderRadius.circular(18),
              ),
            ),
          ),
        ),
      );
    }
    return SizedBox(
      height: isMobile ? 210 : 230,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 18),
        itemBuilder: (context, i) {
          final item = items[i];
          return InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: () {},
            child: Container(
              width: isMobile ? 220 : 260,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF8DB1D1),
                    const Color(0xFF78C7B4),
                  ],
                ),
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primary.withAlpha(33),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Stack(
                  children: [
                    // Thumbnail
                    Positioned.fill(
                      child: Image.asset(
                        item['image'] as String,
                        fit: BoxFit.cover,
                        color: Colors.black.withAlpha(40),
                        colorBlendMode: BlendMode.darken,
                      ),
                    ),
                    // Conteúdo
                    Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            item['title'] as String,
                            style: const TextStyle(
                              color: Color(0xFFF8F8FF),
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(
                                item['type'] == 'Áudio' ? Icons.headphones : Icons.play_circle_outline,
                                color: const Color(0xFFF8F8FF),
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${item['type']} • ${item['duration']}',
                                style: const TextStyle(
                                  color: Color(0xFFF8F8FF),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          // Barra de progresso
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: item['progress'] as double,
                              backgroundColor: Colors.white.withAlpha(40),
                              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFACA1EF)),
                              minHeight: 4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _FeaturedModulesList extends StatefulWidget {
  @override
  State<_FeaturedModulesList> createState() => _FeaturedModulesListState();
}

class _FeaturedModulesListState extends State<_FeaturedModulesList> {
  bool loading = true;

  final modules = [
    {
      'image': 'assets/images/module_awakening.jpg',
      'title': 'Módulo: Despertar da Consciência',
      'desc': 'Inicie sua jornada de autoconhecimento com práticas e reflexões profundas.',
    },
    {
      'image': 'assets/images/module_gratitude.jpg',
      'title': 'Módulo: Jornada da Gratidão',
      'desc': 'Aprenda a cultivar gratidão diariamente e transformar sua perspectiva.',
    },
    {
      'image': 'assets/images/module_mindfulness.jpg',
      'title': 'Módulo: Mindfulness Essencial',
      'desc': 'Desenvolva presença e atenção plena para o dia a dia.',
    },
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => loading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    if (loading) {
      return SizedBox(
        height: isMobile ? 160 : 180,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: 3,
          separatorBuilder: (_, __) => const SizedBox(width: 18),
          itemBuilder: (context, i) => Shimmer.fromColors(
            baseColor: AppTheme.secondary.withAlpha(77),
            highlightColor: AppTheme.primary.withAlpha(38),
            child: Container(
              width: isMobile ? 320 : 380,
              decoration: BoxDecoration(
                color: AppTheme.secondary,
                borderRadius: BorderRadius.circular(18),
              ),
            ),
          ),
        ),
      );
    }
    return SizedBox(
      height: isMobile ? 160 : 180,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: modules.length,
        separatorBuilder: (_, __) => const SizedBox(width: 18),
        itemBuilder: (context, i) {
          final m = modules[i];
          return InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: () {},
            child: Container(
              width: isMobile ? 320 : 380,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFFACA1EF),
                    const Color(0xFF73BDDA),
                  ],
                ),
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primary.withAlpha(33),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.horizontal(left: Radius.circular(18)),
                    child: Image.asset(
                      m['image'] as String,
                      width: isMobile ? 90 : 120,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            m['title'] as String,
                            style: const TextStyle(
                              color: Color(0xFFF8F8FF),
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            m['desc'] as String,
                            style: const TextStyle(
                              color: Color(0xFFF8F8FF),
                              fontSize: 13,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 14),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF474C72),
                                foregroundColor: const Color(0xFFF8F8FF),
                                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                                textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 1,
                              ),
                              child: const Text('Saiba mais'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _VideoPlayerModal extends StatelessWidget {
  final String title;
  const _VideoPlayerModal({required this.title});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter.of(context);
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.secondary.withAlpha(250),
          borderRadius: BorderRadius.circular(18),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: AppTheme.textPrimary),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 12),
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.background,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Icon(Icons.play_circle_fill, color: AppTheme.primary, size: 64),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Gostou? Descubra mais com nossos planos!',
              style: TextStyle(
                color: AppTheme.textPrimary.withAlpha(230),
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                router.push('/plans');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                foregroundColor: AppTheme.textPrimary,
                padding: const EdgeInsets.symmetric(vertical: 14),
                textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Ver Planos'),
            ),
          ],
        ),
      ),
    );
  }
} 