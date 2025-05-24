import 'package:flutter/material.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import '../models/lesson.dart';
import '../screens/lesson_page.dart';

class LessonCard extends StatelessWidget {
  final Lesson lesson;

  const LessonCard({
    super.key,
    required this.lesson,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => LessonPage(lesson: lesson),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: Stack(
                children: [
                  Image.network(
                    lesson.thumbnailUrl,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 200,
                        color: Colors.grey[300],
                        child: const Icon(Icons.error),
                      );
                    },
                  ),
                  if (lesson.isPremium)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.star,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    lesson.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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
                        icon: const iconoir.Clock(),
                        text: lesson.duration,
                      ),
                      if (lesson.difficulty != null) ...[
                        const SizedBox(width: 16),
                        _buildMetadataItem(
                          icon: const iconoir.Star(),
                          text: _getDifficultyText(lesson.difficulty!),
                        ),
                      ],
                      const Spacer(),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey,
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
    required Widget icon,
    required String text,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        icon,
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _getContentTypeIcon() {
    switch (lesson.contentType) {
      case ContentType.video:
        return const iconoir.VideoCamera();
      case ContentType.audio:
        return const iconoir.MusicDoubleNote();
      case ContentType.richText:
        return const iconoir.Book();
      case ContentType.pdf:
        return const iconoir.PageSearch();
      default:
        return const iconoir.Book();
    }
  }

  String _getContentTypeText() {
    switch (lesson.contentType) {
      case ContentType.video:
        return 'Vídeo';
      case ContentType.audio:
        return 'Áudio';
      case ContentType.richText:
        return 'Texto';
      case ContentType.pdf:
        return 'PDF';
      default:
        return 'Texto';
    }
  }

  String _getDifficultyText(LessonDifficulty difficulty) {
    switch (difficulty) {
      case LessonDifficulty.beginner:
        return 'Iniciante';
      case LessonDifficulty.intermediate:
        return 'Intermediário';
      case LessonDifficulty.advanced:
        return 'Avançado';
    }
  }
}
