import 'package:flutter/material.dart';
import 'package:app_aya_v2/config/theme.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perguntas Frequentes'),
        backgroundColor: AppTheme.secondary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildFAQSection(
            'Sobre o Caminho Aya',
            [
              _buildFAQItem(
                'O que é o Caminho Aya?',
                'O Caminho Aya é um aplicativo dedicado ao estudo e prática da medicina tradicional amazônica, oferecendo conteúdo educativo, rituais e uma comunidade de aprendizes.',
              ),
              _buildFAQItem(
                'O aplicativo é gratuito?',
                'O aplicativo oferece conteúdo gratuito e conteúdo premium. Alguns recursos e materiais podem requerer uma assinatura.',
              ),
              _buildFAQItem(
                'Como posso começar a usar o aplicativo?',
                'Basta criar uma conta, fazer login e começar a explorar o conteúdo disponível. Recomendamos começar pela seção de Introdução.',
              ),
            ],
          ),
          _buildFAQSection(
            'Conta e Perfil',
            [
              _buildFAQItem(
                'Como posso criar uma conta?',
                'Você pode criar uma conta usando seu e-mail ou através de autenticação social (Google, Apple).',
              ),
              _buildFAQItem(
                'Esqueci minha senha. O que fazer?',
                'Use a opção "Esqueci minha senha" na tela de login para redefinir sua senha através do e-mail cadastrado.',
              ),
              _buildFAQItem(
                'Como posso atualizar minhas informações?',
                'Acesse seu perfil através do menu principal e clique em "Editar Perfil" para atualizar suas informações.',
              ),
            ],
          ),
          _buildFAQSection(
            'Conteúdo e Recursos',
            [
              _buildFAQItem(
                'Que tipo de conteúdo está disponível?',
                'O aplicativo oferece artigos, vídeos, áudios, rituais guiados e uma biblioteca de conhecimentos tradicionais.',
              ),
              _buildFAQItem(
                'Como posso acessar o conteúdo premium?',
                'O conteúdo premium está disponível através de uma assinatura. Você pode assinar através da seção "Premium" no aplicativo.',
              ),
              _buildFAQItem(
                'Posso baixar conteúdo para uso offline?',
                'Sim, a maioria do conteúdo pode ser baixado para uso offline. Procure pelo ícone de download ao lado do conteúdo desejado.',
              ),
            ],
          ),
          _buildFAQSection(
            'Comunidade e Interação',
            [
              _buildFAQItem(
                'Como posso interagir com outros usuários?',
                'Você pode participar de fóruns, comentar em artigos e participar de eventos comunitários através do aplicativo.',
              ),
              _buildFAQItem(
                'Existe moderação no conteúdo da comunidade?',
                'Sim, todo o conteúdo da comunidade é moderado para garantir um ambiente respeitoso e seguro.',
              ),
              _buildFAQItem(
                'Posso compartilhar conteúdo com amigos?',
                'Sim, você pode compartilhar conteúdo através de links ou redes sociais, respeitando os direitos autorais.',
              ),
            ],
          ),
          _buildFAQSection(
            'Suporte e Ajuda',
            [
              _buildFAQItem(
                'Como posso obter ajuda?',
                'Você pode entrar em contato com nossa equipe de suporte através do e-mail suporte@caminhoaya.com.br ou usar o chat de suporte no aplicativo.',
              ),
              _buildFAQItem(
                'Como reportar um problema?',
                'Use a opção "Reportar Problema" no menu de configurações ou entre em contato com nosso suporte.',
              ),
              _buildFAQItem(
                'O aplicativo está disponível em outros idiomas?',
                'Atualmente, o aplicativo está disponível em português e inglês. Mais idiomas serão adicionados em breve.',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFAQSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
        ),
        ...items,
        const Divider(height: 32),
      ],
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return ExpansionTile(
      title: Text(
        question,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppTheme.textPrimary,
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            answer,
            style: const TextStyle(
              fontSize: 14,
              color: AppTheme.textPrimary,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
