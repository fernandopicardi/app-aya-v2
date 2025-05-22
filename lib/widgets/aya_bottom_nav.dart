import 'package:flutter/material.dart';
import '../theme/aya_theme.dart';

class AyaBottomNav extends StatelessWidget {
  final int currentIndex;
  final List<AyaBottomNavItem> items;
  final ValueChanged<int> onTap;
  final bool showLabels;

  const AyaBottomNav({
    Key? key,
    required this.currentIndex,
    required this.items,
    required this.onTap,
    this.showLabels = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AyaColors.background,
            AyaColors.backgroundGradientEnd,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: AyaColors.overlayDark,
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              items.length,
              (index) => _buildNavItem(index),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index) {
    final item = items[index];
    final isSelected = index == currentIndex;

    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: [
                    Color.fromRGBO(
                        AyaColors.lavenderVibrant.r.round(),
                        AyaColors.lavenderVibrant.g.round(),
                        AyaColors.lavenderVibrant.b.round(),
                        0.2),
                    Color.fromRGBO(
                        AyaColors.softBlue.r.round(),
                        AyaColors.softBlue.g.round(),
                        AyaColors.softBlue.b.round(),
                        0.2),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? item.selectedIcon : item.icon,
              color: isSelected ? AyaColors.turquoise : AyaColors.textPrimary50,
              size: 24,
            ),
            if (showLabels) ...[
              const SizedBox(height: 4),
              Text(
                item.label,
                style: TextStyle(
                  color: isSelected
                      ? AyaColors.turquoise
                      : AyaColors.textPrimary50,
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class AyaBottomNavItem {
  final String label;
  final IconData icon;
  final IconData selectedIcon;

  const AyaBottomNavItem({
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });
}

// Extension to make it easier to create common bottom nav layouts
extension AyaBottomNavBuilder on AyaBottomNav {
  static List<AyaBottomNavItem> get defaultItems => [
        const AyaBottomNavItem(
          label: 'Home',
          icon: Icons.home_outlined,
          selectedIcon: Icons.home,
        ),
        const AyaBottomNavItem(
          label: 'Explore',
          icon: Icons.explore_outlined,
          selectedIcon: Icons.explore,
        ),
        const AyaBottomNavItem(
          label: 'Profile',
          icon: Icons.person_outline,
          selectedIcon: Icons.person,
        ),
      ];
}
