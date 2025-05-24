import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
// TODO: Implement custom icons
// import '../../../core/theme/aya_icons.dart';
import '../../../widgets/aya_premium_icon.dart';
import '../widgets/aya_video_player.dart';
import '../widgets/aya_audio_player.dart';
import '../widgets/aya_rich_text_viewer.dart';
import '../widgets/aya_pdf_viewer.dart';
import '../models/lesson.dart';
// TODO: Implement iconoir icons
// import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;

class LessonPage extends StatefulWidget {
  final Lesson lesson;

  const LessonPage({
    super.key,
    required this.lesson,
  });

  @override
  State<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  bool _isDescriptionExpanded = false;
  bool _isLiked = false;
  bool _isCompleted = false;
  bool _isSaved = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AyaColors.background,
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            backgroundColor: AyaColors.surface.withAlpha(217), // 85% opacity
            elevation: 0,
            pinned: true,
            title: Text(
              widget.lesson.title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AyaColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: AyaColors.textPrimary,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  _isLiked ? Icons.favorite : Icons.favorite_border,
                  color: _isLiked ? AyaColors.turquoise : AyaColors.textPrimary,
                ),
                onPressed: () {
                  setState(() {
                    _isLiked = !_isLiked;
                  });
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.more_vert,
                  color: AyaColors.textPrimary,
                ),
                onPressed: _showOptions,
              ),
            ],
          ),

          // Content
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Content Player
                _buildContentPlayer(),
                const SizedBox(height: 24),

                // Title and Metadata Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        widget.lesson.title,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              color: AyaColors.textPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 16),

                      // Metadata
                      Row(
                        children: [
                          _buildMetadataItem(
                            icon: _getContentTypeIcon(),
                            text: _getContentTypeText(),
                          ),
                          const SizedBox(width: 16),
                          _buildMetadataItem(
                            icon: Icons.timer_outlined,
                            text: widget.lesson.duration,
                          ),
                          if (widget.lesson.difficulty != null) ...[
                            const SizedBox(width: 16),
                            _buildMetadataItem(
                              icon: Icons.signal_cellular_alt_outlined,
                              text: widget.lesson.difficulty!,
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Description with "Read More" functionality
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.lesson.description,
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: AyaColors.textPrimary80,
                                    ),
                            maxLines: _isDescriptionExpanded ? null : 3,
                            overflow: _isDescriptionExpanded
                                ? null
                                : TextOverflow.ellipsis,
                          ),
                          if (widget.lesson.description.length > 150)
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _isDescriptionExpanded =
                                      !_isDescriptionExpanded;
                                });
                              },
                              child: Text(
                                _isDescriptionExpanded
                                    ? 'Mostrar menos'
                                    : 'Ler mais',
                                style:
                                    const TextStyle(color: AyaColors.turquoise),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Action Bar
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: AyaColors.lavenderSoft30,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AyaColors.textPrimary40,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildActionButton(
                              icon: _isLiked
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              label: 'Curtir',
                              isActive: _isLiked,
                              onTap: () {
                                setState(() {
                                  _isLiked = !_isLiked;
                                });
                              },
                            ),
                            _buildActionButton(
                              icon: _isSaved
                                  ? Icons.bookmark
                                  : Icons.bookmark_border,
                              label: 'Salvar',
                              isActive: _isSaved,
                              onTap: () {
                                setState(() {
                                  _isSaved = !_isSaved;
                                });
                              },
                            ),
                            _buildActionButton(
                              icon: Icons.note_alt_outlined,
                              label: 'Anotações',
                              onTap: () {
                                // TODO: Implement notes
                              },
                            ),
                            _buildActionButton(
                              icon: _isCompleted
                                  ? Icons.check_circle
                                  : Icons.check_circle_outline,
                              label: 'Concluir',
                              isActive: _isCompleted,
                              onTap: () {
                                setState(() {
                                  _isCompleted = !_isCompleted;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Comments Section Placeholder
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AyaColors.lavenderSoft30,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AyaColors.textPrimary40,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.chat_bubble_outline,
                                  color: AyaColors.textPrimary,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Comentários',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        color: AyaColors.textPrimary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            const Center(
                              child: Text(
                                'Comentários em desenvolvimento',
                                style: TextStyle(
                                  color: AyaColors.textPrimary60,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Complementary Materials
                      if (widget.lesson.complementaryMaterials.isNotEmpty) ...[
                        Text(
                          'Materiais Complementares',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: AyaColors.textPrimary,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 16),
                        ...widget.lesson.complementaryMaterials.map((material) {
                          return Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            color: AyaColors.lavenderSoft30,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(
                                color: AyaColors.textPrimary40,
                              ),
                            ),
                            child: ListTile(
                              leading: Icon(
                                _getFileTypeIcon(material.fileType),
                                color: AyaColors.textPrimary,
                              ),
                              title: Text(
                                material.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      color: AyaColors.textPrimary,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              subtitle: material.size != null
                                  ? Text(
                                      material.size!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: AyaColors.textPrimary60,
                                          ),
                                    )
                                  : null,
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.download_outlined,
                                  color: AyaColors.turquoise,
                                ),
                                onPressed: () {
                                  // TODO: Implement download
                                },
                              ),
                            ),
                          );
                        }),
                      ],

                      // Next Lesson
                      if (widget.lesson.nextLesson != null) ...[
                        const SizedBox(height: 24),
                        Text(
                          'Próxima Aula',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: AyaColors.textPrimary,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 16),
                        Card(
                          color: AyaColors.lavenderSoft30,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                              color: AyaColors.textPrimary40,
                            ),
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LessonPage(
                                      lesson: widget.lesson.nextLesson!),
                                ),
                              );
                            },
                            borderRadius: BorderRadius.circular(12),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  Icon(
                                    _getContentTypeIcon(),
                                    color: AyaColors.turquoise,
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.lesson.nextLesson!.title,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(
                                                color: AyaColors.textPrimary,
                                                fontWeight: FontWeight.w500,
                                              ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Icon(
                                              _getContentTypeIcon(),
                                              size: 16,
                                              color: AyaColors.textPrimary60,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              widget
                                                  .lesson.nextLesson!.duration,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(
                                                    color:
                                                        AyaColors.textPrimary60,
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
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentPlayer() {
    switch (widget.lesson.contentType) {
      case ContentType.video:
        return AyaVideoPlayer(
          videoUrl: widget.lesson.contentUrl,
          thumbnailUrl: widget.lesson.thumbnailUrl,
        );
      case ContentType.audio:
        return AyaAudioPlayer(
          audioUrl: widget.lesson.contentUrl,
          thumbnailUrl: widget.lesson.thumbnailUrl,
        );
      case ContentType.richText:
        return AyaRichTextViewer(
          content: widget.lesson.contentUrl,
        );
      case ContentType.pdf:
        return AyaPdfViewer(
          pdfUrl: widget.lesson.contentUrl,
        );
    }
  }

  Widget _buildMetadataItem({
    required IconData icon,
    required String text,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AyaPremiumIcon(
          icon: icon,
          size: 16,
          borderRadius: 8,
          padding: const EdgeInsets.all(4),
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AyaColors.textPrimary60,
              ),
        ),
      ],
    );
  }

  void _showOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(
                  Icons.share_outlined,
                  color: AyaColors.textPrimary,
                ),
                title: Text(
                  'Compartilhar Aula',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AyaColors.textPrimary,
                      ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Implement share
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.report_outlined,
                  color: AyaColors.textPrimary,
                ),
                title: Text(
                  'Reportar Problema',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AyaColors.textPrimary,
                      ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Implement report
                },
              ),
            ],
          ),
        );
      },
    );
  }

  IconData _getContentTypeIcon() {
    switch (widget.lesson.contentType) {
      case ContentType.video:
        return Icons.videocam_outlined;
      case ContentType.audio:
        return Icons.audiotrack_outlined;
      case ContentType.richText:
        return Icons.article_outlined;
      case ContentType.pdf:
        return Icons.picture_as_pdf_outlined;
      default:
        return Icons.article_outlined;
    }
  }

  String _getContentTypeText() {
    switch (widget.lesson.contentType) {
      case ContentType.video:
        return 'Vídeo';
      case ContentType.audio:
        return 'Áudio';
      case ContentType.richText:
        return 'Artigo';
      case ContentType.pdf:
        return 'PDF';
      default:
        return 'Conteúdo';
    }
  }

  IconData _getFileTypeIcon(String fileType) {
    switch (fileType.toLowerCase()) {
      case 'pdf':
        return Icons.picture_as_pdf_outlined;
      case 'doc':
      case 'docx':
        return Icons.description_outlined;
      case 'xls':
      case 'xlsx':
        return Icons.table_chart_outlined;
      case 'ppt':
      case 'pptx':
        return Icons.slideshow_outlined;
      default:
        return Icons.insert_drive_file_outlined;
    }
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isActive = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AyaPremiumIcon(
              icon: icon,
              isActive: isActive,
              size: 22,
              borderRadius: 8,
              padding: const EdgeInsets.all(4),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isActive
                    ? AyaColors.lavenderVibrant
                    : AyaColors.textPrimary,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
