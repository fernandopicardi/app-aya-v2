import 'package:flutter/material.dart';
import 'package:app_aya_v2/core/theme/app_theme.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Termos de Uso'),
        backgroundColor: AyaColors.surface,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Termos de Uso do Caminho Aya',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AyaColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Última atualização: 1 de Março de 2024',
              style: TextStyle(
                color: AyaColors.textPrimary,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24),
            _buildSection(
              '1. Aceitação dos Termos',
              'Ao acessar e usar o aplicativo Caminho Aya, você concorda em cumprir estes termos de uso. Se você não concordar com qualquer parte destes termos, não poderá acessar o aplicativo.',
            ),
            _buildSection(
              '2. Uso do Serviço',
              'O Caminho Aya é uma plataforma de bem-estar e desenvolvimento pessoal. Você concorda em usar o serviço apenas para fins legais e de acordo com estes termos.',
            ),
            _buildSection(
              '3. Conta do Usuário',
              'Para acessar certos recursos do aplicativo, você precisará criar uma conta. Você é responsável por manter a confidencialidade de sua conta e senha.',
            ),
            _buildSection(
              '4. Conteúdo do Usuário',
              'Você mantém todos os direitos sobre o conteúdo que compartilha no aplicativo. Ao compartilhar conteúdo, você concede ao Caminho Aya uma licença não exclusiva para usar, modificar e distribuir esse conteúdo.',
            ),
            _buildSection(
              '5. Propriedade Intelectual',
              'Todo o conteúdo disponível no aplicativo, incluindo textos, imagens, vídeos e áudios, é propriedade do Caminho Aya ou de seus licenciadores.',
            ),
            _buildSection(
              '6. Limitação de Responsabilidade',
              'O Caminho Aya não se responsabiliza por danos indiretos, incidentais ou consequentes que possam resultar do uso ou impossibilidade de uso do aplicativo.',
            ),
            _buildSection(
              '7. Modificações',
              'Reservamo-nos o direito de modificar estes termos a qualquer momento. As modificações entrarão em vigor imediatamente após sua publicação no aplicativo.',
            ),
            _buildSection(
              '8. Contato',
              'Se você tiver dúvidas sobre estes termos, entre em contato conosco através do e-mail: suporte@caminhoaya.com.br',
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
              color: AyaColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              fontSize: 16,
              color: AyaColors.textPrimary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
