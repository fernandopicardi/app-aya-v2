import 'package:flutter/material.dart';
import 'package:app_aya_v2/config/theme.dart';
import 'package:go_router/go_router.dart';
import 'package:app_aya_v2/config/routes.dart';

class PaymentPage extends StatefulWidget {
  final String plan;
  final String price;
  final List<String> benefits;
  const PaymentPage({super.key, required this.plan, required this.price, required this.benefits});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool _isPaying = false;

  void _pay() async {
    setState(() => _isPaying = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      context.go('/dashboard'); // Redireciona para dashboard
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagamento'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: AppTheme.background,
      body: Center(
        child: Card(
          color: AppTheme.secondary.withOpacity(0.8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          margin: const EdgeInsets.all(24),
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Resumo do Plano',
                  style: TextStyle(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  widget.plan,
                  style: TextStyle(
                    color: AppTheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  widget.price,
                  style: TextStyle(
                    color: AppTheme.textPrimary,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ...widget.benefits.map((b) => Row(
                      children: [
                        Icon(Icons.check, color: AppTheme.indicator, size: 18),
                        const SizedBox(width: 6),
                        Expanded(child: Text(b, style: TextStyle(color: AppTheme.textPrimary, fontSize: 14))),
                      ],
                    )),
                const SizedBox(height: 24),
                _isPaying
                    ? const Center(child: CircularProgressIndicator(color: AppTheme.textPrimary))
                    : ElevatedButton(
                        onPressed: _pay,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primary,
                          foregroundColor: AppTheme.textPrimary,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text('Pagar'),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 