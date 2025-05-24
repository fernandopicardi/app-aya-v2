import 'package:flutter/material.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import '../core/theme/app_theme.dart';
import 'aya_premium_icon.dart';

class AyaBottomNavItem {
  final String label;
  final Widget iconoirIcon;
  final Widget selectedIconoirIcon;

  const AyaBottomNavItem({
    required this.label,
    required this.iconoirIcon,
    required this.selectedIconoirIcon,
  });
}

class AyaBottomNav extends StatelessWidget {
  final int currentIndex;
  final List<AyaBottomNavItem> items;
  final Function(int) onTap;

  const AyaBottomNav({
    super.key,
    required this.currentIndex,
    required this.items,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AyaColors.surface.withValues(alpha: 0.8),
        border: Border(
          top: BorderSide(
            color: AyaColors.lavenderVibrant.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        backgroundColor: Colors.transparent,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AyaColors.lavenderVibrant,
        unselectedItemColor: AyaColors.textPrimary,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 12,
        ),
        items: items.asMap().entries.map((entry) {
          final i = entry.key;
          final item = entry.value;
          final isSelected = i == currentIndex;
          return BottomNavigationBarItem(
            icon: AyaPremiumIcon(
              customIcon:
                  isSelected ? item.selectedIconoirIcon : item.iconoirIcon,
              isActive: isSelected,
              size: 24,
              borderRadius: 12,
              padding: const EdgeInsets.all(8),
            ),
            label: item.label,
          );
        }).toList(),
      ),
    );
  }
}

// Extension to make it easier to create common bottom nav layouts
extension AyaBottomNavBuilder on AyaBottomNav {
  static List<AyaBottomNavItem> get defaultItems => [
        AyaBottomNavItem(
          label: 'Home',
          iconoirIcon: const iconoir.Home(),
          selectedIconoirIcon: const iconoir.Home(),
        ),
        AyaBottomNavItem(
          label: 'Biblioteca',
          iconoirIcon: const iconoir.Book(),
          selectedIconoirIcon: const iconoir.Book(),
        ),
        AyaBottomNavItem(
          label: 'Comunidade',
          iconoirIcon: const iconoir.Group(),
          selectedIconoirIcon: const iconoir.Group(),
        ),
        AyaBottomNavItem(
          label: 'Aya Chat',
          iconoirIcon: const iconoir.ChatBubble(),
          selectedIconoirIcon: const iconoir.ChatBubble(),
        ),
      ];
}
