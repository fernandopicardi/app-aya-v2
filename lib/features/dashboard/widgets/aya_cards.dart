import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/theme/app_theme.dart';
import '../../../widgets/aya_card.dart';
import '../../../widgets/aya_image.dart';

class AyaFeaturedCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final VoidCallback onTap;
  final String? buttonText;

  const AyaFeaturedCard({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.onTap,
    this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return AyaCard(
      variant: AyaCardVariant.elevated,
      height: 200,
      onTap: onTap,
      child: Stack(
        fit: StackFit.expand,
        children: [
          AyaImage(
            imageUrl: imageUrl,
            borderRadius: BorderRadius.circular(16),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  AyaColors.overlayDark,
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: AyaColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AyaColors.textPrimary80,
                      ),
                ),
                if (buttonText != null) ...[
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: onTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AyaColors.turquoise,
                      foregroundColor: AyaColors.textPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: Text(buttonText!),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AyaContentCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String imageUrl;
  final VoidCallback onTap;
  final double width;
  final double height;

  const AyaContentCard({
    super.key,
    required this.title,
    this.subtitle,
    required this.imageUrl,
    required this.onTap,
    this.width = 160,
    this.height = 200,
  });

  @override
  Widget build(BuildContext context) {
    return AyaCard(
      variant: AyaCardVariant.ui,
      width: width,
      height: height,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AyaImage(
            imageUrl: imageUrl,
            width: width,
            height: height * 0.7,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AyaColors.textPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AyaColors.textPrimary60,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AyaSectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onSeeAllPressed;

  const AyaSectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.onSeeAllPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AyaColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AyaColors.textPrimary60,
                        ),
                  ),
                ],
              ],
            ),
          ),
          if (onSeeAllPressed != null)
            TextButton(
              onPressed: onSeeAllPressed,
              child: Text(
                'Ver todos',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AyaColors.turquoise,
                    ),
              ),
            ),
        ],
      ),
    );
  }
}
