class SubscriptionPlan {
  final String name;
  final String description;
  final double price;
  final String period;
  final List<String> benefits;
  final bool isPopular;

  const SubscriptionPlan({
    required this.name,
    required this.description,
    required this.price,
    required this.period,
    required this.benefits,
    this.isPopular = false,
  });

  static const List<SubscriptionPlan> plans = [
    SubscriptionPlan(
      name: 'Plano Gratuito',
      description: 'Acesso básico ao conteúdo',
      price: 0,
      period: 'sempre',
      benefits: [
        'Acesso a conteúdo básico',
        'Comunidade',
        'Suporte por email',
      ],
    ),
    SubscriptionPlan(
      name: 'Plano Mensal',
      description: 'Acesso completo por mês',
      price: 29.90,
      period: 'mês',
      benefits: [
        'Todo conteúdo disponível',
        'Comunidade premium',
        'Suporte prioritário',
        'Certificados',
        'Download de materiais',
      ],
      isPopular: true,
    ),
    SubscriptionPlan(
      name: 'Plano Anual',
      description: 'Acesso completo por ano',
      price: 299.90,
      period: 'ano',
      benefits: [
        'Todo conteúdo disponível',
        'Comunidade premium',
        'Suporte prioritário',
        'Certificados',
        'Download de materiais',
        '2 meses grátis',
        'Acesso antecipado',
      ],
    ),
  ];
} 