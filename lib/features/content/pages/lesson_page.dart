import 'package:flutter/material.dart';
import 'package:app_aya_v2/core/theme/app_theme.dart';
import 'package:app_aya_v2/features/content/services/lesson_service.dart';
import 'package:app_aya_v2/core/widgets/aya_bottom_sheet.dart';
import 'package:app_aya_v2/core/widgets/aya_app_bar.dart';

class LessonPage extends StatefulWidget {
  final String lessonId;
  final String lessonTitle;
  const LessonPage({
    super.key,
    required this.lessonId,
    this.lessonTitle = 'Aula 01 - Introdução à Gratidão',
  });

  @override
  State<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  final _lessonService = LessonService();
  final _commentController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    setState(() => _isLoading = true);
    try {
      await _lessonService.loadInitialState(widget.lessonId);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Dados carregados com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao carregar dados: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AyaColors.backgroundGradient,
        ),
        child: CustomScrollView(
          slivers: [
            AyaAppBar(
              title: 'Aula',
              showBackButton: true,
              actions: [
                StreamBuilder<bool>(
                  stream: _lessonService.favoriteStream,
                  initialData: false,
                  builder: (context, snapshot) {
                    final isFavorite = snapshot.data ?? false;
                    return IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite
                            ? AyaColors.primary
                            : AyaColors.textPrimary,
                      ),
                      onPressed: () =>
                          _lessonService.toggleFavorite(widget.lessonId),
                    );
                  },
                ),
                IconButton(
                  icon:
                      const Icon(Icons.more_vert, color: AyaColors.textPrimary),
                  onPressed: () => _showMoreOptions(),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMediaPlayer(),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLessonTitle(),
                        const SizedBox(height: 16),
                        _buildLessonActions(),
                        const SizedBox(height: 24),
                        _buildLessonContent(),
                        const SizedBox(height: 24),
                        _buildDownloadableMaterials(),
                        const SizedBox(height: 24),
                        _buildCommentsSection(),
                        const SizedBox(height: 32),
                        _buildNavigationButtons(context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMediaPlayer() {
    return StreamBuilder<PlaybackState>(
      stream: _lessonService.playbackStream,
      initialData: PlaybackState(),
      builder: (context, snapshot) {
        final playbackState = snapshot.data!;
        return Container(
          height:
              MediaQuery.of(context).size.width * 0.5625, // 16:9 aspect ratio
          width: double.infinity,
          decoration: BoxDecoration(
            color: AyaColors.surface.withAlpha(128), // 50% opacity
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Thumbnail or video content
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
                child: Image.asset(
                  'assets/images/lesson1.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              // Overlay gradient
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      AyaColors.black70,
                    ],
                  ),
                ),
              ),
              // Playback controls
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        playbackState.isPlaying
                            ? Icons.pause
                            : Icons.play_circle_fill,
                        color: AyaColors.primary,
                        size: 64,
                      ),
                      onPressed: () {
                        if (playbackState.isPlaying) {
                          _lessonService.pause(widget.lessonId);
                        } else {
                          _lessonService.play(widget.lessonId);
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    // Progress bar
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Column(
                        children: [
                          Slider(
                            value: playbackState.currentPosition.inSeconds
                                .toDouble(),
                            min: 0,
                            max: playbackState.duration.inSeconds.toDouble(),
                            activeColor: AyaColors.primary,
                            inactiveColor: AyaColors.white30,
                            onChanged: (value) {
                              _lessonService.seekTo(
                                widget.lessonId,
                                Duration(seconds: value.toInt()),
                              );
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _formatDuration(
                                      playbackState.currentPosition),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  _formatDuration(playbackState.duration),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLessonTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.lessonTitle,
          style: const TextStyle(
            color: AyaColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            const Icon(Icons.play_circle_outline,
                color: AyaColors.primary, size: 18),
            const SizedBox(width: 4),
            const Text('Vídeo • 5 min',
                style: TextStyle(color: AyaColors.textPrimary, fontSize: 14)),
            const SizedBox(width: 12),
            const Icon(Icons.auto_awesome, color: AyaColors.accent, size: 18),
            const SizedBox(width: 2),
            const Text('1 Ponto Aya',
                style: TextStyle(
                    color: AyaColors.accent,
                    fontSize: 14,
                    fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 16),
        _ExpandableDescription(
          text:
              'Descubra como a gratidão pode transformar sua vida. Nesta aula, você aprenderá práticas simples e poderosas para cultivar gratidão diariamente. Aprofunde-se no tema e veja exemplos reais de transformação.',
        ),
      ],
    );
  }

  Widget _buildLessonActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildActionButton(Icons.favorite_border, 'Curtir'),
        _buildActionButton(Icons.bookmark_border, 'Salvar'),
        _buildActionButton(Icons.edit_note, 'Anotações'),
        _buildActionButton(Icons.check_circle_outline, 'Concluir'),
      ],
    );
  }

  Widget _buildDownloadableMaterials() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Materiais para Download',
          style: TextStyle(
            color: AyaColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildMaterialItem(
          icon: Icons.picture_as_pdf,
          title: 'Slides da Aula',
          onDownload: () => _downloadMaterial('slides'),
        ),
        _buildMaterialItem(
          icon: Icons.description,
          title: 'Exercícios',
          onDownload: () => _downloadMaterial('exercises'),
        ),
      ],
    );
  }

  Widget _buildMaterialItem({
    required IconData icon,
    required String title,
    required VoidCallback onDownload,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: AyaColors.primary, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: AyaColors.textPrimary,
                fontSize: 16,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.download, color: AyaColors.primary),
            onPressed: onDownload,
          ),
        ],
      ),
    );
  }

  Widget _buildCommentsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Comentários',
          style: TextStyle(
            color: AyaColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AyaColors.surface.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Center(
            child: Text(
              'Comentários em desenvolvimento',
              style: TextStyle(
                color: AyaColors.textSecondary,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showMoreOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => AyaBottomSheet(
        title: 'Opções',
        items: [
          BottomSheetItem(
            icon: Icons.share,
            label: 'Compartilhar',
            onTap: () {
              Navigator.pop(context);
              _shareLesson();
            },
          ),
          BottomSheetItem(
            icon: Icons.download,
            label: 'Baixar Aula',
            onTap: () {
              Navigator.pop(context);
              _downloadLesson();
            },
          ),
          BottomSheetItem(
            icon: Icons.report,
            label: 'Reportar Problema',
            onTap: () {
              Navigator.pop(context);
              // TODO: Implement report functionality
            },
          ),
        ],
      ),
    );
  }

  Future<void> _downloadMaterial(String type) async {
    try {
      await _lessonService.downloadMaterial(widget.lessonId, type);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Material baixado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao baixar material: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget _buildLessonContent() {
    return Builder(
      builder: (context) {
        final screenWidth = MediaQuery.of(context).size.width;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Player de vídeo/áudio
            StreamBuilder<PlaybackState>(
              stream: _lessonService.playbackStream,
              initialData: PlaybackState(),
              builder: (context, snapshot) {
                final playbackState = snapshot.data!;
                return Container(
                  height: screenWidth < 700 ? 220 : 320,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  decoration: BoxDecoration(
                    color: AyaColors.black50,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                    ),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/lesson1.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Overlay escuro
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.5),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(32),
                              bottomRight: Radius.circular(32),
                            ),
                          ),
                        ),
                      ),
                      // Controles do player
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(
                                playbackState.isPlaying
                                    ? Icons.pause
                                    : Icons.play_circle_fill,
                                color: const Color(0xFFACA1EF),
                                size: 64,
                              ),
                              onPressed: () {
                                if (playbackState.isPlaying) {
                                  _lessonService.pause(widget.lessonId);
                                } else {
                                  _lessonService.play(widget.lessonId);
                                }
                              },
                            ),
                            const SizedBox(height: 16),
                            // Barra de progresso
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 32),
                              child: Column(
                                children: [
                                  Slider(
                                    value: playbackState
                                        .currentPosition.inSeconds
                                        .toDouble(),
                                    min: 0,
                                    max: playbackState.duration.inSeconds
                                        .toDouble(),
                                    activeColor: const Color(0xFFACA1EF),
                                    inactiveColor: AyaColors.white40,
                                    onChanged: (value) {
                                      _lessonService.seekTo(
                                        widget.lessonId,
                                        Duration(seconds: value.toInt()),
                                      );
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          _formatDuration(
                                              playbackState.currentPosition),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          _formatDuration(
                                              playbackState.duration),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            // Barra de ações
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildActionButton(Icons.favorite_border, 'Favoritar'),
                  _buildActionButton(Icons.share, 'Compartilhar'),
                  _buildActionButton(Icons.download, 'Download'),
                ],
              ),
            ),
            const SizedBox(height: 18),
            // Seção de comentários
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Comentários',
                    style: TextStyle(
                      color: Color(0xFFF8F8FF),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildCommentInput(),
                  const SizedBox(height: 16),
                  _buildCommentList(),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        );
      },
    );
  }

  Widget _buildNavigationButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ElevatedButton.icon(
        onPressed: () => _handleNextLessonNavigation(widget.lessonId),
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
    );
  }

  Future<void> _handleNextLessonNavigation(String lessonId) async {
    try {
      final nextLessonId = await _lessonService.getNextLessonId(lessonId);
      if (!mounted) return;
      if (nextLessonId != null) {
        _showNextLessonSnackBar();
      }
    } catch (e) {
      if (!mounted) return;
      _showErrorSnackBar('Erro ao carregar próxima aula: $e');
    }
  }

  void _showNextLessonSnackBar() {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Carregando próxima aula...'),
        duration: Duration(seconds: 2),
        backgroundColor: AyaColors.primary,
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    if (label == 'Download') {
      return StreamBuilder<double>(
        stream: _lessonService.getDownloadProgress(widget.lessonId),
        builder: (context, snapshot) {
          final progress = snapshot.data ?? 0.0;
          return FutureBuilder<bool>(
            future: _lessonService.isLessonDownloaded(widget.lessonId),
            builder: (context, snap) {
              final isDownloaded = snap.data ?? false;
              if (progress > 0 && progress < 1) {
                // Baixando
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AyaColors.primary.withAlpha(30),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CircularProgressIndicator(
                              value: progress,
                              strokeWidth: 2,
                              color: AyaColors.primary,
                            ),
                            IconButton(
                              icon: const Icon(Icons.close,
                                  size: 16, color: AyaColors.primary),
                              onPressed: _cancelDownload,
                              tooltip: 'Cancelar download',
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text('Baixando',
                        style: TextStyle(
                            color: AyaColors.textPrimary, fontSize: 13)),
                  ],
                );
              } else if (isDownloaded) {
                // Baixado
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.green.withAlpha(30),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.check_circle,
                            color: Colors.green, size: 22),
                        onPressed: _removeDownloadedLesson,
                        tooltip: 'Remover download',
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text('Baixado',
                        style: TextStyle(color: Colors.green, fontSize: 13)),
                  ],
                );
              } else {
                // Não baixado
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AyaColors.primary.withAlpha(30),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.download,
                            color: AyaColors.primary, size: 22),
                        onPressed: _downloadLesson,
                        tooltip: 'Baixar aula',
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text('Download',
                        style: TextStyle(
                            color: AyaColors.textPrimary, fontSize: 13)),
                  ],
                );
              }
            },
          );
        },
      );
    }
    // Favoritar e Compartilhar permanecem iguais
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AyaColors.primary.withAlpha(30),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: Icon(icon, color: AyaColors.primary, size: 22),
            onPressed: () {
              switch (label) {
                case 'Favoritar':
                  _lessonService.toggleFavorite(widget.lessonId);
                  break;
                case 'Compartilhar':
                  _shareLesson();
                  break;
              }
            },
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
            color: AyaColors.textPrimary,
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  Widget _buildCommentInput() {
    return Row(
      children: [
        const CircleAvatar(
          backgroundImage: AssetImage('assets/images/user1.jpg'),
          radius: 18,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: _commentController,
            decoration: InputDecoration(
              hintText: 'Faça um comentário...',
              filled: true,
              fillColor: AyaColors.lavenderSoft30,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
            onSubmitted: (text) {
              if (text.isNotEmpty) {
                _lessonService.addComment(widget.lessonId, text);
                _commentController.clear();
              }
            },
          ),
        ),
        IconButton(
          icon: const Icon(Icons.send, color: AyaColors.primary),
          onPressed: () {
            final text = _commentController.text;
            if (text.isNotEmpty) {
              _lessonService.addComment(widget.lessonId, text);
              _commentController.clear();
            }
          },
        ),
      ],
    );
  }

  Widget _buildCommentList() {
    return StreamBuilder<List<Comment>>(
      stream: _lessonService.commentsStream,
      initialData: const [],
      builder: (context, snapshot) {
        final comments = snapshot.data!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: comments
              .map((comment) => _CommentCard(
                    comment: comment,
                    onLike: () => _lessonService.toggleLikeComment(
                        widget.lessonId, comment.id),
                    onReply: (text) => _lessonService.replyToComment(
                        widget.lessonId, comment.id, text),
                  ))
              .toList(),
        );
      },
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  Future<void> _shareLesson() async {
    try {
      await _lessonService.shareLesson(widget.lessonId);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Aula compartilhada com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao compartilhar aula: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _downloadLesson() async {
    if (!mounted) return;
    final messenger = ScaffoldMessenger.of(context);

    try {
      await _lessonService.downloadLesson(
        widget.lessonId,
        moduleId: 'default-module',
        fileName: '${widget.lessonId}.mp4',
        fileType: 'video/mp4',
      );

      if (!mounted) return;
      messenger.showSnackBar(
        const SnackBar(
          content: Text('Aula baixada com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      messenger.showSnackBar(
        SnackBar(
          content: Text('Erro ao baixar aula: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _cancelDownload() async {
    try {
      await _lessonService.cancelDownload(widget.lessonId);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Download cancelado'),
          backgroundColor: Colors.orange,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao cancelar download: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _removeDownloadedLesson() async {
    try {
      await _lessonService.removeDownloadedLesson(widget.lessonId);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Aula removida com sucesso'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao remover aula: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
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
          style: const TextStyle(color: AyaColors.textPrimary, fontSize: 15),
          maxLines: maxLines,
          overflow: expanded ? TextOverflow.visible : TextOverflow.ellipsis,
        ),
        if (widget.text.length > 120)
          TextButton(
            onPressed: () => setState(() => expanded = !expanded),
            style: TextButton.styleFrom(
              foregroundColor: AyaColors.primary,
              textStyle: const TextStyle(fontWeight: FontWeight.bold),
            ),
            child: Text(expanded ? 'Ver menos' : 'Ver mais'),
          ),
      ],
    );
  }
}

class _CommentCard extends StatelessWidget {
  final Comment comment;
  final VoidCallback onLike;
  final Function(String) onReply;

  const _CommentCard({
    required this.comment,
    required this.onLike,
    required this.onReply,
  });

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
              backgroundImage: AssetImage(comment.userAvatar),
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
                        comment.userName,
                        style: const TextStyle(
                          color: Color(0xFFF8F8FF),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        comment.timeAgo,
                        style: const TextStyle(
                          color: Color(0xFFACA1EF),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    comment.text,
                    style: const TextStyle(
                      color: Color(0xFFF8F8FF),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          comment.isLiked
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: comment.isLiked
                              ? AyaColors.primary
                              : const Color(0xFFACA1EF),
                          size: 18,
                        ),
                        onPressed: onLike,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${comment.likes}',
                        style: TextStyle(
                          color: comment.isLiked
                              ? AyaColors.primary
                              : const Color(0xFFACA1EF),
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(width: 16),
                      TextButton(
                        onPressed: () {
                          final controller = TextEditingController();
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Responder comentário'),
                              content: TextField(
                                controller: controller,
                                decoration: const InputDecoration(
                                  hintText: 'Digite sua resposta...',
                                ),
                                maxLines: 3,
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Cancelar'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    final text = controller.text;
                                    if (text.isNotEmpty) {
                                      onReply(text);
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: const Text('Responder'),
                                ),
                              ],
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: const Color(0xFF78C7B4),
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13),
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text('Responder'),
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
