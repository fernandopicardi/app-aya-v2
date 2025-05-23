import 'package:flutter/material.dart';
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
    return Container(
      decoration: BoxDecoration(
        color: AyaColors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            color: AyaColors.overlayLight,
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
          _buildNavItem(
              Icons.library_books_outlined, Icons.library_books, 'Biblioteca'),
          _buildNavItem(Icons.people_outline, Icons.people, 'Comunidade'),
          _buildNavItem(Icons.chat_outlined, Icons.chat, 'Chat IA'),
          _buildNavItem(Icons.person_outline, Icons.person, 'Perfil'),
        ],
      ),
    );
  }

  NavigationDestination _buildNavItem(
    IconData outlinedIcon,
    IconData filledIcon,
    String label,
  ) {
    return NavigationDestination(
      icon: Icon(
        outlinedIcon,
        color: AyaColors.textPrimary50,
      ),
      selectedIcon: Icon(
        filledIcon,
        color: AyaColors.turquoise,
      ),
      label: label,
    );
  }
}
