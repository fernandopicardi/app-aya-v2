import 'package:flutter/material.dart';
import 'package:app_aya_v2/core/theme/app_theme.dart';

enum AyaAvatarVariant {
  circle,
  rounded,
  square,
}

class AyaAvatar extends StatelessWidget {
  final String? imageUrl;
  final String? initials;
  final IconData? icon;
  final double size;
  final AyaAvatarVariant variant;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? borderWidth;
  final Color? borderColor;
  final VoidCallback? onTap;
  final bool showBadge;
  final Color? badgeColor;
  final Widget? badge;

  const AyaAvatar({
    Key? key,
    this.imageUrl,
    this.initials,
    this.icon,
    this.size = 40,
    this.variant = AyaAvatarVariant.circle,
    this.backgroundColor,
    this.foregroundColor,
    this.borderWidth,
    this.borderColor,
    this.onTap,
    this.showBadge = false,
    this.badgeColor,
    this.badge,
  })  : assert(
          imageUrl != null || initials != null || icon != null,
          'Either imageUrl, initials, or icon must be provided',
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: backgroundColor ?? AyaColors.lavenderSoft,
              shape: _getShape(),
              borderRadius: _getBorderRadius(),
              border: borderWidth != null
                  ? Border.all(
                      color: borderColor ?? AyaColors.lavenderVibrant,
                      width: borderWidth!,
                    )
                  : null,
            ),
            child: _buildContent(),
          ),
          if (showBadge)
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: size * 0.3,
                height: size * 0.3,
                decoration: BoxDecoration(
                  color: badgeColor ?? AyaColors.turquoise,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AyaColors.background,
                    width: 2,
                  ),
                ),
                child: badge ??
                    const Icon(
                      Icons.check,
                      color: AyaColors.textPrimary,
                      size: 12,
                    ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    if (imageUrl != null) {
      return ClipRRect(
        borderRadius: _getBorderRadius() ?? BorderRadius.zero,
        child: Image.network(
          imageUrl!,
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _buildFallback();
          },
        ),
      );
    }

    return _buildFallback();
  }

  Widget _buildFallback() {
    if (initials != null) {
      return Center(
        child: Text(
          initials!,
          style: TextStyle(
            color: foregroundColor ?? AyaColors.textPrimary,
            fontSize: size * 0.4,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }

    if (icon != null) {
      return Icon(
        icon,
        color: foregroundColor ?? AyaColors.textPrimary,
        size: size * 0.5,
      );
    }

    return const SizedBox.shrink();
  }

  BoxShape _getShape() {
    switch (variant) {
      case AyaAvatarVariant.circle:
        return BoxShape.circle;
      case AyaAvatarVariant.rounded:
      case AyaAvatarVariant.square:
        return BoxShape.rectangle;
    }
  }

  BorderRadius? _getBorderRadius() {
    switch (variant) {
      case AyaAvatarVariant.circle:
        return null;
      case AyaAvatarVariant.rounded:
        return BorderRadius.circular(size * 0.2);
      case AyaAvatarVariant.square:
        return BorderRadius.circular(size * 0.1);
    }
  }
}

// Extension to make it easier to create common avatar layouts
extension AyaAvatarBuilder on AyaAvatar {
  static AyaAvatar user({
    String? imageUrl,
    String? name,
    double size = 40,
    AyaAvatarVariant variant = AyaAvatarVariant.circle,
    Color? backgroundColor,
    Color? foregroundColor,
    double? borderWidth,
    Color? borderColor,
    VoidCallback? onTap,
    bool showBadge = false,
    Color? badgeColor,
    Widget? badge,
  }) {
    String? initials;
    if (name != null && name.isNotEmpty) {
      final parts = name.split(' ');
      if (parts.length > 1) {
        initials = '${parts[0][0]}${parts[1][0]}'.toUpperCase();
      } else {
        initials = parts[0][0].toUpperCase();
      }
    }

    return AyaAvatar(
      imageUrl: imageUrl,
      initials: initials,
      size: size,
      variant: variant,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      borderWidth: borderWidth,
      borderColor: borderColor,
      onTap: onTap,
      showBadge: showBadge,
      badgeColor: badgeColor,
      badge: badge,
    );
  }

  static AyaAvatar icon({
    required IconData icon,
    double size = 40,
    AyaAvatarVariant variant = AyaAvatarVariant.circle,
    Color? backgroundColor,
    Color? foregroundColor,
    double? borderWidth,
    Color? borderColor,
    VoidCallback? onTap,
  }) {
    return AyaAvatar(
      icon: icon,
      size: size,
      variant: variant,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      borderWidth: borderWidth,
      borderColor: borderColor,
      onTap: onTap,
    );
  }
}
