import 'package:flutter/material.dart';
import 'package:app_aya_v2/core/theme/app_theme.dart';
import '../core/services/animations_service.dart';

enum AyaSnackbarVariant {
  info,
  success,
  warning,
  error,
}

class AyaSnackbar extends StatelessWidget {
  final String message;
  final AyaSnackbarVariant variant;
  final String? actionLabel;
  final VoidCallback? onAction;
  final Duration duration;
  final bool showCloseIcon;

  const AyaSnackbar({
    Key? key,
    required this.message,
    this.variant = AyaSnackbarVariant.info,
    this.actionLabel,
    this.onAction,
    this.duration = const Duration(seconds: 4),
    this.showCloseIcon = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimationsService.slideInUp(
      Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _getGradientColors(),
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AyaColors.overlayDark,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: AnimationsService.fadeIn(
                    Text(
                      message,
                      style: const TextStyle(
                        color: AyaColors.textPrimary,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                if (actionLabel != null && onAction != null)
                  AnimationsService.fadeIn(
                    TextButton(
                      onPressed: onAction,
                      child: Text(
                        actionLabel!,
                        style: const TextStyle(
                          color: AyaColors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                if (showCloseIcon)
                  AnimationsService.fadeIn(
                    IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: AyaColors.textPrimary,
                        size: 20,
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Color> _getGradientColors() {
    switch (variant) {
      case AyaSnackbarVariant.info:
        return [
          AyaColors.softBlue,
          Color.fromRGBO(
              115, 189, 218, 0.8), // AyaColors.softBlue with 80% opacity
        ];
      case AyaSnackbarVariant.success:
        return [
          AyaColors.turquoise,
          Color.fromRGBO(
              120, 199, 180, 0.8), // AyaColors.turquoise with 80% opacity
        ];
      case AyaSnackbarVariant.warning:
        return [
          AyaColors.lavenderVibrant,
          Color.fromRGBO(
              172, 161, 239, 0.8), // AyaColors.lavenderVibrant with 80% opacity
        ];
      case AyaSnackbarVariant.error:
        return [
          Colors.red.shade400,
          Color.fromRGBO(
              236, 93, 93, 0.8), // Colors.red.shade400 with 80% opacity
        ];
    }
  }

  static void show({
    required BuildContext context,
    required String message,
    AyaSnackbarVariant variant = AyaSnackbarVariant.info,
    String? actionLabel,
    VoidCallback? onAction,
    Duration duration = const Duration(seconds: 4),
    bool showCloseIcon = true,
  }) {
    final snackBar = SnackBar(
      content: AyaSnackbar(
        message: message,
        variant: variant,
        actionLabel: actionLabel,
        onAction: onAction,
        showCloseIcon: showCloseIcon,
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      duration: duration,
      behavior: SnackBarBehavior.floating,
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

// Extension to make it easier to create common snackbar layouts
extension AyaSnackbarBuilder on AyaSnackbar {
  static void showSuccess({
    required BuildContext context,
    required String message,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    AyaSnackbar.show(
      context: context,
      message: message,
      variant: AyaSnackbarVariant.success,
      actionLabel: actionLabel,
      onAction: onAction,
    );
  }

  static void showError({
    required BuildContext context,
    required String message,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    AyaSnackbar.show(
      context: context,
      message: message,
      variant: AyaSnackbarVariant.error,
      actionLabel: actionLabel,
      onAction: onAction,
    );
  }

  static void showWarning({
    required BuildContext context,
    required String message,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    AyaSnackbar.show(
      context: context,
      message: message,
      variant: AyaSnackbarVariant.warning,
      actionLabel: actionLabel,
      onAction: onAction,
    );
  }
}
