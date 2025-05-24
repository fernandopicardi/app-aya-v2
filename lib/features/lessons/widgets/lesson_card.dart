import 'package:flutter/material.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import '../models/lesson.dart';
import '../screens/lesson_page.dart';
import '../../../core/theme/app_theme.dart';
import '../../../widgets/aya_premium_icon.dart';

class LessonCard extends StatelessWidget {
  final Lesson lesson;

  const LessonCard({
    super.key,
    required this.lesson,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        iconTheme: const IconThemeData(
          color: AyaColors.textPrimary60,
          size: 16,
        ),
      ),
      child: Card(
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
                        const SizedBox(width: 16),
                        _buildCategoryTag(lesson.category),
                        const Spacer(),
                        _buildPointsTag(lesson.points),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
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
        AyaPremiumIcon(
          customIcon: icon,
          size: 16,
          borderRadius: 8,
          padding: const EdgeInsets.all(2),
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            color: AyaColors.textPrimary60,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryTag(LessonCategory category) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getCategoryColor(category).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _getCategoryColor(category).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Text(
        _getCategoryText(category),
        style: TextStyle(
          color: _getCategoryColor(category),
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildPointsTag(int points) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AyaColors.turquoise.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AyaColors.turquoise.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AyaPremiumIcon(
            customIcon: const Icon(Icons.stars),
            size: 14,
            borderRadius: 7,
            padding: const EdgeInsets.all(2),
            isActive: true,
          ),
          const SizedBox(width: 4),
          Text(
            '$points pts',
            style: const TextStyle(
              color: AyaColors.turquoise,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(LessonCategory category) {
    switch (category) {
      case LessonCategory.meditation:
        return AyaColors.lavenderVibrant;
      case LessonCategory.nutrition:
        return AyaColors.turquoise;
      case LessonCategory.healing:
        return Colors.purple;
      case LessonCategory.ayurveda:
        return Colors.orange;
      case LessonCategory.mindfulness:
        return Colors.blue;
      case LessonCategory.spirituality:
        return Colors.indigo;
      case LessonCategory.yoga:
        return Colors.green;
      case LessonCategory.wellness:
        return Colors.teal;
    }
  }

  String _getCategoryText(LessonCategory category) {
    switch (category) {
      case LessonCategory.meditation:
        return 'Meditação';
      case LessonCategory.nutrition:
        return 'Alimentação';
      case LessonCategory.healing:
        return 'Healing';
      case LessonCategory.ayurveda:
        return 'Ayurveda';
      case LessonCategory.mindfulness:
        return 'Mindfulness';
      case LessonCategory.spirituality:
        return 'Espiritualidade';
      case LessonCategory.yoga:
        return 'Yoga';
      case LessonCategory.wellness:
        return 'Bem-estar';
    }
  }

  Widget _getContentTypeIcon() {
    return switch (lesson.contentType) {
      ContentType.video => const iconoir.VideoCamera(),
      ContentType.audio => const iconoir.MusicDoubleNote(),
      ContentType.richText => const iconoir.Book(),
      ContentType.pdf => const iconoir.PageSearch(),
    };
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
    }
  }
}
