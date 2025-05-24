import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';
import 'aya_premium_icon.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;

class AyaDrawer extends StatelessWidget {
  final Widget? header;
  final List<AyaDrawerItem> items;
  final List<AyaDrawerItem>? footerItems;
  final Color? backgroundColor;
  final double? width;
  final double? elevation;
  final bool showDivider;
  final bool showHeaderDivider;
  final bool showFooterDivider;

  const AyaDrawer({
    super.key,
    this.header,
    required this.items,
    this.footerItems,
    this.backgroundColor,
    this.width,
    this.elevation,
    this.showDivider = true,
    this.showHeaderDivider = true,
    this.showFooterDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: backgroundColor ?? AyaColors.surface,
      width: width,
      elevation: elevation,
      child: Column(
        children: [
          if (header != null) ...[
            header!,
            if (showHeaderDivider) const Divider(),
          ],
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: items.length,
              separatorBuilder: (context, index) =>
                  showDivider ? const Divider() : const SizedBox.shrink(),
              itemBuilder: (context, index) => items[index],
            ),
          ),
          if (footerItems != null && footerItems!.isNotEmpty) ...[
            if (showFooterDivider) const Divider(),
            ...footerItems!.map((item) => item),
          ],
        ],
      ),
    );
  }
}

class AyaDrawerItem extends StatelessWidget {
  final String? title;
  final Widget? icon;
  final VoidCallback? onTap;
  final bool isSelected;
  final Color? selectedColor;
  final Color? unselectedColor;
  final TextStyle? titleStyle;
  final EdgeInsetsGeometry? padding;
  final bool showDivider;
  final bool isHeader;
  final bool isFooter;

  const AyaDrawerItem({
    super.key,
    this.title,
    this.icon,
    this.onTap,
    this.isSelected = false,
    this.selectedColor,
    this.unselectedColor,
    this.titleStyle,
    this.padding,
    this.showDivider = false,
    this.isHeader = false,
    this.isFooter = false,
  }) : assert(title != null || icon != null,
            'Either title or icon must be provided');

  @override
  Widget build(BuildContext context) {
    final color = isSelected
        ? selectedColor ?? AyaColors.lavenderVibrant
        : unselectedColor ?? AyaColors.textPrimary;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          onTap: onTap,
          selected: isSelected,
          selectedTileColor: AyaColors.surface.withValues(alpha: 0.1),
          leading: icon != null
              ? AyaPremiumIcon(
                  customIcon: icon!,
                  size: 24,
                  borderRadius: 12,
                  padding: const EdgeInsets.all(4),
                )
              : null,
          title: title != null
              ? Text(
                  title!,
                  style: titleStyle ??
                      TextStyle(
                        color: color,
                        fontSize: 16,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w400,
                      ),
                )
              : null,
          padding: padding ??
              EdgeInsets.symmetric(
                horizontal: 16,
                vertical: isHeader || isFooter ? 8 : 4,
              ),
        ),
        if (showDivider) const Divider(),
      ],
    );
  }
}

// Extension to make it easier to create common drawer items
extension AyaDrawerItemBuilder on AyaDrawerItem {
  static AyaDrawerItem header({
    required String title,
    TextStyle? titleStyle,
    EdgeInsetsGeometry? padding,
  }) {
    return AyaDrawerItem(
      title: title,
      titleStyle: titleStyle ??
          const TextStyle(
            color: AyaColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
      padding: padding,
      isHeader: true,
    );
  }

  static AyaDrawerItem item({
    required String title,
    Widget? icon,
    VoidCallback? onTap,
    bool isSelected = false,
    Color? selectedColor,
    Color? unselectedColor,
    TextStyle? titleStyle,
    EdgeInsetsGeometry? padding,
  }) {
    return AyaDrawerItem(
      title: title,
      icon: icon,
      onTap: onTap,
      isSelected: isSelected,
      selectedColor: selectedColor,
      unselectedColor: unselectedColor,
      titleStyle: titleStyle,
      padding: padding,
    );
  }

  static AyaDrawerItem divider() {
    return const AyaDrawerItem(
      showDivider: true,
    );
  }

  static AyaDrawerItem footer({
    required String title,
    Widget? icon,
    VoidCallback? onTap,
    bool isSelected = false,
    Color? selectedColor,
    Color? unselectedColor,
    TextStyle? titleStyle,
    EdgeInsetsGeometry? padding,
  }) {
    return AyaDrawerItem(
      title: title,
      icon: icon,
      onTap: onTap,
      isSelected: isSelected,
      selectedColor: selectedColor,
      unselectedColor: unselectedColor,
      titleStyle: titleStyle,
      padding: padding,
      isFooter: true,
    );
  }
}
