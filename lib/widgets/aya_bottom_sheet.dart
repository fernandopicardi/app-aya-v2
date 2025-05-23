import 'package:flutter/material.dart';
import 'package:app_aya_v2/core/theme/app_theme.dart';

enum AyaBottomSheetVariant {
  standard,
  modal,
}

class AyaBottomSheet extends StatelessWidget {
  final Widget child;
  final String? title;
  final List<Widget>? actions;
  final bool showDragHandle;
  final Color? backgroundColor;
  final double? maxHeight;
  final EdgeInsets? padding;
  final AyaBottomSheetVariant variant;

  const AyaBottomSheet({
    super.key,
    required this.child,
    this.title,
    this.actions,
    this.showDragHandle = true,
    this.backgroundColor,
    this.maxHeight,
    this.padding,
    this.variant = AyaBottomSheetVariant.standard,
  });

  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    List<Widget>? actions,
    bool showDragHandle = true,
    bool isDismissible = true,
    bool enableDrag = true,
    Color? backgroundColor,
    double? maxHeight,
    EdgeInsets? padding,
    AyaBottomSheetVariant variant = AyaBottomSheetVariant.standard,
  }) {
    switch (variant) {
      case AyaBottomSheetVariant.modal:
        return showModalBottomSheet<T>(
          context: context,
          isDismissible: isDismissible,
          enableDrag: enableDrag,
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          builder: (context) => AyaBottomSheet(
            title: title,
            actions: actions,
            showDragHandle: showDragHandle,
            backgroundColor: backgroundColor,
            maxHeight: maxHeight,
            padding: padding,
            variant: variant,
            child: child,
          ),
        );

      case AyaBottomSheetVariant.standard:
        return showModalBottomSheet<T>(
          context: context,
          isDismissible: isDismissible,
          enableDrag: enableDrag,
          backgroundColor: Colors.transparent,
          builder: (context) => AyaBottomSheet(
            title: title,
            actions: actions,
            showDragHandle: showDragHandle,
            backgroundColor: backgroundColor,
            maxHeight: maxHeight,
            padding: padding,
            child: child,
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? AyaColors.backgroundGradientEnd;
    final screenHeight = MediaQuery.of(context).size.height;
    final maxSheetHeight = maxHeight ?? screenHeight * 0.9;

    return Container(
      constraints: BoxConstraints(
        maxHeight: maxSheetHeight,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            bgColor,
            Color.fromRGBO(
                bgColor.r.round(), bgColor.g.round(), bgColor.b.round(), 0.95),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: AyaColors.overlayDark,
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showDragHandle) ...[
              const SizedBox(height: 8),
              Center(
                child: Container(
                  width: 32,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AyaColors.textPrimary40,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ],
            if (title != null || actions != null) ...[
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Row(
                  children: [
                    if (title != null)
                      Expanded(
                        child: Text(
                          title!,
                          style: const TextStyle(
                            color: AyaColors.textPrimary,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    if (actions != null) ...actions!,
                  ],
                ),
              ),
              const Divider(
                color: AyaColors.lavenderSoft,
                height: 1,
              ),
            ],
            Flexible(
              child: SingleChildScrollView(
                padding: padding ?? const EdgeInsets.all(16),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Extension to make it easier to create common bottom sheet layouts
extension AyaBottomSheetBuilder on AyaBottomSheet {
  static Future<T?> showForm<T>({
    required BuildContext context,
    required Widget form,
    String? title,
    List<Widget>? actions,
    bool showDragHandle = true,
    bool isDismissible = true,
    bool enableDrag = true,
    Color? backgroundColor,
    double? maxHeight,
    EdgeInsets? padding,
  }) {
    return AyaBottomSheet.show<T>(
      context: context,
      child: form,
      title: title,
      actions: actions,
      variant: AyaBottomSheetVariant.modal,
      showDragHandle: showDragHandle,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: backgroundColor,
      maxHeight: maxHeight,
      padding: padding,
    );
  }

  static Future<T?> showList<T>({
    required BuildContext context,
    required List<Widget> items,
    String? title,
    List<Widget>? actions,
    bool showDragHandle = true,
    bool isDismissible = true,
    bool enableDrag = true,
    Color? backgroundColor,
    double? maxHeight,
    EdgeInsets? padding,
  }) {
    return AyaBottomSheet.show<T>(
      context: context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: items,
      ),
      title: title,
      actions: actions,
      variant: AyaBottomSheetVariant.modal,
      showDragHandle: showDragHandle,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: backgroundColor,
      maxHeight: maxHeight,
      padding: padding,
    );
  }
}
