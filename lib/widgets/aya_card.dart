import 'package:flutter/material.dart';
import '../theme/aya_theme.dart';
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

  const AyaCard({
    Key? key,
    required this.child,
    this.variant = AyaCardVariant.ui,
    this.padding,
    this.onTap,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget card = AnimationsService.scaleIn(
      Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: _getGradient(),
          borderRadius: BorderRadius.circular(16),
          boxShadow: _getShadow(),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16),
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
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AyaColors.overlayDark,
                blurRadius: 10,
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
            Color.fromRGBO(71, 76, 114,
                0.95), // AyaColors.backgroundGradientEnd with 95% opacity
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case AyaCardVariant.elevated:
        return LinearGradient(
          colors: [
            AyaColors.backgroundGradientEnd,
            Color.fromRGBO(71, 76, 114,
                0.98), // AyaColors.backgroundGradientEnd with 98% opacity
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
            blurRadius: 10,
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
  }) {
    return AyaCard(
      variant: AyaCardVariant.content,
      onTap: onTap,
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
  }) {
    return AyaCard(
      variant: AyaCardVariant.ui,
      onTap: onTap,
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
