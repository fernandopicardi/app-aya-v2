import 'package:flutter/material.dart';
import 'package:app_aya_v2/config/theme.dart';
import 'package:go_router/go_router.dart';
import 'package:app_aya_v2/config/routes.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

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
              children: [
                _buildHeader(context),
                _buildHeroSection(context),
                _buildFeaturesSection(),
                _buildTestimonialsSection(),
                _buildPricingSection(context),
                _buildFooter(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
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
          Row(
            children: [
              TextButton(
                onPressed: () {
                  final router = GoRouter.of(context);
                  router.go(AppRouter.login);
                },
                child: Text(
                  'Entrar',
                  style: TextStyle(
                    color: AppTheme.textPrimary,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  final router = GoRouter.of(context);
                  router.go(AppRouter.simpleRegister);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                  foregroundColor: AppTheme.textPrimary,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Começar Agora'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      child: Column(
        children: [
          Text(
            'Descubra o poder da\nmeditação guiada',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 48,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Aprenda técnicas de meditação e mindfulness\npara uma vida mais equilibrada e consciente',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppTheme.textPrimary.withAlpha(204),
              fontSize: 18,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 48),
          ElevatedButton(
            onPressed: () {
              final router = GoRouter.of(context);
              router.go(AppRouter.simpleRegister);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primary,
              foregroundColor: AppTheme.textPrimary,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Comece Gratuitamente'),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      child: Column(
        children: [
          Text(
            'Recursos',
            style: TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 48),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildFeatureCard(
                icon: Icons.self_improvement,
                title: 'Meditações Guiadas',
                description: 'Aprenda técnicas de meditação com guias experientes',
              ),
              _buildFeatureCard(
                icon: Icons.psychology,
                title: 'Agente IA Aya',
                description: 'Converse com seu assistente pessoal de mindfulness',
              ),
              _buildFeatureCard(
                icon: Icons.people,
                title: 'Comunidade',
                description: 'Conecte-se com outros praticantes',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.secondary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppTheme.primary, size: 48),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppTheme.textPrimary.withAlpha(204),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonialsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      child: Column(
        children: [
          Text(
            'O que nossos usuários dizem',
            style: TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 48),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildTestimonialCard(
                name: 'Maria Silva',
                role: 'Professora',
                text: 'O App Aya transformou minha prática de meditação. As sessões guiadas são incríveis!',
                avatar: 'assets/images/user1.jpg',
              ),
              _buildTestimonialCard(
                name: 'João Santos',
                role: 'Empresário',
                text: 'A IA Aya é um diferencial incrível. Ela me ajuda a manter a consistência na prática.',
                avatar: 'assets/images/user2.jpg',
              ),
              _buildTestimonialCard(
                name: 'Ana Costa',
                role: 'Estudante',
                text: 'A comunidade é muito acolhedora. Aprendo muito com as experiências dos outros.',
                avatar: 'assets/images/user3.jpg',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonialCard({
    required String name,
    required String role,
    required String text,
    required String avatar,
  }) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.secondary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage(avatar),
          ),
          const SizedBox(height: 16),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppTheme.textPrimary.withAlpha(204),
              fontSize: 16,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            name,
            style: const TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            role,
            style: TextStyle(
              color: AppTheme.textPrimary.withAlpha(153),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPricingSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      child: Column(
        children: [
          Text(
            'Planos',
            style: TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 48),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildPricingCard(
                title: 'Gratuito',
                price: 'R\$ 0',
                period: 'para sempre',
                features: [
                  'Acesso a meditações básicas',
                  'Comunidade',
                  'Agente IA Aya básico',
                ],
                isPopular: false,
                onPressed: () {
                  final router = GoRouter.of(context);
                  router.go(AppRouter.simpleRegister);
                },
              ),
              _buildPricingCard(
                title: 'Premium',
                price: 'R\$ 19,90',
                period: 'por mês',
                features: [
                  'Todas as meditações',
                  'Comunidade premium',
                  'Agente IA Aya avançado',
                  'Conteúdo exclusivo',
                  'Suporte prioritário',
                ],
                isPopular: true,
                onPressed: () {
                  final router = GoRouter.of(context);
                  router.go(AppRouter.subscriptionPlans);
                },
              ),
              _buildPricingCard(
                title: 'Anual',
                price: 'R\$ 199,90',
                period: 'por ano',
                features: [
                  'Todas as meditações',
                  'Comunidade premium',
                  'Agente IA Aya avançado',
                  'Conteúdo exclusivo',
                  'Suporte prioritário',
                  '2 meses grátis',
                ],
                isPopular: false,
                onPressed: () {
                  final router = GoRouter.of(context);
                  router.go(AppRouter.subscriptionPlans);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPricingCard({
    required String title,
    required String price,
    required String period,
    required List<String> features,
    required bool isPopular,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.secondary,
        borderRadius: BorderRadius.circular(16),
        border: isPopular
            ? Border.all(color: AppTheme.primary, width: 2)
            : null,
      ),
      child: Column(
        children: [
          if (isPopular)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppTheme.primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Mais Popular',
                style: TextStyle(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          if (isPopular) const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            price,
            style: const TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            period,
            style: TextStyle(
              color: AppTheme.textPrimary.withAlpha(153),
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 24),
          ...features.map((feature) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, color: AppTheme.primary, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      feature,
                      style: const TextStyle(
                        color: AppTheme.textPrimary,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              )),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: isPopular ? AppTheme.primary : AppTheme.secondary,
              foregroundColor: AppTheme.textPrimary,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: isPopular ? AppTheme.primary : AppTheme.textPrimary.withAlpha(77),
                ),
              ),
            ),
            child: Text(isPopular ? 'Começar Agora' : 'Escolher Plano'),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      color: AppTheme.secondary,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
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
                  const SizedBox(height: 16),
                  Text(
                    'Transforme sua vida através\nda meditação e mindfulness',
                    style: TextStyle(
                      color: AppTheme.textPrimary.withAlpha(204),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  _buildFooterLink('Sobre'),
                  _buildFooterLink('Recursos'),
                  _buildFooterLink('Planos'),
                  _buildFooterLink('Contato'),
                ],
              ),
            ],
          ),
          const SizedBox(height: 48),
          const Divider(color: AppTheme.textPrimary),
          const SizedBox(height: 24),
          Text(
            '© 2024 App Aya. Todos os direitos reservados.',
            style: TextStyle(
              color: AppTheme.textPrimary.withAlpha(153),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterLink(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        label,
        style: TextStyle(
          color: AppTheme.textPrimary.withAlpha(204),
          fontSize: 16,
        ),
      ),
    );
  }
} 