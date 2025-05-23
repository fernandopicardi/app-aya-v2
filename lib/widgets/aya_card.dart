import 'package:flutter/material.dart';
import 'package:app_aya_v2/core/theme/app_theme.dart';
import '../core/services/animations_service.dart';

enum AyaCardVariant {
  content,
  ui,
  elevated,
}

class AyaCard extends StatelessWidget {
  final Widget child;
  final AyaCardVariant variant;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final double blur;
  final double opacity;
  final double borderOpacity;
  final double borderRadius;
  final List<BoxShadow>? boxShadow;

  const AyaCard({
    Key? key,
    required this.child,
    this.variant = AyaCardVariant.ui,
    this.padding,
    this.onTap,
    this.width,
    this.height,
    this.blur = 10.0,
    this.opacity = 0.25,
    this.borderOpacity = 0.20,
    this.borderRadius = 16.0,
    this.boxShadow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget card = AnimationsService.scaleIn(
      Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: _getGradient(),
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: boxShadow ?? _getShadow(),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(borderRadius),
            child: Padding(
              padding: padding ?? const EdgeInsets.all(16),
              child: child,
            ),
          ),
        ),
      ),
    );

    if (variant == AyaCardVariant.elevated) {
      return AnimationsService.slideInUp(
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: [
              BoxShadow(
                color: AyaColors.overlayDark,
                blurRadius: blur,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: card,
        ),
      );
    }

    return card;
  }

  LinearGradient? _getGradient() {
    switch (variant) {
      case AyaCardVariant.content:
        return LinearGradient(
          colors: [
            AyaColors.cardGradientStart,
            AyaColors.cardGradientEnd,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case AyaCardVariant.ui:
        return LinearGradient(
          colors: [
            AyaColors.backgroundGradientEnd,
            Color.fromRGBO(71, 76, 114, opacity),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case AyaCardVariant.elevated:
        return LinearGradient(
          colors: [
            AyaColors.backgroundGradientEnd,
            Color.fromRGBO(71, 76, 114, opacity + 0.03),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
    }
  }

  List<BoxShadow>? _getShadow() {
    switch (variant) {
      case AyaCardVariant.elevated:
        return [
          BoxShadow(
            color: AyaColors.overlayDark,
            blurRadius: blur,
            offset: const Offset(0, 4),
          ),
        ];
      default:
        return null;
    }
  }
}

// Extension to make it easier to create common card layouts
extension AyaCardBuilder on AyaCard {
  static AyaCard content({
    required String title,
    required String description,
    Widget? trailing,
    VoidCallback? onTap,
    double blur = 10.0,
    double opacity = 0.25,
    double borderOpacity = 0.20,
    double borderRadius = 16.0,
  }) {
    return AyaCard(
      variant: AyaCardVariant.content,
      onTap: onTap,
      blur: blur,
      opacity: opacity,
      borderOpacity: borderOpacity,
      borderRadius: borderRadius,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AyaColors.textPrimary,
                  ),
                ),
              ),
              if (trailing != null) trailing,
            ],
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              color: AyaColors.textPrimary80,
            ),
          ),
        ],
      ),
    );
  }

  static AyaCard ui({
    required String title,
    required Widget content,
    Widget? trailing,
    VoidCallback? onTap,
    double blur = 10.0,
    double opacity = 0.25,
    double borderOpacity = 0.20,
    double borderRadius = 16.0,
  }) {
    return AyaCard(
      variant: AyaCardVariant.ui,
      onTap: onTap,
      blur: blur,
      opacity: opacity,
      borderOpacity: borderOpacity,
      borderRadius: borderRadius,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AyaColors.textPrimary,
                  ),
                ),
              ),
              if (trailing != null) trailing,
            ],
          ),
          const SizedBox(height: 12),
          content,
        ],
      ),
    );
  }
}
