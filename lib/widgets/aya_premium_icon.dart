import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;

class AyaPremiumIcon extends StatelessWidget {
  final IconData? icon;
  final Widget? customIcon;
  final bool isActive;
  final double size;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final Color? backgroundColor;
  final Color? borderColor;

  const AyaPremiumIcon({
    super.key,
    this.icon,
    this.customIcon,
    this.isActive = false,
    this.size = 24,
    this.borderRadius = 12,
    this.padding = const EdgeInsets.all(8),
    this.backgroundColor,
    this.borderColor,
  }) : assert(icon != null || customIcon != null,
            'icon or customIcon must be provided');

  @override
  Widget build(BuildContext context) {
    final Color iconColor =
        isActive ? AyaColors.lavenderVibrant : AyaColors.textPrimary;
    final Color border = borderColor ??
        (isActive ? AyaColors.lavenderVibrant : AyaColors.textPrimary40);
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.transparent,
        border: Border.all(color: border, width: 1.5),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: customIcon != null
          ? _buildIconoirWithColor(customIcon!, iconColor)
          : Icon(
              icon,
              color: iconColor,
              size: size,
            ),
    );
  }

  Widget _buildIconoirWithColor(Widget icon, Color color) {
    // Para widgets específicos do Iconoir
    final type = icon.runtimeType.toString();
    switch (type) {
      case 'VideoCamera':
        return iconoir.VideoCamera(color: color, width: size, height: size);
      case 'MusicDoubleNote':
        return iconoir.MusicDoubleNote(color: color, width: size, height: size);
      case 'Book':
        return iconoir.Book(color: color, width: size, height: size);
      case 'PageSearch':
        return iconoir.PageSearch(color: color, width: size, height: size);
      case 'Filter':
        return iconoir.Filter(color: color, width: size, height: size);
      case 'Crown':
        return iconoir.Crown(color: color, width: size, height: size);
      case 'Clock':
        return iconoir.Clock(color: color, width: size, height: size);
      case 'User':
        return iconoir.User(color: color, width: size, height: size);
      case 'ArrowRight':
        return iconoir.ArrowRight(color: color, width: size, height: size);
      default:
        return icon; // fallback para o widget original
    }
  }
}
