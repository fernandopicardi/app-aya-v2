import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/aya_theme.dart';
import '../core/services/animations_service.dart';

enum AyaInputVariant {
  text,
  password,
  email,
  number,
  multiline,
}

class AyaInput extends StatefulWidget {
  final String? label;
  final String? hint;
  final String? error;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final Widget? prefix;
  final Widget? suffix;
  final bool enabled;
  final bool autofocus;
  final int? maxLines;
  final int? minLines;
  final bool expands;
  final TextAlign textAlign;
  final FocusNode? focusNode;
  final EdgeInsetsGeometry? contentPadding;

  const AyaInput({
    Key? key,
    this.label,
    this.hint,
    this.error,
    this.obscureText = false,
    this.controller,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.prefix,
    this.suffix,
    this.enabled = true,
    this.autofocus = false,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.textAlign = TextAlign.start,
    this.focusNode,
    this.contentPadding,
  }) : super(key: key);

  @override
  State<AyaInput> createState() => _AyaInputState();
}

class _AyaInputState extends State<AyaInput> {
  late FocusNode _focusNode;
  bool _isFocused = false;
  bool _isHovered = false;
  bool _showPassword = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.label != null) ...[
            AnimationsService.fadeIn(
              Text(
                widget.label!,
                style: const TextStyle(
                  color: AyaColors.textPrimary80,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
          AnimationsService.scaleIn(
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AyaColors.backgroundGradientEnd,
                    Color.fromRGBO(71, 76, 114,
                        0.95), // AyaColors.backgroundGradientEnd with 95% opacity
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _getBorderColor(),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: _getShadowColor(),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextFormField(
                controller: widget.controller,
                focusNode: _focusNode,
                obscureText: widget.obscureText && !_showPassword,
                keyboardType: widget.keyboardType,
                inputFormatters: widget.inputFormatters,
                validator: widget.validator,
                onChanged: widget.onChanged,
                onFieldSubmitted: widget.onSubmitted,
                enabled: widget.enabled,
                autofocus: widget.autofocus,
                maxLines: widget.maxLines,
                minLines: widget.minLines,
                expands: widget.expands,
                textAlign: widget.textAlign,
                style: const TextStyle(
                  color: AyaColors.textPrimary,
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  hintText: widget.hint,
                  hintStyle: const TextStyle(
                    color: AyaColors.textPrimary40,
                    fontSize: 16,
                  ),
                  prefixIcon: widget.prefix,
                  suffixIcon: _buildSuffix(),
                  contentPadding: widget.contentPadding ??
                      const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ),
            ),
          ),
          if (widget.error != null) ...[
            const SizedBox(height: 8),
            AnimationsService.fadeIn(
              Text(
                widget.error!,
                style: TextStyle(
                  color: Colors.red.shade400,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget? _buildSuffix() {
    if (widget.obscureText) {
      return IconButton(
        icon: const Icon(
          Icons.visibility_off,
          color: AyaColors.textPrimary60,
        ),
        onPressed: () {
          setState(() {
            _showPassword = !_showPassword;
          });
        },
      );
    }
    return widget.suffix;
  }

  Color _getBorderColor() {
    if (!widget.enabled) {
      return AyaColors.textPrimary40;
    }
    if (widget.error != null) {
      return Colors.red.shade400;
    }
    if (_isFocused) {
      return AyaColors.turquoise;
    }
    if (_isHovered) {
      return AyaColors.textPrimary40;
    }
    return AyaColors.textPrimary40;
  }

  Color _getShadowColor() {
    if (!widget.enabled) {
      return Colors.transparent;
    }
    if (widget.error != null) {
      return Color.fromRGBO(
          236, 93, 93, 0.2); // Colors.red.shade400 with 20% opacity
    }
    if (_isFocused) {
      return Color.fromRGBO(
          120, 199, 180, 0.2); // AyaColors.turquoise with 20% opacity
    }
    if (_isHovered) {
      return AyaColors.overlayDark;
    }
    return Colors.transparent;
  }
}

// Extension to make it easier to create common input layouts
extension AyaInputBuilder on AyaInput {
  static AyaInput text({
    String? label,
    String? hint,
    String? error,
    TextEditingController? controller,
    void Function(String)? onChanged,
    void Function(String)? onSubmitted,
    Widget? prefix,
    Widget? suffix,
    bool enabled = true,
    bool autofocus = false,
    FocusNode? focusNode,
  }) {
    return AyaInput(
      label: label,
      hint: hint,
      error: error,
      controller: controller,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      prefix: prefix,
      suffix: suffix,
      enabled: enabled,
      autofocus: autofocus,
      focusNode: focusNode,
    );
  }

  static AyaInput password({
    String? label,
    String? hint,
    String? error,
    TextEditingController? controller,
    void Function(String)? onChanged,
    void Function(String)? onSubmitted,
    Widget? prefix,
    bool enabled = true,
    bool autofocus = false,
    FocusNode? focusNode,
  }) {
    return AyaInput(
      label: label,
      hint: hint,
      error: error,
      obscureText: true,
      controller: controller,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      prefix: prefix,
      enabled: enabled,
      autofocus: autofocus,
      focusNode: focusNode,
    );
  }

  static AyaInput email({
    String? label,
    String? hint,
    String? error,
    TextEditingController? controller,
    void Function(String)? onChanged,
    void Function(String)? onSubmitted,
    Widget? prefix,
    bool enabled = true,
    bool autofocus = false,
    FocusNode? focusNode,
  }) {
    return AyaInput(
      label: label,
      hint: hint,
      error: error,
      keyboardType: TextInputType.emailAddress,
      controller: controller,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      prefix: prefix,
      enabled: enabled,
      autofocus: autofocus,
      focusNode: focusNode,
    );
  }

  static AyaInput number({
    String? label,
    String? hint,
    String? error,
    TextEditingController? controller,
    void Function(String)? onChanged,
    void Function(String)? onSubmitted,
    Widget? prefix,
    bool enabled = true,
    bool autofocus = false,
    FocusNode? focusNode,
  }) {
    return AyaInput(
      label: label,
      hint: hint,
      error: error,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      controller: controller,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      prefix: prefix,
      enabled: enabled,
      autofocus: autofocus,
      focusNode: focusNode,
    );
  }

  static AyaInput multiline({
    String? label,
    String? hint,
    String? error,
    TextEditingController? controller,
    void Function(String)? onChanged,
    void Function(String)? onSubmitted,
    Widget? prefix,
    bool enabled = true,
    bool autofocus = false,
    FocusNode? focusNode,
  }) {
    return AyaInput(
      label: label,
      hint: hint,
      error: error,
      maxLines: null,
      minLines: 3,
      keyboardType: TextInputType.multiline,
      controller: controller,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      prefix: prefix,
      enabled: enabled,
      autofocus: autofocus,
      focusNode: focusNode,
    );
  }
}
