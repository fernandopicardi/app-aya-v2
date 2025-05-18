import 'package:flutter/material.dart';
import 'package:app_aya_v2/config/theme.dart';
import 'package:go_router/go_router.dart';
import 'package:app_aya_v2/config/routes.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    return Scaffold(
      backgroundColor: AppTheme.background,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.secondary.withAlpha(247),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(10),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.spa, color: AppTheme.primary, size: 32),
                      const SizedBox(width: 8),
                      Text(
                        'App Aya',
                        style: TextStyle(
                          color: AppTheme.textPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                  if (!isMobile)
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: const Text('O que é o Aya?'),
                          style: TextButton.styleFrom(
                            foregroundColor: AppTheme.textPrimary.withAlpha(217),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text('Recursos'),
                          style: TextButton.styleFrom(
                            foregroundColor: AppTheme.textPrimary.withAlpha(217),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text('Comunidade'),
                          style: TextButton.styleFrom(
                            foregroundColor: AppTheme.textPrimary.withAlpha(217),
                          ),
                        ),
                        const SizedBox(width: 16),
                        OutlinedButton(
                          onPressed: () => context.go(AppRouter.login),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: AppTheme.buttonSecondary, width: 2),
                            foregroundColor: AppTheme.buttonSecondary,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Login'),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: () => context.go(AppRouter.simpleRegister),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primary,
                            foregroundColor: AppTheme.textPrimary,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Registrar'),
                        ),
                      ],
                    ),
                  if (isMobile)
                    IconButton(
                      icon: const Icon(Icons.menu, color: AppTheme.textPrimary),
                      onPressed: () {
                        // TODO: abrir drawer
                      },
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          // Hero Section com gradiente e ilustração
          Container(
            width: double.infinity,
            height: isMobile ? 480 : 540,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF2A2939),
                  Color(0xFF474C72),
                  Color(0xFF73BDDA),
                ],
              ),
            ),
            child: Stack(
              children: [
                // Ilustração/banner (substitua pelo asset real depois)
                Positioned(
                  right: isMobile ? -40 : 40,
                  bottom: 0,
                  child: Opacity(
                    opacity: 0.18,
                    child: Image.asset(
                      'assets/images/hero_aya_illustration.png',
                      height: isMobile ? 260 : 400,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                // Conteúdo hero
                Align(
                  alignment: isMobile ? Alignment.center : Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 24 : 64,
                      vertical: isMobile ? 48 : 0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 80),
                        Text(
                          'Encontre Seu Equilíbrio Interior com Aya.',
                          style: TextStyle(
                            color: AppTheme.textPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: isMobile ? 28 : 38,
                            letterSpacing: 1.1,
                            height: 1.2,
                          ),
                          textAlign: isMobile ? TextAlign.center : TextAlign.left,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Descubra meditações guiadas, práticas de mindfulness e uma comunidade de apoio para transformar sua vida com autoconhecimento e bem-estar.',
                          style: TextStyle(
                            color: AppTheme.textPrimary.withAlpha(230),
                            fontSize: isMobile ? 16 : 20,
                            height: 1.4,
                          ),
                          textAlign: isMobile ? TextAlign.center : TextAlign.left,
                        ),
                        const SizedBox(height: 36),
                        Row(
                          mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () => context.go(AppRouter.simpleRegister),
                              icon: const Icon(Icons.auto_awesome, size: 22),
                              label: const Text('Começar Agora'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.primary,
                                foregroundColor: AppTheme.textPrimary,
                                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
                                textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 4,
                              ),
                            ),
                            const SizedBox(width: 16),
                            OutlinedButton.icon(
                              onPressed: () => context.go(AppRouter.login),
                              icon: const Icon(Icons.login, size: 22),
                              label: const Text('Fazer Login'),
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: AppTheme.buttonSecondary, width: 2),
                                foregroundColor: AppTheme.buttonSecondary,
                                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
                                textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.width < 700 ? 420 : 500,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: AnimatedOpacity(
                opacity: 1,
                duration: const Duration(milliseconds: 700),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      constraints: const BoxConstraints(maxWidth: 900),
                      child: Column(
                        children: [
                          Text(
                            'Bem-vindo(a) ao Universo Aya',
                            style: TextStyle(
                              color: AppTheme.textPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.width < 700 ? 22 : 28,
                              letterSpacing: 1.1,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          LayoutBuilder(
                            builder: (context, constraints) {
                              final isMobile = constraints.maxWidth < 700;
                              return Flex(
                                direction: isMobile ? Axis.vertical : Axis.horizontal,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  _WelcomeFeature(
                                    icon: Icons.self_improvement,
                                    color: AppTheme.indicator,
                                    title: 'Meditações Guiadas',
                                    description: 'Práticas para relaxar, focar e se reconectar com você mesma.',
                                  ),
                                  _WelcomeFeature(
                                    icon: Icons.psychology_alt,
                                    color: AppTheme.primary,
                                    title: 'Jornadas de Autoconhecimento',
                                    description: 'Conteúdos e trilhas para sua evolução pessoal e emocional.',
                                  ),
                                  _WelcomeFeature(
                                    icon: Icons.favorite,
                                    color: AppTheme.buttonSecondary,
                                    title: 'Comunidade Acolhedora',
                                    description: 'Troque experiências, encontre apoio e cresça junto.',
                                  ),
                                  _WelcomeFeature(
                                    icon: Icons.star,
                                    color: AppTheme.card,
                                    title: 'Conteúdo Inspirador',
                                    description: 'Dicas, desafios e inspiração diária para sua jornada.',
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.width < 700 ? 720 : 670,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: AnimatedOpacity(
                opacity: 1,
                duration: const Duration(milliseconds: 700),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      constraints: const BoxConstraints(maxWidth: 900),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Uma Amostra da Sua Jornada',
                            style: TextStyle(
                              color: AppTheme.textPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.width < 700 ? 20 : 26,
                            ),
                          ),
                          const SizedBox(height: 18),
                          SizedBox(
                            height: 240,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: 3,
                              separatorBuilder: (_, __) => const SizedBox(width: 18),
                              itemBuilder: (context, index) => _IntroVideoCard(index: index),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Testimonials Section
          Positioned(
            top: MediaQuery.of(context).size.width < 700 ? 1000 : 950,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppTheme.secondary.withAlpha(25),
                    AppTheme.secondary.withAlpha(13),
                  ],
                ),
              ),
              child: Column(
                children: [
                  Container(
                    constraints: const BoxConstraints(maxWidth: 900),
                    child: Column(
                      children: [
                        Text(
                          'O Que Nossas Usuárias Dizem',
                          style: TextStyle(
                            color: AppTheme.textPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width < 700 ? 22 : 28,
                            letterSpacing: 1.1,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 40),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            final isMobile = constraints.maxWidth < 700;
                            return Flex(
                              direction: isMobile ? Axis.vertical : Axis.horizontal,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                _TestimonialCard(
                                  name: 'Ana Silva',
                                  role: 'Yoga Instructor',
                                  image: 'assets/images/testimonial1.jpg',
                                  text: 'O Aya transformou minha prática de meditação. Os conteúdos são profundos e acessíveis.',
                                ),
                                _TestimonialCard(
                                  name: 'Mariana Costa',
                                  role: 'Psicóloga',
                                  image: 'assets/images/testimonial2.jpg',
                                  text: 'Uma ferramenta incrível para autoconhecimento. Recomendo para todas as minhas pacientes.',
                                ),
                                _TestimonialCard(
                                  name: 'Juliana Santos',
                                  role: 'Estudante',
                                  image: 'assets/images/testimonial3.jpg',
                                  text: 'A comunidade é acolhedora e os conteúdos me ajudam a manter o equilíbrio na rotina.',
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Secondary CTA Section
          Positioned(
            top: MediaQuery.of(context).size.width < 700 ? 1400 : 1350,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppTheme.primary.withAlpha(25),
                    AppTheme.buttonSecondary.withAlpha(25),
                  ],
                ),
              ),
              child: Column(
                children: [
                  Container(
                    constraints: const BoxConstraints(maxWidth: 900),
                    child: Column(
                      children: [
                        Text(
                          'Comece Sua Jornada Hoje',
                          style: TextStyle(
                            color: AppTheme.textPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width < 700 ? 24 : 32,
                            letterSpacing: 1.1,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Junte-se a milhares de mulheres que já transformaram suas vidas com o Aya.',
                          style: TextStyle(
                            color: AppTheme.textPrimary.withAlpha(230),
                            fontSize: MediaQuery.of(context).size.width < 700 ? 16 : 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
                        ElevatedButton.icon(
                          onPressed: () => context.push(AppRouter.subscriptionPlans),
                          icon: const Icon(Icons.auto_awesome, size: 24),
                          label: const Text('Começar Agora'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primary,
                            foregroundColor: AppTheme.textPrimary,
                            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 20),
                            textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Footer
          Positioned(
            top: MediaQuery.of(context).size.width < 700 ? 1600 : 1550,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 16),
              decoration: BoxDecoration(
                color: AppTheme.secondary.withAlpha(13),
              ),
              child: Column(
                children: [
                  Container(
                    constraints: const BoxConstraints(maxWidth: 900),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.spa, color: AppTheme.primary, size: 32),
                            const SizedBox(width: 8),
                            Text(
                              'App Aya',
                              style: TextStyle(
                                color: AppTheme.textPrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            final isMobile = constraints.maxWidth < 700;
                            return Flex(
                              direction: isMobile ? Axis.vertical : Axis.horizontal,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _FooterColumn(
                                  title: 'Sobre',
                                  items: ['O que é o Aya', 'Nossa Missão', 'Time', 'Carreiras'],
                                ),
                                _FooterColumn(
                                  title: 'Recursos',
                                  items: ['Meditações', 'Jornadas', 'Comunidade', 'Blog'],
                                ),
                                _FooterColumn(
                                  title: 'Suporte',
                                  items: ['FAQ', 'Contato', 'Termos', 'Privacidade'],
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 32),
                        Text(
                          '© 2024 App Aya. Todos os direitos reservados.',
                          style: TextStyle(
                            color: AppTheme.textPrimary.withAlpha(230),
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  final String title;
  final String description;
  const _HeroCard({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppTheme.secondary.withAlpha(179),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: TextStyle(
                color: AppTheme.textPrimary.withAlpha(230),
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VideoThumbnail extends StatelessWidget {
  final int index;
  const _VideoThumbnail({required this.index});

  @override
  Widget build(BuildContext context) {
    // Lista de imagens de exemplo (substitua pelos assets reais depois)
    final List<String> images = [
      'assets/images/video1.jpg',
      'assets/images/video2.jpg',
      'assets/images/video3.jpg',
    ];
    final image = images[index % images.length];
    return GestureDetector(
      onTap: () {
        // Abrir player de vídeo (placeholder)
      },
      child: Container(
        width: 120,
        height: 200,
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primary.withAlpha(46),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // Gradiente overlay
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
            // Play icon central
            Center(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppTheme.buttonGradient,
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primary.withAlpha(77),
                      blurRadius: 8,
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(12),
                child: Icon(Icons.play_arrow_rounded, color: AppTheme.textPrimary, size: 36),
              ),
            ),
            // Título na base
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  'Vídeo Introdutório ${index + 1}',
                  style: TextStyle(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    shadows: [
                      Shadow(
                        color: Colors.black.withAlpha(128),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WelcomeFeature extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String description;
  const _WelcomeFeature({required this.icon, required this.color, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 0 : 12, vertical: isMobile ? 12 : 0),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: AppTheme.secondary.withAlpha(179),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: color.withAlpha(33),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(icon, color: color, size: 38),
                  const SizedBox(height: 12),
                  Text(
                    title,
                    style: TextStyle(
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                      color: AppTheme.textPrimary.withAlpha(230),
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _IntroVideoCard extends StatelessWidget {
  final int index;
  const _IntroVideoCard({required this.index});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> videos = [
      {
        'title': 'Meditação para Iniciantes',
        'duration': '5 min',
        'image': 'assets/images/video1.jpg',
      },
      {
        'title': 'O Poder do Agora',
        'duration': '7 min',
        'image': 'assets/images/video2.jpg',
      },
      {
        'title': 'Conecte-se com Sua Essência',
        'duration': '6 min',
        'image': 'assets/images/video3.jpg',
      },
    ];
    final video = videos[index % videos.length];
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => _VideoPlayerModal(title: video['title']!),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        width: 150,
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          image: DecorationImage(
            image: AssetImage(video['image']!),
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
                  borderRadius: BorderRadius.circular(18),
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
            Center(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppTheme.buttonGradient,
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primary.withAlpha(77),
                      blurRadius: 8,
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(10),
                child: const Icon(Icons.play_arrow_rounded, color: AppTheme.textPrimary, size: 32),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppTheme.indicator,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'Gratuito',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          video['duration']!,
                          style: TextStyle(
                            color: AppTheme.textPrimary.withAlpha(230),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      video['title']!,
                      style: TextStyle(
                        color: AppTheme.textPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        shadows: [
                          Shadow(
                            color: Colors.black.withAlpha(128),
                            blurRadius: 6,
                          ),
                        ],
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
  }
}

class _VideoPlayerModal extends StatelessWidget {
  final String title;
  const _VideoPlayerModal({required this.title});

  @override
  Widget build(BuildContext context) {
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
                Navigator.of(context).pushNamed('/plans');
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

class _TestimonialCard extends StatelessWidget {
  final String name;
  final String role;
  final String image;
  final String text;

  const _TestimonialCard({
    required this.name,
    required this.role,
    required this.image,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 0 : 12, vertical: isMobile ? 12 : 0),
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.secondary.withAlpha(179),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primary.withAlpha(33),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundImage: AssetImage(image),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              color: AppTheme.textPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            role,
                            style: TextStyle(
                              color: AppTheme.textPrimary.withAlpha(179),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  text,
                  style: TextStyle(
                    color: AppTheme.textPrimary.withAlpha(230),
                    fontSize: 15,
                    height: 1.5,
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

class _FooterColumn extends StatelessWidget {
  final String title;
  final List<String> items;

  const _FooterColumn({
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          ...items.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(0, 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    item,
                    style: TextStyle(
                      color: AppTheme.textPrimary.withAlpha(179),
                      fontSize: 14,
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
} 