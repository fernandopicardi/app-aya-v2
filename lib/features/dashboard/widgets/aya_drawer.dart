import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../features/auth/services/auth_service.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;

class AyaDrawer extends StatelessWidget {
  final AuthService authService;
  final int selectedIndex;
  final Function(int) onItemSelected;

  const AyaDrawer({
    super.key,
    required this.authService,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AyaColors.surface.withValues(alpha: 0.8),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: AyaColors.lavenderVibrant.withValues(alpha: 0.1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor:
                      AyaColors.lavenderVibrant.withValues(alpha: 0.2),
                  child: const iconoir.User(
                    color: AyaColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  authService.getCurrentUser()?.email ?? 'Usuário',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AyaColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Text(
                  'Premium',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AyaColors.textPrimary.withValues(alpha: 0.6),
                      ),
                ),
              ],
            ),
          ),
          _buildDrawerItem(
            context,
            icon: const iconoir.Home(
              color: AyaColors.textPrimary,
            ),
            title: 'Home',
            index: 0,
          ),
          _buildDrawerItem(
            context,
            icon: const iconoir.Book(
              color: AyaColors.textPrimary,
            ),
            title: 'Biblioteca',
            index: 1,
          ),
          _buildDrawerItem(
            context,
            icon: const iconoir.Group(
              color: AyaColors.textPrimary,
            ),
            title: 'Comunidade',
            index: 2,
          ),
          _buildDrawerItem(
            context,
            icon: const iconoir.ChatBubble(
              color: AyaColors.textPrimary,
            ),
            title: 'Aya Chat',
            index: 3,
          ),
          const Divider(color: AyaColors.textPrimary40),
          _buildDrawerItem(
            context,
            icon: const iconoir.Settings(
              color: AyaColors.textPrimary,
            ),
            title: 'Configurações',
            onTap: () => context.go('/admin/settings'),
          ),
          _buildDrawerItem(
            context,
            icon: const iconoir.LogOut(
              color: AyaColors.textPrimary,
            ),
            title: 'Sair',
            onTap: () => context.go('/login'),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required Widget icon,
    required String title,
    int? index,
    VoidCallback? onTap,
  }) {
    final isSelected = index != null && index == selectedIndex;

    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected
              ? AyaColors.lavenderVibrant.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? AyaColors.lavenderVibrant
                : AyaColors.textPrimary40,
            width: 1.5,
          ),
        ),
        child: icon,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: isSelected
                  ? AyaColors.lavenderVibrant
                  : AyaColors.textPrimary,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
      ),
      selected: isSelected,
      selectedTileColor: AyaColors.lavenderVibrant.withValues(alpha: 0.1),
      hoverColor: AyaColors.lavenderVibrant.withValues(alpha: 0.05),
      onTap: () {
        if (onTap != null) {
          onTap();
        } else if (index != null) {
          onItemSelected(index);
        }
        Navigator.pop(context);
      },
    );
  }
}
