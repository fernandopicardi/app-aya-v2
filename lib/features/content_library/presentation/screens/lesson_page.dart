import 'package:flutter/material.dart';
import '../../domain/entities/content_item.dart'; // Corrected path
import '../widgets/video_player_widget.dart';
import '../widgets/pdf_viewer_widget.dart';
// import 'package:app/core/theme/app_colors.dart';
// import 'package:app/core/theme/app_typography.dart';
// import 'package:app/core/theme/app_dimensions.dart';

class LessonPage extends StatelessWidget {
  final ContentItem contentItem;

  const LessonPage({
    super.key,
    required this.contentItem,
  });

  @override
  Widget build(BuildContext context) {
    // final textTheme = Theme.of(context).textTheme;
    // final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(contentItem.title),
      ),
      body: Padding(
        // padding: const EdgeInsets.all(AppDimensions.spacingMd), // Example from theme
        padding: const EdgeInsets.all(16.0), // Placeholder padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main Content Viewer Area
            Expanded(
              child: _buildContentViewer(context), // Pass context if needed by viewers
            ),

            // Interactive Elements Area
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: const Center(
                child: Text(
                  'Interactive Elements Area (Like, Favorite, Annotations, etc.)',
                  // style: textTheme.bodyMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentViewer(BuildContext context) {
    final String? urlToUse = contentItem.contentUrl;

    if (urlToUse == null || urlToUse.isEmpty) {
      return const Center(child: Text('No content URL provided.', style: TextStyle(color: Colors.red)));
    }

    switch (contentItem.type.toLowerCase()) { // Added toLowerCase for robustness
      case 'video':
        return VideoPlayerWidget(videoUrl: urlToUse);
      case 'pdf':
        return PdfViewerWidget(pdfUrl: urlToUse);
      // Add cases for 'audio' and 'article' later
      default:
        return Center(
          child: Text(
            'Unsupported content type: ${contentItem.type}\nSource: $urlToUse', // More specific message
            textAlign: TextAlign.center,
            // style: Theme.of(context).textTheme.bodyLarge,
          ),
        );
    }
  }
}
