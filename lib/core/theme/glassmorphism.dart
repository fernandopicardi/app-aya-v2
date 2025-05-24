import 'package:flutter/material.dart';
import 'package:app_aya_v2/core/theme/app_theme.dart';

/// A simplified Glassmorphism widget that will be refined later.
/// Currently provides a basic frosted glass effect using the Aya theme colors.
class Glassmorphism extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final double blurRadius;
  final EdgeInsetsGeometry padding;

  const Glassmorphism({
    super.key,
    required this.child,
    this.borderRadius = 16.0,
    this.blurRadius = 10.0,
    this.padding = const EdgeInsets.all(16.0),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: AyaColors.surface.withAlpha(217),
        border: Border.all(
          color: AyaColors.textPrimary.withAlpha(26),
        ),
      ),
      child: child,
    );
  }
}

// TODO: Reimplement with proper glassmorphism effect using BackdropFilter
// The current implementation is a simplified version that will be enhanced later
// with proper blur effects and more sophisticated styling.
