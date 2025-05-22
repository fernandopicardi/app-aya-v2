import 'package:flutter/material.dart';
import 'package:app_aya_v2/core/theme/app_theme.dart';
import 'package:app_aya_v2/features/legal/terms_page.dart';
import 'package:app_aya_v2/features/legal/privacy_page.dart';
import 'package:app_aya_v2/features/legal/faq_page.dart';

class LegalPage extends StatelessWidget {
  const LegalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Legal'),
        backgroundColor: AyaColors.surface,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSection(
            context,
            'Termos de Uso',
            'Leia nossos termos de uso e condições de serviço',
            Icons.description,
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TermsPage()),
            ),
          ),
          _buildSection(
            context,
            'Política de Privacidade',
            'Entenda como protegemos seus dados',
            Icons.privacy_tip,
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PrivacyPage()),
            ),
          ),
          _buildSection(
            context,
            'Perguntas Frequentes',
            'Encontre respostas para suas dúvidas',
            Icons.help_outline,
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FAQPage()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: ListTile(
        leading: Icon(icon, color: AyaColors.turquoise),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AyaColors.textPrimary,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            fontSize: 14,
            color: AyaColors.textSecondary,
          ),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
