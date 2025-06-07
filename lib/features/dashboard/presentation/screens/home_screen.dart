import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:app/routes.dart';
import 'package:app/features/content_library/domain/entities/content_item.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_dimensions.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  final List<Map<String, dynamic>> mockModules = const [
    {
      'title': 'Meditação para Iniciantes',
      'items': [
        {'title': 'Meditação 1', 'description': 'Introdução à meditação'},
        {'title': 'Meditação 2', 'description': 'Técnicas básicas'},
      ],
    },
    {
      'title': 'Jornada do Autoconhecimento',
      'items': [
        {'title': 'Etapa 1', 'description': 'Autoconhecimento inicial'},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final ContentItem sampleVideo = ContentItem(
      id: 'vid1',
      title: 'Test Video Lesson (Bee)',
      description: 'A sample video about bees.',
      thumbnailUrl: '', // Placeholder, not used by LessonPage directly yet
      type: 'video',
      duration: '0:30',
      contentUrl: 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      isNew: true,
    );

    final ContentItem samplePdf = ContentItem(
      id: 'pdf1',
      title: 'Test PDF Lesson (Flutter Succinctly)',
      description: 'A sample PDF document.',
      thumbnailUrl: '', // Placeholder
      type: 'pdf',
      duration: '100 pages',
      contentUrl: 'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
      isPremium: true,
    );

    final ContentItem sampleInvalidVideo = ContentItem(
      id: 'vid_invalid',
      title: 'Test Invalid Video URL',
      description: 'An invalid video URL.',
      thumbnailUrl: '', // Placeholder
      type: 'video',
      duration: '1:00',
      contentUrl: 'https://example.com/nonexistent.mp4', // Intentionally invalid for testing
    );

    return Scaffold(
      body: ListView(
        children: [
          Padding( // Added Padding for the test buttons
            padding: const EdgeInsets.all(AppDimensions.spacingMd),
            child: Column(
              children: [
                ElevatedButton(
                  child: const Text('Go to Test Video Lesson (Bee)'),
                  onPressed: () {
                    GoRouter.of(context).pushNamed(AppRouteNames.lesson, extra: sampleVideo);
                  },
                ),
                const SizedBox(height: AppDimensions.spacingSm),
                ElevatedButton(
                  child: const Text('Go to Test PDF Lesson (Flutter Succinctly)'),
                  onPressed: () {
                    GoRouter.of(context).pushNamed(AppRouteNames.lesson, extra: samplePdf);
                  },
                ),
                const SizedBox(height: AppDimensions.spacingSm),
                 ElevatedButton(
                  child: const Text('Go to Test Invalid Video URL'),
                  onPressed: () {
                    GoRouter.of(context).pushNamed(AppRouteNames.lesson, extra: sampleInvalidVideo);
                  },
                ),
              ],
            ),
          ),
          const Divider(), // Added a divider
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.spacingMd,
              vertical: AppDimensions.spacingSm,
            ),
            child: AspectRatio(
              aspectRatio: 16 / 7.5, // Adjusted aspect ratio for typical banner
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  AppDimensions.borderRadiusLg,
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      'https://images.unsplash.com/photo-1506126613408-eca07ce68773?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=799&q=80', // Example image
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Center(child: Text('Could not load image')),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withAlpha(0), // Transparent at top
                            Colors.black.withAlpha((255 * 0.6).round()), // Darker at bottom
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(AppDimensions.spacingLg),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bem-vindo(a) ao AYA',
                            style: AyaTextStyles.h2.copyWith(color: Colors.white),
                          ),
                          SizedBox(height: AppDimensions.spacingXs),
                          Text(
                            'Explore nosso conteúdo e comece sua jornada de autoconhecimento.',
                            style: AyaTextStyles.bodyLarge.copyWith(color: Colors.white.withAlpha((255 * 0.8).round())),
                          ),
                          SizedBox(height: AppDimensions.spacingMd),
                          ElevatedButton.icon(
                            onPressed: () {
                              // TODO: Implement navigation or action
                            },
                            icon: const iconoir.ArrowRight(),
                            label: const Text('Começar Agora'),
                            style: ElevatedButton.styleFrom(
                              // backgroundColor: AyaColors.lavender, // Example from theme
                              // foregroundColor: AyaColors.deepPurple,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Page indicators (optional, if this banner becomes a carousel)
                    Positioned(
                      bottom: AppDimensions.spacingMd,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildPageIndicator(true, context),
                          SizedBox(width: AppDimensions.spacingXs),
                          _buildPageIndicator(false, context),
                          SizedBox(width: AppDimensions.spacingXs),
                          _buildPageIndicator(false, context),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Iterate over mockModules to build sections
          ...mockModules.map((module) => _buildModuleSection(context, module)),
        ],
      ),
    );
  }

  Widget _buildPageIndicator(bool isActive, BuildContext context) {
    return Container(
      width: 8, // Standard size for page indicators
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.secondary.withOpacity(0.5),
      ),
    );
  }

  Widget _buildModuleSection(
    BuildContext context,
    Map<String, dynamic> module,
  ) {
    // Assuming items is a List<Map<String, String>>
    final List<Map<String, String>> items = (module['items'] as List)
        .cast<Map<String, String>>(); // Ensure correct type casting

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: AppDimensions.spacingMd,
            top: AppDimensions.spacingLg, // Space above module title
            bottom: AppDimensions.spacingSm,
          ),
          child: Text(
            module['title'] as String,
            style: AyaTextStyles.h3.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
        SizedBox(
          height: 220, // Define a fixed height for horizontal list
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: AppDimensions.spacingMd),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Padding(
                padding: EdgeInsets.only(right: AppDimensions.spacingMd), // Space between cards
                child: SizedBox(
                  width: 160, // Width of each card
                  child: Card(
                    clipBehavior: Clip.antiAlias, // Ensures content respects card borders
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Placeholder for an image or icon
                        AspectRatio(
                          aspectRatio: 1.0, // Square aspect ratio for the image/icon area
                          child: Container(
                            color: Theme.of(context).colorScheme.surfaceVariant, // Placeholder color
                            child: Center(
                              child: iconoir.MediaImage( // Placeholder icon
                                color: Theme.of(context).colorScheme.primary,
                                width: 48,
                                height: 48,
                              ),
                            ),
                          ),
                        ),
                        // Text content
                        Padding(
                          padding: EdgeInsets.all(AppDimensions.spacingSm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['title']!,
                                style: AyaTextStyles.bodyLarge.copyWith(
                                  color: Theme.of(context).colorScheme.onSurface,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: AppDimensions.spacingXs),
                              Text(
                                item['description']!,
                                style: AyaTextStyles.caption.copyWith(
                                color: Theme.of(context).colorScheme.onSurfaceVariant, // Softer color for description
                                ),
                                maxLines: 1, // Adjust as needed
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
