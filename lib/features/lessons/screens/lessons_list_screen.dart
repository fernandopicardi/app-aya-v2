import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/glassmorphism.dart';
import '../models/lesson.dart';
import 'lesson_page.dart';

class LessonsListScreen extends StatefulWidget {
  const LessonsListScreen({super.key});

  @override
  State<LessonsListScreen> createState() => _LessonsListScreenState();
}

class _LessonsListScreenState extends State<LessonsListScreen> {
  ContentType? _selectedFilter;
  final List<Lesson> _lessons = Lesson.getMockLessons();

  List<Lesson> get _filteredLessons {
    if (_selectedFilter == null) return _lessons;
    return _lessons
        .where((lesson) => lesson.contentType == _selectedFilter)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AyaColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Biblioteca de Conteúdo',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AyaColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              color: AyaColors.textPrimary,
            ),
            onPressed: () {
              // TODO: Implementar busca
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Filtros
          Glassmorphism(
            borderRadius: 0,
            blurRadius: 10,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Container(
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildFilterChip(null, 'Todos'),
                  _buildFilterChip(ContentType.video, 'Vídeos'),
                  _buildFilterChip(ContentType.audio, 'Áudios'),
                  _buildFilterChip(ContentType.richText, 'Artigos'),
                  _buildFilterChip(ContentType.pdf, 'PDFs'),
                ],
              ),
            ),
          ),

          // Lista de Lições
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _filteredLessons.length,
              itemBuilder: (context, index) {
                final lesson = _filteredLessons[index];
                return _buildLessonCard(lesson);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(ContentType? type, String label) {
    final isSelected = _selectedFilter == type;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedFilter = type;
          });
        },
        child: Glassmorphism(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected
                  ? AyaColors.turquoise.withOpacity(0.2)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected ? AyaColors.turquoise : AyaColors.glassBorder,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _getContentTypeIcon(type),
                  size: 16,
                  color: isSelected
                      ? AyaColors.turquoise
                      : AyaColors.textPrimary60,
                ),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: isSelected
                            ? AyaColors.turquoise
                            : AyaColors.textPrimary60,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLessonCard(Lesson lesson) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LessonPage(lesson: lesson),
          ),
        );
      },
      child: Glassmorphism(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              child: CachedNetworkImage(
                imageUrl: lesson.thumbnailUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  height: 200,
                  color: AyaColors.lavenderSoft,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: AyaColors.turquoise,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  height: 200,
                  color: AyaColors.lavenderSoft,
                  child: const Icon(
                    Icons.image_not_supported,
                    color: AyaColors.textPrimary,
                    size: 48,
                  ),
                ),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        _getContentTypeIcon(lesson.contentType),
                        size: 16,
                        color: AyaColors.turquoise,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _getContentTypeLabel(lesson.contentType),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AyaColors.textPrimary60,
                            ),
                      ),
                      const Spacer(),
                      if (lesson.isPremium)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AyaColors.turquoise.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Premium',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AyaColors.turquoise,
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    lesson.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AyaColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    lesson.description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AyaColors.textPrimary60,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _buildMetadataItem(
                        icon: Icons.access_time,
                        text: lesson.duration,
                      ),
                      const SizedBox(width: 16),
                      _buildMetadataItem(
                        icon: Icons.people,
                        text: '${lesson.studentsCount} alunos',
                      ),
                      const Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: AyaColors.textPrimary60,
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

  IconData _getContentTypeIcon(ContentType? type) {
    switch (type) {
      case ContentType.video:
        return Icons.play_circle_outline;
      case ContentType.audio:
        return Icons.headphones;
      case ContentType.richText:
        return Icons.article;
      case ContentType.pdf:
        return Icons.picture_as_pdf;
      default:
        return Icons.library_books;
    }
  }

  String _getContentTypeLabel(ContentType type) {
    switch (type) {
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
}
