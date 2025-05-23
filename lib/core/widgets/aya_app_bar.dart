import 'package:flutter/material.dart';
import 'package:app_aya_v2/core/theme/app_theme.dart';

class AyaAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final List<Widget> actions;
  final Color? backgroundColor;
  final double elevation;

  const AyaAppBar({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.actions = const [],
    this.backgroundColor,
    this.elevation = 0,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? AyaColors.surface,
      elevation: elevation,
      scrolledUnderElevation: elevation,
      centerTitle: true,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: AyaColors.primary),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
      title: Text(
        title,
        style: const TextStyle(
          color: AyaColors.textPrimary,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
