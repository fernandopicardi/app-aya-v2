import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../models/lesson.dart';
import '../widgets/lesson_card.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import '../../../widgets/aya_premium_icon.dart';

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
          // Filter chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                _buildFilterChip(
                  label: 'Todos',
                  icon: const iconoir.Filter(),
                  isSelected: _selectedFilter == null,
                  onTap: () {
                    setState(() {
                      _selectedFilter = null;
                    });
                  },
                ),
                const SizedBox(width: 8),
                _buildFilterChip(
                  label: 'Vídeos',
                  icon: const iconoir.VideoCamera(),
                  isSelected: _selectedFilter == ContentType.video,
                  onTap: () {
                    setState(() {
                      _selectedFilter = ContentType.video;
                    });
                  },
                ),
                const SizedBox(width: 8),
                _buildFilterChip(
                  label: 'Áudios',
                  icon: const iconoir.MusicDoubleNote(),
                  isSelected: _selectedFilter == ContentType.audio,
                  onTap: () {
                    setState(() {
                      _selectedFilter = ContentType.audio;
                    });
                  },
                ),
                const SizedBox(width: 8),
                _buildFilterChip(
                  label: 'Textos',
                  icon: const iconoir.Book(),
                  isSelected: _selectedFilter == ContentType.richText,
                  onTap: () {
                    setState(() {
                      _selectedFilter = ContentType.richText;
                    });
                  },
                ),
                const SizedBox(width: 8),
                _buildFilterChip(
                  label: 'PDFs',
                  icon: const iconoir.PageSearch(),
                  isSelected: _selectedFilter == ContentType.pdf,
                  onTap: () {
                    setState(() {
                      _selectedFilter = ContentType.pdf;
                    });
                  },
                ),
              ],
            ),
          ),

          // Lessons list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _filteredLessons.length,
              itemBuilder: (context, index) {
                final lesson = _filteredLessons[index];
                if (_selectedFilter != null &&
                    lesson.contentType != _selectedFilter) {
                  return const SizedBox.shrink();
                }
                return LessonCard(lesson: lesson);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required Widget icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? AyaColors.lavenderVibrant.withValues(alpha: 0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected
                  ? AyaColors.lavenderVibrant
                  : AyaColors.textPrimary.withValues(alpha: 0.1),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AyaPremiumIcon(
                customIcon: icon,
                size: 18,
                borderRadius: 9,
                padding: const EdgeInsets.all(2),
                isActive: isSelected,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: isSelected
                      ? AyaColors.lavenderVibrant
                      : AyaColors.textPrimary60,
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
