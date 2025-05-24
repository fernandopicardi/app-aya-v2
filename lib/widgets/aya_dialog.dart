import 'package:flutter/material.dart';
import 'package:app_aya_v2/core/theme/app_theme.dart';
import '../core/services/animations_service.dart';
import 'aya_button.dart';
import 'aya_premium_icon.dart';

enum AyaDialogVariant {
  info,
  success,
  warning,
  error,
}

class AyaDialog extends StatelessWidget {
  final String title;
  final Widget content;
  final List<Widget>? actions;
  final bool showCloseButton;
  final double? width;
  final double? maxWidth;

  const AyaDialog({
    super.key,
    required this.title,
    required this.content,
    this.actions,
    this.showCloseButton = true,
    this.width,
    this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: AnimationsService.scaleIn(
        Container(
          width: width,
          constraints: BoxConstraints(
            maxWidth: maxWidth ?? 400,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AyaColors.backgroundGradientEnd,
                Color.fromRGBO(71, 76, 114,
                    0.95), // AyaColors.backgroundGradientEnd with 95% opacity
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AyaColors.overlayDark,
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (showCloseButton)
                Align(
                  alignment: Alignment.topRight,
                  child: AnimationsService.fadeIn(
                    IconButton(
                      icon: AyaPremiumIcon(
                        icon: Icons.close,
                        isActive: true,
                        size: 22,
                        borderRadius: 8,
                        padding: const EdgeInsets.all(4),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimationsService.fadeIn(
                      Text(
                        title,
                        style: const TextStyle(
                          color: AyaColors.textPrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    AnimationsService.fadeIn(
                      content,
                    ),
                    if (actions != null) ...[
                      const SizedBox(height: 24),
                      AnimationsService.fadeIn(
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: actions!,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required Widget content,
    List<Widget>? actions,
    bool showCloseButton = true,
    double? width,
    double? maxWidth,
  }) {
    return showDialog<T>(
      context: context,
      builder: (context) => AyaDialog(
        title: title,
        content: content,
        actions: actions,
        showCloseButton: showCloseButton,
        width: width,
        maxWidth: maxWidth,
      ),
    );
  }
}

// Extension to make it easier to create common dialog layouts
extension AyaDialogBuilder on AyaDialog {
  static Future<bool?> showConfirmation({
    required BuildContext context,
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    AyaDialogVariant variant = AyaDialogVariant.info,
    Widget? icon,
  }) {
    return AyaDialog.show<bool>(
      context: context,
      title: title,
      content: Text(
        message,
        style: const TextStyle(
          color: AyaColors.textPrimary80,
          fontSize: 16,
        ),
        textAlign: TextAlign.center,
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: AyaButton(
                text: cancelText,
                variant: AyaButtonVariant.outline,
                onPressed: () => Navigator.of(context).pop(false),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: AyaButton(
                text: confirmText,
                onPressed: () => Navigator.of(context).pop(true),
              ),
            ),
          ],
        ),
      ],
    );
  }

  static Future<void> showSuccess({
    required BuildContext context,
    required String title,
    required String message,
    String buttonText = 'OK',
  }) {
    return AyaDialog.show(
      context: context,
      title: title,
      content: Text(
        message,
        style: const TextStyle(
          color: AyaColors.textPrimary80,
          fontSize: 16,
        ),
        textAlign: TextAlign.center,
      ),
      actions: [
        AyaButton(
          text: buttonText,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }

  static Future<void> showError({
    required BuildContext context,
    required String title,
    required String message,
    String buttonText = 'OK',
  }) {
    return AyaDialog.show(
      context: context,
      title: title,
      content: Text(
        message,
        style: const TextStyle(
          color: Colors.red,
          fontSize: 16,
        ),
        textAlign: TextAlign.center,
      ),
      actions: [
        AyaButton(
          text: buttonText,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
