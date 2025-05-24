import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/glassmorphism.dart';
import '../models/lesson.dart';
import 'lesson_page.dart';
// TODO: Implement custom icons
// import '../../../core/theme/aya_icons.dart';
import '../../../widgets/aya_premium_icon.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;

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
    Widget iconoirIcon;
    switch (type) {
      case ContentType.video:
        iconoirIcon = const iconoir.VideoCamera();
        break;
      case ContentType.audio:
        iconoirIcon = const iconoir.MusicDoubleNote();
        break;
      case ContentType.richText:
        iconoirIcon = const iconoir.Book();
        break;
      case ContentType.pdf:
        iconoirIcon = const iconoir.PageSearch();
        break;
      default:
        iconoirIcon = const iconoir.Filter();
    }
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
                  ? AyaColors.lavenderVibrant.withValues(alpha: 0.12)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isSelected
                    ? AyaColors.lavenderVibrant
                    : AyaColors.textPrimary40,
                width: 1.5,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AyaPremiumIcon(
                  customIcon: iconoirIcon,
                  isActive: isSelected,
                  size: 18,
                  borderRadius: 12,
                  padding: const EdgeInsets.all(2),
                ),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: isSelected
                            ? AyaColors.lavenderVibrant
                            : AyaColors.textPrimary,
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
    Widget iconoirIcon;
    switch (lesson.contentType) {
      case ContentType.video:
        iconoirIcon = const iconoir.VideoCamera();
        break;
      case ContentType.audio:
        iconoirIcon = const iconoir.MusicDoubleNote();
        break;
      case ContentType.richText:
        iconoirIcon = const iconoir.Book();
        break;
      case ContentType.pdf:
        iconoirIcon = const iconoir.PageSearch();
        break;
      default:
        iconoirIcon = const iconoir.Book();
    }
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
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
                      color: AyaColors.lavenderVibrant,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  height: 200,
                  color: AyaColors.lavenderSoft,
                  child: AyaPremiumIcon(
                    customIcon: iconoir.Book(),
                    size: 48,
                    borderRadius: 16,
                    padding: const EdgeInsets.all(8),
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
                      AyaPremiumIcon(
                        customIcon: iconoirIcon,
                        isActive: lesson.isPremium,
                        size: 18,
                        borderRadius: 12,
                        padding: const EdgeInsets.all(2),
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
                            color: AyaColors.lavenderVibrant
                                .withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              AyaPremiumIcon(
                                customIcon: const iconoir.Crown(),
                                isActive: true,
                                size: 16,
                                borderRadius: 8,
                                padding: EdgeInsets.all(2),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Premium',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: AyaColors.lavenderVibrant,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ],
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
                        customIcon: const iconoir.Clock(),
                        text: lesson.duration,
                      ),
                      const SizedBox(width: 16),
                      _buildMetadataItem(
                        customIcon: const iconoir.User(),
                        text: '${lesson.studentsCount} alunos',
                      ),
                      const Spacer(),
                      AyaPremiumIcon(
                        customIcon: const iconoir.ArrowRight(),
                        size: 16,
                        borderRadius: 8,
                        padding: EdgeInsets.all(2),
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
    IconData? icon,
    Widget? customIcon,
    required String text,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AyaPremiumIcon(
          icon: icon,
          customIcon: customIcon,
          size: 16,
          borderRadius: 8,
          padding: EdgeInsets.all(2),
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
