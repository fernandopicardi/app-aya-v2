import 'package:flutter/material.dart';
import '../theme/aya_theme.dart';
import '../core/services/animations_service.dart';

enum AyaButtonVariant {
  primary,
  secondary,
  outline,
  text,
}

class AyaButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final AyaButtonVariant variant;
  final IconData? icon;
  final bool isLoading;
  final bool isFullWidth;
  final double? width;
  final double height;
  final EdgeInsetsGeometry? padding;

  const AyaButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.variant = AyaButtonVariant.primary,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = false,
    this.width,
    this.height = 48,
    this.padding,
  }) : super(key: key);

  @override
  State<AyaButton> createState() => _AyaButtonState();
}

class _AyaButtonState extends State<AyaButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  void _handleTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final button = MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: widget.onPressed != null ? _handleTapDown : null,
        onTapUp: widget.onPressed != null ? _handleTapUp : null,
        onTapCancel: widget.onPressed != null ? _handleTapCancel : null,
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: child,
            );
          },
          child: Container(
            width: widget.isFullWidth ? double.infinity : widget.width,
            height: widget.height,
            padding:
                widget.padding ?? const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              gradient: _getGradient(),
              borderRadius: BorderRadius.circular(12),
              border: _getBorder(),
              boxShadow: _getShadow(),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: widget.onPressed,
                borderRadius: BorderRadius.circular(12),
                child: Center(
                  child: widget.isLoading
                      ? AnimationsService.pulseLoading(
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                _getTextColor(),
                              ),
                            ),
                          ),
                        )
                      : Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (widget.icon != null) ...[
                              Icon(
                                widget.icon,
                                color: _getTextColor(),
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                            ],
                            AnimationsService.fadeIn(
                              Text(
                                widget.text,
                                style: TextStyle(
                                  color: _getTextColor(),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    return AnimationsService.scaleIn(button);
  }

  LinearGradient? _getGradient() {
    if (widget.variant == AyaButtonVariant.text) return null;

    final colors = _getColors();
    if (widget.variant == AyaButtonVariant.outline) return null;

    return LinearGradient(
      colors: [
        _isHovered
            ? Color.fromARGB(
                230, colors.r.round(), colors.g.round(), colors.b.round())
            : colors,
        _isHovered
            ? Color.fromARGB(
                204, colors.r.round(), colors.g.round(), colors.b.round())
            : Color.fromARGB(
                230, colors.r.round(), colors.g.round(), colors.b.round()),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  Border? _getBorder() {
    if (widget.variant == AyaButtonVariant.text) return null;

    final colors = _getColors();
    if (widget.variant == AyaButtonVariant.outline) {
      return Border.all(
        color: _isHovered
            ? Color.fromARGB(
                204, colors.r.round(), colors.g.round(), colors.b.round())
            : Color.fromARGB(
                153, colors.r.round(), colors.g.round(), colors.b.round()),
        width: 2,
      );
    }

    return null;
  }

  List<BoxShadow>? _getShadow() {
    if (widget.variant == AyaButtonVariant.text ||
        widget.variant == AyaButtonVariant.outline) {
      return null;
    }

    final colors = _getColors();
    return [
      BoxShadow(
        color: _isHovered
            ? Color.fromARGB(
                77, colors.r.round(), colors.g.round(), colors.b.round())
            : Color.fromARGB(
                51, colors.r.round(), colors.g.round(), colors.b.round()),
        blurRadius: 8,
        offset: const Offset(0, 4),
      ),
    ];
  }

  Color _getColors() {
    switch (widget.variant) {
      case AyaButtonVariant.primary:
        return AyaColors.turquoise;
      case AyaButtonVariant.secondary:
        return AyaColors.lavenderVibrant;
      case AyaButtonVariant.outline:
      case AyaButtonVariant.text:
        return AyaColors.textPrimary;
    }
  }

  Color _getTextColor() {
    switch (widget.variant) {
      case AyaButtonVariant.primary:
      case AyaButtonVariant.secondary:
        return Colors.white;
      case AyaButtonVariant.outline:
      case AyaButtonVariant.text:
        return _getColors();
    }
  }
}

// Extension to make it easier to create common button layouts
extension AyaButtonBuilder on AyaButton {
  static AyaButton primary({
    required String text,
    required VoidCallback onPressed,
    IconData? icon,
    bool isLoading = false,
    bool isFullWidth = false,
  }) {
    return AyaButton(
      text: text,
      onPressed: onPressed,
      variant: AyaButtonVariant.primary,
      icon: icon,
      isLoading: isLoading,
      isFullWidth: isFullWidth,
    );
  }

  static AyaButton secondary({
    required String text,
    required VoidCallback onPressed,
    IconData? icon,
    bool isLoading = false,
    bool isFullWidth = false,
  }) {
    return AyaButton(
      text: text,
      onPressed: onPressed,
      variant: AyaButtonVariant.secondary,
      icon: icon,
      isLoading: isLoading,
      isFullWidth: isFullWidth,
    );
  }

  static AyaButton outline({
    required String text,
    required VoidCallback onPressed,
    IconData? icon,
    bool isLoading = false,
    bool isFullWidth = false,
  }) {
    return AyaButton(
      text: text,
      onPressed: onPressed,
      variant: AyaButtonVariant.outline,
      icon: icon,
      isLoading: isLoading,
      isFullWidth: isFullWidth,
    );
  }

  static AyaButton text({
    required String text,
    required VoidCallback onPressed,
    IconData? icon,
    bool isLoading = false,
    bool isFullWidth = false,
  }) {
    return AyaButton(
      text: text,
      onPressed: onPressed,
      variant: AyaButtonVariant.text,
      icon: icon,
      isLoading: isLoading,
      isFullWidth: isFullWidth,
    );
  }
}
