import 'package:flutter/material.dart';
import 'package:app_aya_v2/core/theme/app_theme.dart';
import 'package:app_aya_v2/core/theme/aya_icons.dart';
import 'package:app_aya_v2/widgets/aya_glass_container.dart';
import 'package:app_aya_v2/widgets/aya_premium_icon.dart';

class AdminMenu extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const AdminMenu({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Column(
        children: [
          AyaGlassContainer(
            borderRadius: 0,
            blurRadius: 15,
            padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 16),
            child: Center(
              child: Text(
                'Aya Admin',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
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
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildMenuItem(
                  context,
                  icon: AyaIcons.homeOutlined,
                  selectedIcon: AyaIcons.home,
                  label: 'Dashboard',
                  index: 0,
                ),
                _buildMenuItem(
                  context,
                  icon: AyaIcons.communityOutlined,
                  selectedIcon: AyaIcons.community,
                  label: 'Usuários',
                  index: 1,
                ),
                _buildMenuItem(
                  context,
                  icon: AyaIcons.articleOutlined,
                  selectedIcon: AyaIcons.article,
                  label: 'Conteúdo',
                  index: 2,
                ),
                const Divider(color: AyaColors.glassBorder),
                _buildMenuItem(
                  context,
                  icon: AyaIcons.settings,
                  selectedIcon: AyaIcons.settings,
                  label: 'Configurações',
                  index: 3,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required IconData selectedIcon,
    required String label,
    required int index,
  }) {
    final isSelected = selectedIndex == index;

    return AyaGlassContainer(
      borderRadius: 12,
      blurRadius: 10,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      backgroundColor:
          isSelected ? AyaColors.turquoise.withValues(alpha: 0.1) : null,
      showInnerBorder: isSelected,
      showTopHighlight: isSelected,
      child: ListTile(
        leading: AyaPremiumIcon(
          icon: isSelected ? selectedIcon : icon,
          isActive: isSelected,
          size: 22,
          borderRadius: 8,
          padding: const EdgeInsets.all(4),
        ),
        title: Text(
          label,
          style: TextStyle(
            color: isSelected ? AyaColors.turquoise : AyaColors.textPrimary,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        onTap: () => onItemSelected(index),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
