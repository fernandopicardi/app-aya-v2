import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/theme/app_theme.dart';
import '../widgets/aya_video_player.dart';
import '../widgets/aya_audio_player.dart';
import '../widgets/aya_rich_text_viewer.dart';
import '../widgets/aya_pdf_viewer.dart';
import '../models/lesson.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AyaColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AyaColors.textPrimary,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.lesson.title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AyaColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isLiked ? Icons.favorite : Icons.favorite_border,
              color: _isLiked ? AyaColors.turquoise : AyaColors.textPrimary,
            ),
            onPressed: () {
              setState(() => _isLiked = !_isLiked);
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.more_vert,
              color: AyaColors.textPrimary,
            ),
            onPressed: () {
              _showMoreOptions(context);
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          // Content Player/Viewer
          _buildContentPlayer(),

          // Lesson Info
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  widget.lesson.title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
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
                const SizedBox(height: 16),

                // Description
                Text(
                  widget.lesson.description,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AyaColors.textPrimary,
                        height: 1.5,
                      ),
                  maxLines: _isDescriptionExpanded ? null : 3,
                  overflow: _isDescriptionExpanded
                      ? TextOverflow.visible
                      : TextOverflow.ellipsis,
                ),
                if (widget.lesson.description.length > 150)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isDescriptionExpanded = !_isDescriptionExpanded;
                      });
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: AyaColors.turquoise,
                      padding: EdgeInsets.zero,
                    ),
                    child:
                        Text(_isDescriptionExpanded ? 'Ler menos' : 'Ler mais'),
                  ),
                const SizedBox(height: 24),

                // Quick Actions
                _buildQuickActions(),
                const SizedBox(height: 24),

                // Complementary Materials
                if (widget.lesson.complementaryMaterials.isNotEmpty)
                  _buildComplementaryMaterials(),
                const SizedBox(height: 24),

                // Next Lesson
                if (widget.lesson.nextLesson != null) _buildNextLesson(),
                const SizedBox(height: 24),

                // Comments Section
                _buildCommentsSection(),
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
        Icon(
          icon,
          size: 16,
          color: AyaColors.textPrimary60,
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

  Widget _buildQuickActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildQuickActionButton(
          icon: Icons.favorite_border,
          label: 'Curtir',
          onTap: () {
            setState(() => _isLiked = !_isLiked);
          },
        ),
        _buildQuickActionButton(
          icon: Icons.playlist_add_outlined,
          label: 'Salvar',
          onTap: () {
            // TODO: Implement save to playlist
          },
        ),
        _buildQuickActionButton(
          icon: Icons.edit_note_outlined,
          label: 'Anotações',
          onTap: () {
            // TODO: Show notes bottom sheet
          },
        ),
        _buildQuickActionButton(
          icon: _isCompleted ? Icons.check_circle : Icons.check_circle_outline,
          label: 'Concluir',
          onTap: () {
            setState(() => _isCompleted = !_isCompleted);
          },
        ),
      ],
    );
  }

  Widget _buildQuickActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: AyaColors.textPrimary,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AyaColors.textPrimary60,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComplementaryMaterials() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Materiais para Download',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AyaColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        ...widget.lesson.complementaryMaterials.map((material) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AyaColors.lavenderSoft,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  _getFileTypeIcon(material.fileType),
                  color: AyaColors.textPrimary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        material.name,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: AyaColors.textPrimary,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      if (material.size != null)
                        Text(
                          material.size!,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AyaColors.textPrimary60,
                                  ),
                        ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.download_outlined,
                    color: AyaColors.turquoise,
                  ),
                  onPressed: () {
                    // TODO: Implement download
                  },
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildNextLesson() {
    final nextLesson = widget.lesson.nextLesson!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Próxima Aula',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AyaColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LessonPage(lesson: nextLesson),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: AyaColors.lavenderSoft,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(12),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: nextLesson.thumbnailUrl,
                    width: 120,
                    height: 80,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: AyaColors.lavenderSoft,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: AyaColors.turquoise,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: AyaColors.lavenderSoft,
                      child: const Icon(
                        Icons.image_not_supported,
                        color: AyaColors.textPrimary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nextLesson.title,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
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
                            nextLesson.duration,
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AyaColors.textPrimary60,
                                    ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: AyaColors.textPrimary60,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCommentsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Comentários',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AyaColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        // TODO: Implement comments list
        const Center(
          child: Text('Comentários em desenvolvimento'),
        ),
      ],
    );
  }

  void _showMoreOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AyaColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
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
        return Icons.play_circle_outline;
      case ContentType.audio:
        return Icons.headphones_outlined;
      case ContentType.richText:
        return Icons.article_outlined;
      case ContentType.pdf:
        return Icons.picture_as_pdf_outlined;
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
}
