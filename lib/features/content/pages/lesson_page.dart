import 'package:flutter/material.dart';
import 'package:app_aya_v2/config/theme.dart';

class LessonPage extends StatelessWidget {
  final String lessonTitle;
  const LessonPage({super.key, this.lessonTitle = 'Aula 01 - Introdução à Gratidão'});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.primary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Aula',
          style: TextStyle(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          // Player de vídeo/áudio (placeholder visual)
          Container(
            height: isMobile ? 220 : 320,
            margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            decoration: BoxDecoration(
              color: const Color(0xFF474C72),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
              image: const DecorationImage(
                image: AssetImage('assets/images/lesson1.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(80),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(18),
                child: const Icon(Icons.play_circle_fill, color: Color(0xFFACA1EF), size: 64),
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Título, metadados, pontos
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lessonTitle,
                  style: const TextStyle(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.play_circle_outline, color: AppTheme.primary, size: 18),
                    const SizedBox(width: 4),
                    const Text('Vídeo • 5 min', style: TextStyle(color: AppTheme.textPrimary, fontSize: 14)),
                    const SizedBox(width: 12),
                    const Icon(Icons.auto_awesome, color: Color(0xFF78C7B4), size: 18),
                    const SizedBox(width: 2),
                    const Text('1 Ponto Aya', style: TextStyle(color: Color(0xFF78C7B4), fontSize: 14, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 16),
                _ExpandableDescription(
                  text: 'Descubra como a gratidão pode transformar sua vida. Nesta aula, você aprenderá práticas simples e poderosas para cultivar gratidão diariamente. Aprofunde-se no tema e veja exemplos reais de transformação. ' * 2,
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          // Barra de ações
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                _LessonAction(icon: Icons.check_circle, label: 'Concluir'),
                _LessonAction(icon: Icons.edit_note, label: 'Anotações'),
                _LessonAction(icon: Icons.playlist_add, label: 'Playlist'),
                _LessonAction(icon: Icons.star_border, label: 'Favoritar'),
                _LessonAction(icon: Icons.share, label: 'Compartilhar'),
                _LessonAction(icon: Icons.download, label: 'Download'),
              ],
            ),
          ),
          const SizedBox(height: 18),
          // Botão Próximo
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.arrow_forward, color: Color(0xFFF8F8FF)),
              label: const Text('Próxima Aula'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFACA1EF),
                foregroundColor: const Color(0xFFF8F8FF),
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(height: 28),
          // Seção de comentários
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Comentários',
                  style: TextStyle(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage('assets/images/user1.jpg'),
                      radius: 18,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Faça um comentário...'
                              ,
                          filled: true,
                          fillColor: AppTheme.secondary.withAlpha(30),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send, color: AppTheme.primary),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                // Lista de comentários
                _CommentCard(
                  user: 'Maria Silva',
                  avatar: 'assets/images/user1.jpg',
                  time: '4m',
                  text: 'Amei essa aula! Prática simples e poderosa.',
                  likes: 3,
                ),
                _CommentCard(
                  user: 'Juliana Santos',
                  avatar: 'assets/images/user2.jpg',
                  time: '12m',
                  text: 'A gratidão realmente faz diferença no meu dia.',
                  likes: 1,
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _LessonAction extends StatelessWidget {
  final IconData icon;
  final String label;
  const _LessonAction({required this.icon, required this.label});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppTheme.primary.withAlpha(30),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppTheme.primary, size: 22),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
            color: AppTheme.textPrimary,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}

class _ExpandableDescription extends StatefulWidget {
  final String text;
  const _ExpandableDescription({required this.text});
  @override
  State<_ExpandableDescription> createState() => _ExpandableDescriptionState();
}

class _ExpandableDescriptionState extends State<_ExpandableDescription> {
  bool expanded = false;
  @override
  Widget build(BuildContext context) {
    final maxLines = expanded ? null : 3;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          style: const TextStyle(color: AppTheme.textPrimary, fontSize: 15),
          maxLines: maxLines,
          overflow: expanded ? TextOverflow.visible : TextOverflow.ellipsis,
        ),
        if (widget.text.length > 120)
          TextButton(
            onPressed: () => setState(() => expanded = !expanded),
            child: Text(expanded ? 'Ver menos' : 'Ver mais'),
            style: TextButton.styleFrom(
              foregroundColor: AppTheme.primary,
              textStyle: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
      ],
    );
  }
}

class _CommentCard extends StatelessWidget {
  final String user;
  final String avatar;
  final String time;
  final String text;
  final int likes;
  const _CommentCard({required this.user, required this.avatar, required this.time, required this.text, required this.likes});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF474C72),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(avatar),
              radius: 18,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        user,
                        style: const TextStyle(
                          color: Color(0xFFF8F8FF),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        time,
                        style: const TextStyle(
                          color: Color(0xFFACA1EF),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    text,
                    style: const TextStyle(
                      color: Color(0xFFF8F8FF),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.favorite_border, color: Color(0xFFACA1EF), size: 18),
                      const SizedBox(width: 4),
                      Text('$likes', style: const TextStyle(color: Color(0xFFACA1EF), fontSize: 13)),
                      const SizedBox(width: 16),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Responder'),
                        style: TextButton.styleFrom(
                          foregroundColor: Color(0xFF78C7B4),
                          textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 