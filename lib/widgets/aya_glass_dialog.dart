import 'package:flutter/material.dart';
import 'package:app_aya_v2/core/theme/app_theme.dart';
import 'package:app_aya_v2/widgets/aya_glass_container.dart';
import 'aya_premium_icon.dart';

class AyaGlassDialog extends StatelessWidget {
  final String title;
  final Widget content;
  final List<Widget>? actions;
  final bool showCloseButton;
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

  const AyaGlassDialog({
    super.key,
    required this.title,
    required this.content,
    this.actions,
    this.showCloseButton = true,
    this.borderRadius = 24.0,
    this.blurRadius = 15.0,
    this.padding = const EdgeInsets.all(24.0),
    this.margin = const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
    this.backgroundColor,
    this.showInnerBorder = true,
    this.showTopHighlight = true,
    this.animate = true,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: AyaGlassContainer(
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AyaColors.textPrimary,
                      shadows: [
                        Shadow(
                          color: AyaColors.black60,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ),
                if (showCloseButton)
                  IconButton(
                    icon: AyaPremiumIcon(
                      icon: Icons.close,
                      isActive: false,
                      size: 22,
                      borderRadius: 8,
                      padding: const EdgeInsets.all(4),
                    ),
                    color: AyaColors.textPrimary,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Flexible(
              child: SingleChildScrollView(
                child: content,
              ),
            ),
            if (actions != null) ...[
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: actions!,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class AyaGlassAlertDialog extends StatelessWidget {
  final String title;
  final String message;
  final List<Widget>? actions;
  final bool showCloseButton;
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

  const AyaGlassAlertDialog({
    super.key,
    required this.title,
    required this.message,
    this.actions,
    this.showCloseButton = true,
    this.borderRadius = 24.0,
    this.blurRadius = 15.0,
    this.padding = const EdgeInsets.all(24.0),
    this.margin = const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
    this.backgroundColor,
    this.showInnerBorder = true,
    this.showTopHighlight = true,
    this.animate = true,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
  });

  @override
  Widget build(BuildContext context) {
    return AyaGlassDialog(
      title: title,
      content: Text(
        message,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AyaColors.textPrimary,
            ),
      ),
      actions: actions,
      showCloseButton: showCloseButton,
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
    );
  }
}

class AyaGlassConfirmDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmText;
  final String cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final bool showCloseButton;
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

  const AyaGlassConfirmDialog({
    super.key,
    required this.title,
    required this.message,
    this.confirmText = 'Confirmar',
    this.cancelText = 'Cancelar',
    this.onConfirm,
    this.onCancel,
    this.showCloseButton = true,
    this.borderRadius = 24.0,
    this.blurRadius = 15.0,
    this.padding = const EdgeInsets.all(24.0),
    this.margin = const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
    this.backgroundColor,
    this.showInnerBorder = true,
    this.showTopHighlight = true,
    this.animate = true,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
  });

  @override
  Widget build(BuildContext context) {
    return AyaGlassDialog(
      title: title,
      content: Text(
        message,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AyaColors.textPrimary,
            ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onCancel?.call();
          },
          child: Text(cancelText),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm?.call();
          },
          child: Text(confirmText),
        ),
      ],
      showCloseButton: showCloseButton,
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
    );
  }
}
