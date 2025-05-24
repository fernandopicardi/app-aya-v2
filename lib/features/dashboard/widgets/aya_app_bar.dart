import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import '../../../core/theme/app_theme.dart';
import '../../../widgets/aya_premium_icon.dart';

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
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AyaColors.surface.withValues(alpha: 0.8),
                AyaColors.surface.withValues(alpha: 0.6),
              ],
            ),
            border: Border(
              bottom: BorderSide(
                color: AyaColors.lavenderVibrant.withValues(alpha: 0.1),
                width: 1,
              ),
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: showMenu
                ? IconButton(
                    icon: AyaPremiumIcon(
                      customIcon: const iconoir.Menu(),
                      isActive: false,
                      size: 24,
                      borderRadius: 12,
                      padding: const EdgeInsets.all(8),
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
                icon: AyaPremiumIcon(
                  customIcon: const iconoir.Search(),
                  isActive: false,
                  size: 24,
                  borderRadius: 12,
                  padding: const EdgeInsets.all(8),
                ),
                onPressed: () {
                  // TODO: Implement search
                },
              ),
              Stack(
                children: [
                  IconButton(
                    icon: AyaPremiumIcon(
                      customIcon: const iconoir.Bell(),
                      isActive: false,
                      size: 24,
                      borderRadius: 12,
                      padding: const EdgeInsets.all(8),
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
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AyaColors.lavenderVibrant.withValues(alpha: 0.3),
                              AyaColors.turquoise,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: AyaColors.lavenderVibrant
                                  .withValues(alpha: 0.3),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
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
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
