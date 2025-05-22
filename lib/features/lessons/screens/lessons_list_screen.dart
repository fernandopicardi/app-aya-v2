import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/theme/app_theme.dart';
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
          Container(
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
      child: FilterChip(
        selected: isSelected,
        label: Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: isSelected ? AyaColors.surface : AyaColors.textPrimary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
        ),
        backgroundColor: AyaColors.lavenderSoft,
        selectedColor: AyaColors.turquoise,
        checkmarkColor: AyaColors.surface,
        onSelected: (selected) {
          setState(() {
            _selectedFilter = selected ? type : null;
          });
        },
      ),
    );
  }

  Widget _buildLessonCard(Lesson lesson) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: AyaColors.surface,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LessonPage(lesson: lesson),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
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
                  // Title and Type
                  Row(
                    children: [
                      Icon(
                        _getContentTypeIcon(lesson.contentType),
                        size: 20,
                        color: AyaColors.turquoise,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _getContentTypeText(lesson.contentType),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AyaColors.textPrimary60,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    lesson.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AyaColors.textPrimary,
                          fontWeight: FontWeight.bold,
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

                  // Metadata
                  Row(
                    children: [
                      Icon(
                        Icons.timer_outlined,
                        size: 16,
                        color: AyaColors.textPrimary60,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        lesson.duration,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AyaColors.textPrimary60,
                            ),
                      ),
                      if (lesson.difficulty != null) ...[
                        const SizedBox(width: 16),
                        Icon(
                          Icons.signal_cellular_alt_outlined,
                          size: 16,
                          color: AyaColors.textPrimary60,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          lesson.difficulty!,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AyaColors.textPrimary60,
                                  ),
                        ),
                      ],
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

  IconData _getContentTypeIcon(ContentType type) {
    switch (type) {
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

  String _getContentTypeText(ContentType type) {
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
