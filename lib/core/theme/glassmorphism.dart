import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:app_aya_v2/core/theme/app_theme.dart';

/// A simplified Glassmorphism widget that will be refined later.
/// Currently provides a basic frosted glass effect using the Aya theme colors.
class Glassmorphism extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final double blurRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry margin;
  final Color? backgroundColor;
  final bool showInnerBorder;
  final bool showTopHighlight;
  final bool animate;
  final Duration animationDuration;
  final Curve animationCurve;
  final Color? borderColor;

  const Glassmorphism({
    super.key,
    required this.child,
    this.borderRadius = 16,
    this.blurRadius = 10,
    this.padding,
    this.margin = EdgeInsets.zero,
    this.backgroundColor,
    this.showInnerBorder = true,
    this.showTopHighlight = true,
    this.animate = false,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final container = ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurRadius, sigmaY: blurRadius),
        child: Container(
          margin: margin,
          decoration: BoxDecoration(
            color: backgroundColor ?? AyaColors.glassBackground,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: borderColor ?? AyaColors.glassBorder,
            ),
            boxShadow: [
              BoxShadow(
                color: AyaColors.glassShadow,
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              if (showTopHighlight)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 1,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AyaColors.glassHighlight.withValues(alpha: 0.5),
                          AyaColors.glassHighlight.withValues(alpha: 0.0),
                        ],
                      ),
                    ),
                  ),
                ),
              if (showInnerBorder)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(borderRadius),
                      border: Border.all(
                        color: AyaColors.glassInnerBorder,
                      ),
                    ),
                  ),
                ),
              padding != null
                  ? Padding(
                      padding: padding!,
                      child: child,
                    )
                  : child,
            ],
          ),
        ),
      ),
    );

    if (animate) {
      return AnimatedContainer(
        duration: animationDuration,
        curve: animationCurve,
        child: container,
      );
    }

    return container;
  }
}

class GlassmorphicButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final double borderRadius;
  final double blurRadius;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Color? backgroundColor;
  final bool showInnerBorder;
  final bool showTopHighlight;
  final bool animate;
  final Duration animationDuration;
  final Curve animationCurve;

  const GlassmorphicButton({
    super.key,
    required this.child,
    this.onPressed,
    this.borderRadius = 16,
    this.blurRadius = 10,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    this.margin = EdgeInsets.zero,
    this.backgroundColor,
    this.showInnerBorder = true,
    this.showTopHighlight = true,
    this.animate = false,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
  });

  @override
  Widget build(BuildContext context) {
    return Glassmorphism(
      borderRadius: borderRadius,
      blurRadius: blurRadius,
      padding: padding,
      margin: margin,
      backgroundColor: backgroundColor,
      showInnerBorder: showInnerBorder,
      showTopHighlight: showTopHighlight,
      animate: animate,
      animationDuration: animationDuration,
      animationCurve: animationCurve,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(borderRadius),
          child: child,
        ),
      ),
    );
  }
}

class GlassmorphicCard extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final double blurRadius;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Color? backgroundColor;
  final bool showInnerBorder;
  final bool showTopHighlight;
  final bool animate;
  final Duration animationDuration;
  final Curve animationCurve;

  const GlassmorphicCard({
    super.key,
    required this.child,
    this.borderRadius = 16,
    this.blurRadius = 10,
    this.padding = const EdgeInsets.all(16),
    this.margin = EdgeInsets.zero,
    this.backgroundColor,
    this.showInnerBorder = true,
    this.showTopHighlight = true,
    this.animate = false,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
  });

  @override
  Widget build(BuildContext context) {
    return Glassmorphism(
      borderRadius: borderRadius,
      blurRadius: blurRadius,
      padding: padding,
      margin: margin,
      backgroundColor: backgroundColor,
      showInnerBorder: showInnerBorder,
      showTopHighlight: showTopHighlight,
      animate: animate,
      animationDuration: animationDuration,
      animationCurve: animationCurve,
      child: child,
    );
  }
}

// TODO: Reimplement with proper glassmorphism effect using BackdropFilter
// The current implementation is a simplified version that will be enhanced later
// with proper blur effects and more sophisticated styling.
