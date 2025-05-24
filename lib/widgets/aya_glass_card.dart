import 'package:flutter/material.dart';
import 'dart:ui';
import '../core/theme/app_theme.dart';

class AyaGlassCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final double borderRadius;
  final double blurRadius;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Color? borderColor;

  const AyaGlassCard({
    super.key,
    required this.child,
    this.onTap,
    this.borderRadius = 16,
    this.blurRadius = 10,
    this.padding,
    this.backgroundColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: ClipRRect(
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
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                child: padding != null
                    ? Padding(
                        padding: padding!,
                        child: child,
                      )
                    : child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
