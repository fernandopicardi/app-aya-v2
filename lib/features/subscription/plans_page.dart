import 'package:flutter/material.dart';

class PlansPage extends StatelessWidget {
  const PlansPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2B2352),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Planos', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Escolha seu Plano',
                style: TextStyle(
                  fontFamily: 'Serif',
                  fontSize: 28,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              _PlanCard(
                title: 'Gratuito',
                price: 'R\$ 0',
                description: 'Acesso básico ao conteúdo e comunidade.',
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
              ),
              const SizedBox(height: 24),
              _PlanCard(
                title: 'Mensal',
                price: 'R\$ 29,90/mês',
                description:
                    'Acesso completo, comunidade premium, IA avançada.',
                onPressed: () {
                  // TODO: Levar para cadastro + pagamento
                  Navigator.pushNamed(context, '/signup');
                },
              ),
              const SizedBox(height: 24),
              _PlanCard(
                title: 'Anual',
                price: 'R\$ 299,90/ano',
                description: 'Todos os benefícios + 2 meses grátis.',
                onPressed: () {
                  // TODO: Levar para cadastro + pagamento
                  Navigator.pushNamed(context, '/signup');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  final String title;
  final String price;
  final String description;
  final VoidCallback onPressed;
  const _PlanCard(
      {required this.title,
      required this.price,
      required this.description,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(20),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Serif',
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            price,
            style: const TextStyle(
              fontSize: 20,
              color: Color(0xFF78C7B4),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF78C7B4),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              textStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Escolher Plano'),
          ),
        ],
      ),
    );
  }
}
