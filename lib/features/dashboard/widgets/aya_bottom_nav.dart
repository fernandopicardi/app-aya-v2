import 'package:flutter/material.dart';
import 'dart:ui';
import '../../../core/theme/app_theme.dart';

class AyaBottomNav extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onDestinationSelected;

  const AyaBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
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
                AyaColors.surface.withOpacity(0.8),
                AyaColors.surface.withOpacity(0.6),
              ],
            ),
            border: Border(
              top: BorderSide(
                color: AyaColors.lavenderVibrant.withOpacity(0.1),
                width: 1,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: AyaColors.overlayDark,
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: NavigationBar(
            selectedIndex: selectedIndex,
            onDestinationSelected: onDestinationSelected,
            backgroundColor: Colors.transparent,
            elevation: 0,
            height: 64,
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            destinations: [
              _buildNavItem(Icons.home_outlined, Icons.home, 'Home'),
              _buildNavItem(Icons.library_books_outlined, Icons.library_books,
                  'Biblioteca'),
              _buildNavItem(Icons.people_outline, Icons.people, 'Comunidade'),
              _buildNavItem(
                  Icons.smart_toy_outlined, Icons.smart_toy, 'Aya Chat'),
              _buildNavItem(Icons.person_outline, Icons.person, 'Perfil'),
            ],
          ),
        ),
      ),
    );
  }

  NavigationDestination _buildNavItem(
    IconData outlinedIcon,
    IconData filledIcon,
    String label,
  ) {
    return NavigationDestination(
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AyaColors.lavenderVibrant.withOpacity(0.1),
              AyaColors.turquoise.withOpacity(0.1),
            ],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          outlinedIcon,
          color: AyaColors.textPrimary50,
        ),
      ),
      selectedIcon: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AyaColors.lavenderVibrant.withOpacity(0.2),
              AyaColors.turquoise.withOpacity(0.2),
            ],
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AyaColors.lavenderVibrant.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          filledIcon,
          color: AyaColors.turquoise,
        ),
      ),
      label: label,
    );
  }
}
