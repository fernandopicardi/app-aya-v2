import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_aya_v2/core/theme/app_theme.dart';

enum AyaAppBarVariant {
  primary,
  transparent,
  elevated,
}

class AyaAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool centerTitle;
  final AyaAppBarVariant variant;
  final double elevation;
  final PreferredSizeWidget? bottom;

  const AyaAppBar({
    Key? key,
    required this.title,
    this.actions,
    this.leading,
    this.centerTitle = true,
    this.variant = AyaAppBarVariant.primary,
    this.elevation = 0,
    this.bottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: _getGradient(),
        boxShadow: _getShadow(),
      ),
      child: AppBar(
        title: Text(
          title,
          style: GoogleFonts.roboto(
            color: AyaColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: centerTitle,
        leading: leading,
        actions: actions,
        backgroundColor: Colors.transparent,
        elevation: 0,
        bottom: bottom,
      ),
    );
  }

  LinearGradient? _getGradient() {
    switch (variant) {
      case AyaAppBarVariant.primary:
        return LinearGradient(
          colors: [
            AyaColors.background,
            AyaColors.backgroundGradientEnd,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case AyaAppBarVariant.transparent:
        return null;
      case AyaAppBarVariant.elevated:
        return LinearGradient(
          colors: [
            AyaColors.backgroundGradientEnd,
            Color.fromRGBO(
                AyaColors.backgroundGradientEnd.r.round(),
                AyaColors.backgroundGradientEnd.g.round(),
                AyaColors.backgroundGradientEnd.b.round(),
                0.95),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
    }
  }

  List<BoxShadow>? _getShadow() {
    switch (variant) {
      case AyaAppBarVariant.elevated:
        return [
          BoxShadow(
            color: AyaColors.overlayDark,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ];
      default:
        return null;
    }
  }

  @override
  Size get preferredSize => Size.fromHeight(
        kToolbarHeight + (bottom?.preferredSize.height ?? 0),
      );
}

// Extension to make it easier to create common app bar layouts
extension AyaAppBarBuilder on AyaAppBar {
  static AyaAppBar primary({
    required String title,
    List<Widget>? actions,
    Widget? leading,
    bool centerTitle = true,
  }) {
    return AyaAppBar(
      title: title,
      actions: actions,
      leading: leading,
      centerTitle: centerTitle,
      variant: AyaAppBarVariant.primary,
    );
  }

  static AyaAppBar transparent({
    required String title,
    List<Widget>? actions,
    Widget? leading,
    bool centerTitle = true,
  }) {
    return AyaAppBar(
      title: title,
      actions: actions,
      leading: leading,
      centerTitle: centerTitle,
      variant: AyaAppBarVariant.transparent,
    );
  }

  static AyaAppBar elevated({
    required String title,
    List<Widget>? actions,
    Widget? leading,
    bool centerTitle = true,
    PreferredSizeWidget? bottom,
  }) {
    return AyaAppBar(
      title: title,
      actions: actions,
      leading: leading,
      centerTitle: centerTitle,
      variant: AyaAppBarVariant.elevated,
      bottom: bottom,
    );
  }
}
