import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class AyaAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final bool showMenu;
  final VoidCallback? onMenuPressed;
  final int notificationCount;

  const AyaAppBar({
    super.key,
    this.title,
    this.actions,
    this.showMenu = true,
    this.onMenuPressed,
    this.notificationCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: showMenu
          ? IconButton(
              icon: const Icon(
                Icons.menu,
                color: AyaColors.textPrimary,
              ),
              onPressed: onMenuPressed,
            )
          : null,
      title: title != null
          ? Text(
              title!,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AyaColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
            )
          : null,
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(
            Icons.search,
            color: AyaColors.textPrimary,
          ),
          onPressed: () {
            // TODO: Implement search
          },
        ),
        Stack(
          children: [
            IconButton(
              icon: const Icon(
                Icons.notifications_outlined,
                color: AyaColors.textPrimary,
              ),
              onPressed: () {
                // TODO: Implement notifications
              },
            ),
            if (notificationCount > 0)
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: Text(
                    notificationCount.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
        if (actions != null) ...actions!,
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
