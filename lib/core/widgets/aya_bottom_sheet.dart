import 'package:flutter/material.dart';
import 'package:app_aya_v2/core/theme/app_theme.dart';

class BottomSheetItem {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const BottomSheetItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });
}

class AyaBottomSheet extends StatelessWidget {
  final String title;
  final List<BottomSheetItem> items;
  final Widget? child;

  const AyaBottomSheet({
    super.key,
    required this.title,
    this.items = const [],
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AyaColors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AyaColors.textSecondary.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              color: AyaColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          if (child != null) ...[
            child!,
            const SizedBox(height: 16),
          ],
          if (items.isNotEmpty) ...[
            ...items.map((item) => _buildItem(item)),
            const SizedBox(height: 16),
          ],
        ],
      ),
    );
  }

  Widget _buildItem(BottomSheetItem item) {
    return InkWell(
      onTap: item.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Row(
          children: [
            Icon(item.icon, color: AyaColors.primary, size: 24),
            const SizedBox(width: 16),
            Text(
              item.label,
              style: const TextStyle(
                color: AyaColors.textPrimary,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
