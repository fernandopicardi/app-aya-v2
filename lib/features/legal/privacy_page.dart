import 'package:flutter/material.dart';
import 'package:app_aya_v2/config/theme.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Política de Privacidade'),
        backgroundColor: AppTheme.secondary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Política de Privacidade do Caminho Aya',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Última atualização: 1 de Março de 2024',
              style: TextStyle(
                color: AppTheme.textPrimary,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24),
            _buildSection(
              '1. Coleta de Informações',
              'Coletamos informações que você nos fornece diretamente, como nome, e-mail e dados de perfil. Também coletamos informações sobre seu uso do aplicativo, incluindo conteúdo que você acessa e interações com outros usuários.',
            ),
            _buildSection(
              '2. Uso das Informações',
              'Utilizamos suas informações para:\n'
                  '• Fornecer e melhorar nossos serviços\n'
                  '• Personalizar sua experiência\n'
                  '• Comunicar-se com você sobre atualizações e novidades\n'
                  '• Garantir a segurança do aplicativo',
            ),
            _buildSection(
              '3. Compartilhamento de Dados',
              'Não compartilhamos suas informações pessoais com terceiros, exceto quando:\n'
                  '• Você autoriza explicitamente\n'
                  '• É necessário para cumprir obrigações legais\n'
                  '• É necessário para proteger nossos direitos',
            ),
            _buildSection(
              '4. Segurança dos Dados',
              'Implementamos medidas de segurança técnicas e organizacionais para proteger suas informações pessoais contra acesso não autorizado, alteração ou destruição.',
            ),
            _buildSection(
              '5. Seus Direitos',
              'Você tem o direito de:\n'
                  '• Acessar suas informações pessoais\n'
                  '• Corrigir dados imprecisos\n'
                  '• Solicitar a exclusão de seus dados\n'
                  '• Retirar seu consentimento a qualquer momento',
            ),
            _buildSection(
              '6. Cookies e Tecnologias Similares',
              'Utilizamos cookies e tecnologias similares para melhorar sua experiência no aplicativo e coletar informações sobre como você o utiliza.',
            ),
            _buildSection(
              '7. Alterações na Política',
              'Podemos atualizar esta política periodicamente. Notificaremos você sobre quaisquer alterações significativas através do aplicativo ou por e-mail.',
            ),
            _buildSection(
              '8. Contato',
              'Se você tiver dúvidas sobre nossa política de privacidade, entre em contato conosco através do e-mail: privacidade@caminhoaya.com.br',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              fontSize: 16,
              color: AppTheme.textPrimary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
