import 'package:flutter/material.dart';
// TODO: Implement glassmorphism
// import 'package:app_aya_v2/core/theme/glassmorphism.dart';
import 'package:app_aya_v2/core/theme/app_theme.dart';
import 'dart:ui';

class AyaGlassContainer extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final double blurRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry margin;
  final Color? backgroundColor;
  final bool showInnerBorder;
  final bool showTopHighlight;
  final BoxConstraints? constraints;
  final Alignment alignment;
  final bool animate;
  final Duration animationDuration;
  final Curve animationCurve;
  final Color? borderColor;

  const AyaGlassContainer({
    super.key,
    required this.child,
    this.borderRadius = 16,
    this.blurRadius = 10,
    this.padding,
    this.margin = EdgeInsets.zero,
    this.backgroundColor,
    this.showInnerBorder = true,
    this.showTopHighlight = true,
    this.constraints,
    this.alignment = Alignment.center,
    this.animate = true,
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
          child: padding != null
              ? Padding(
                  padding: padding!,
                  child: child,
                )
              : child,
        ),
      ),
    );

    if (!animate) {
      return Container(
        margin: margin,
        constraints: constraints,
        alignment: alignment,
        child: container,
      );
    }

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: animationDuration,
      curve: animationCurve,
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.95 + (value * 0.05),
          child: Opacity(
            opacity: value,
            child: Container(
              margin: margin,
              constraints: constraints,
              alignment: alignment,
              child: container,
            ),
          ),
        );
      },
    );
  }
}

class AyaGlassButton extends StatelessWidget {
  final VoidCallback onPressed;
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

  const AyaGlassButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.borderRadius = 12.0,
    this.blurRadius = 10.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    this.margin = EdgeInsets.zero,
    this.backgroundColor,
    this.showInnerBorder = true,
    this.showTopHighlight = true,
    this.animate = true,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
  });

  @override
  Widget build(BuildContext context) {
    return AyaGlassContainer(
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

class AyaGlassCard extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final double blurRadius;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Color? backgroundColor;
  final bool showInnerBorder;
  final bool showTopHighlight;
  final BoxConstraints? constraints;
  final Alignment alignment;
  final bool animate;
  final Duration animationDuration;
  final Curve animationCurve;

  const AyaGlassCard({
    super.key,
    required this.child,
    this.borderRadius = 16.0,
    this.blurRadius = 10.0,
    this.padding = const EdgeInsets.all(16.0),
    this.margin = const EdgeInsets.all(8.0),
    this.backgroundColor,
    this.showInnerBorder = true,
    this.showTopHighlight = true,
    this.constraints,
    this.alignment = Alignment.center,
    this.animate = true,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
  });

  @override
  Widget build(BuildContext context) {
    return AyaGlassContainer(
      borderRadius: borderRadius,
      blurRadius: blurRadius,
      padding: padding,
      margin: margin,
      backgroundColor: backgroundColor,
      showInnerBorder: showInnerBorder,
      showTopHighlight: showTopHighlight,
      constraints: constraints,
      alignment: alignment,
      animate: animate,
      animationDuration: animationDuration,
      animationCurve: animationCurve,
      child: child,
    );
  }
}
