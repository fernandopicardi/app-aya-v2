import 'package:flutter/material.dart';
import 'package:app_aya_v2/config/theme.dart';

class SubscriptionPlansPage extends StatelessWidget {
  const SubscriptionPlansPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escolha seu plano'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: AppTheme.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Transforme sua jornada com o App Aya! Escolha o plano ideal para você:',
              style: TextStyle(
                color: AppTheme.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            // Cards dos planos
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: _PlanCard(
                    title: 'Gratuito',
                    price: 'R\$ 0',
                    benefits: const [
                      'Acesso limitado a aulas',
                      'Parte da comunidade',
                      'Conteúdos introdutórios',
                    ],
                    cta: 'Cadastre-se Gratuitamente',
                    onTap: () {
                      Navigator.of(context).pushNamed('/simple-register');
                    },
                    highlight: false,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _PlanCard(
                    title: 'Mensal',
                    price: 'R\$ 29,90/mês',
                    benefits: const [
                      'Acesso a todos os módulos básicos',
                      'Comunidade completa',
                      'Eventos ao vivo',
                      'Suporte prioritário',
                    ],
                    cta: 'Assinar Mensal',
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        '/payment',
                        arguments: {
                          'plan': 'Mensal',
                          'price': 'R\$ 29,90/mês',
                          'benefits': [
                            'Acesso a todos os módulos básicos',
                            'Comunidade completa',
                            'Eventos ao vivo',
                            'Suporte prioritário',
                          ],
                        },
                      );
                    },
                    highlight: false,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _PlanCard(
                    title: 'Anual',
                    price: 'R\$ 299,00/ano',
                    benefits: const [
                      'Acesso TOTAL a todo o conteúdo',
                      'Módulos premium e exclusivos',
                      'Eventos exclusivos',
                      'Download offline',
                      'Melhor oferta',
                    ],
                    cta: 'Assinar Anual',
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        '/payment',
                        arguments: {
                          'plan': 'Anual',
                          'price': 'R\$ 299,00/ano',
                          'benefits': [
                            'Acesso TOTAL a todo o conteúdo',
                            'Módulos premium e exclusivos',
                            'Eventos exclusivos',
                            'Download offline',
                            'Melhor oferta',
                          ],
                        },
                      );
                    },
                    highlight: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            // Comparativo simples
            Text(
              'Comparativo de funcionalidades',
              style: TextStyle(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),
            _PlanComparisonTable(),
            const SizedBox(height: 32),
            // FAQ rápido (placeholder)
            Text(
              'Dúvidas frequentes',
              style: TextStyle(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '• Posso cancelar quando quiser? Sim!\n• O que está incluso no plano anual? Acesso total a todos os conteúdos, inclusive os exclusivos.\n• Como funciona o pagamento? 100% seguro via RevenueCat/Stripe/Google/Apple.',
              style: TextStyle(
                color: AppTheme.textPrimary.withAlpha(217),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  final String title;
  final String price;
  final List<String> benefits;
  final String cta;
  final VoidCallback onTap;
  final bool highlight;
  const _PlanCard({
    required this.title,
    required this.price,
    required this.benefits,
    required this.cta,
    required this.onTap,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: highlight
            ? AppTheme.buttonGradient
            : LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppTheme.secondary.withAlpha(217),
                  AppTheme.background.withAlpha(242),
                ],
              ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withAlpha(33),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                price,
                style: TextStyle(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              ...benefits.map((b) => Row(
                    children: [
                      Icon(Icons.check, color: AppTheme.indicator, size: 18),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          b,
                          style: TextStyle(
                            color: AppTheme.textPrimary,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  )),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  gradient: AppTheme.buttonGradient,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primary.withAlpha(46),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: onTap,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: Center(
                        child: Text(
                          cta,
                          style: const TextStyle(
                            color: AppTheme.textPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PlanComparisonTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final rows = [
      ['Funcionalidade', 'Gratuito', 'Mensal', 'Anual'],
      ['Acesso a aulas introdutórias', '✔️', '✔️', '✔️'],
      ['Comunidade', 'Limitada', 'Completa', 'Completa'],
      ['Eventos ao vivo', 'Não', 'Sim', 'Exclusivos'],
      ['Módulos premium', 'Não', 'Não', 'Sim'],
      ['Download offline', 'Não', 'Não', 'Sim'],
      ['Suporte prioritário', 'Não', 'Sim', 'Sim'],
    ];
    return Table(
      border: TableBorder.all(color: AppTheme.secondary.withAlpha(64)),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: rows.map((row) {
        return TableRow(
          children: row.map((cell) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            child: Text(
              cell,
              style: TextStyle(
                color: AppTheme.textPrimary,
                fontWeight: row[0] == cell ? FontWeight.bold : FontWeight.normal,
                fontSize: 13,
              ),
              textAlign: TextAlign.center,
            ),
          )).toList(),
        );
      }).toList(),
    );
  }
} 