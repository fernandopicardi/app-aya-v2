import 'package:flutter/material.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_dimensions.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  // Mock data for modules and their items
  final List<Map<String, dynamic>> mockModules = const [
    {
      'title': 'Meditação para Iniciantes',
      'items': [
        {'title': 'Meditação 1', 'description': 'Introdução à meditação'},
        {'title': 'Meditação 2', 'description': 'Técnicas básicas'},
        {'title': 'Meditação 3', 'description': 'Respiração consciente'},
        {'title': 'Meditação 4', 'description': 'Mindfulness'},
        {'title': 'Meditação 5', 'description': 'Meditação guiada'},
      ],
    },
    {
      'title': 'Jornada do Autoconhecimento',
      'items': [
        {'title': 'Etapa 1', 'description': 'Autoconhecimento inicial'},
        {'title': 'Etapa 2', 'description': 'Exploração pessoal'},
        {'title': 'Etapa 3', 'description': 'Desenvolvimento'},
      ],
    },
    {
      'title': 'Astrologia na Prática',
      'items': [
        {'title': 'Aula Astro 1', 'description': 'Fundamentos'},
        {'title': 'Aula Astro 2', 'description': 'Signos'},
        {'title': 'Aula Astro 3', 'description': 'Planetas'},
        {'title': 'Aula Astro 4', 'description': 'Casas'},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          // Hero Slider
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.spacingMd,
              vertical: AppDimensions.spacingSm,
            ),
            child: AspectRatio(
              aspectRatio: 16 / 7.5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  AppDimensions.borderRadiusLg,
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Background Image
                    Image.network(
                      'https://images.unsplash.com/photo-1506126613408-eca07ce68773?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=799&q=80',
                      fit: BoxFit.cover,
                    ),
                    // Dark Overlay
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withAlpha(0),
                            Colors.black.withAlpha((255 * 0.6).round()),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                    // Content
                    Padding(
                      padding: EdgeInsets.all(AppDimensions.spacingLg),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bem-vindo(a) ao AYA',
                            style: AyaTextStyles.h2.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: AppDimensions.spacingXs),
                          Text(
                            'Explore nosso conteúdo e comece sua jornada de autoconhecimento.',
                            style: AyaTextStyles.bodyLarge.copyWith(
                              color: Colors.white.withAlpha(
                                (255 * 0.8).round(),
                              ),
                            ),
                          ),
                          SizedBox(height: AppDimensions.spacingMd),
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: const iconoir.ArrowRight(),
                            label: const Text('Começar Agora'),
                          ),
                        ],
                      ),
                    ),
                    // Page Indicators
                    Positioned(
                      bottom: AppDimensions.spacingMd,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildPageIndicator(true),
                          SizedBox(width: AppDimensions.spacingXs),
                          _buildPageIndicator(false),
                          SizedBox(width: AppDimensions.spacingXs),
                          _buildPageIndicator(false),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Module Sections
          ...mockModules.map((module) => _buildModuleSection(context, module)),
        ],
      ),
    );
  }

  Widget _buildPageIndicator(bool isActive) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? AyaColors.lavender : AyaColors.softLavender,
      ),
    );
  }

  Widget _buildModuleSection(
    BuildContext context,
    Map<String, dynamic> module,
  ) {
    final List<Map<String, String>> items = (module['items'] as List)
        .cast<Map<String, String>>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: AppDimensions.spacingMd,
            top: AppDimensions.spacingLg,
            bottom: AppDimensions.spacingSm,
          ),
          child: Text(
            module['title'] as String,
            style: AyaTextStyles.h3.copyWith(
              color: AyaColors.textPrimaryOnDark,
            ),
          ),
        ),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: AppDimensions.spacingMd),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Padding(
                padding: EdgeInsets.only(right: AppDimensions.spacingMd),
                child: SizedBox(
                  width: 160,
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Thumbnail
                        AspectRatio(
                          aspectRatio: 1.0,
                          child: Container(
                            color: AyaColors.softLavender,
                            child: Center(
                              child: iconoir.MediaImage(
                                color: AyaColors.lavender,
                                width: 48,
                                height: 48,
                              ),
                            ),
                          ),
                        ),
                        // Content
                        Padding(
                          padding: EdgeInsets.all(AppDimensions.spacingSm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['title']!,
                                style: AyaTextStyles.bodyLarge.copyWith(
                                  color: AyaColors.textPrimaryOnDark,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: AppDimensions.spacingXs),
                              Text(
                                item['description']!,
                                style: AyaTextStyles.caption.copyWith(
                                  color: AyaColors.textSecondaryOnDark,
                                ),
                                maxLines: 1,
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
