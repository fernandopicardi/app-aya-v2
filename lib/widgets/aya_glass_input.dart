import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app_aya_v2/core/theme/app_theme.dart';
import 'package:app_aya_v2/widgets/aya_glass_container.dart';

class AyaGlassInput extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? errorText;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final bool enabled;
  final FocusNode? focusNode;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final bool autofocus;
  final Widget? prefix;
  final Widget? suffix;
  final double borderRadius;
  final double blurRadius;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Color? backgroundColor;
  final bool showInnerBorder;
  final bool showTopHighlight;
  final bool animate;
  final Duration animationDuration;
  final Curve animationCurve;

  const AyaGlassInput({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.errorText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.inputFormatters,
    this.enabled = true,
    this.focusNode,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.autofocus = false,
    this.prefix,
    this.suffix,
    this.borderRadius = 12.0,
    this.blurRadius = 10.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.margin = EdgeInsets.zero,
    this.backgroundColor,
    this.showInnerBorder = true,
    this.showTopHighlight = true,
    this.animate = true,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
  });

  @override
  Widget build(BuildContext context) {
    return AyaGlassContainer(
      borderRadius: borderRadius,
      blurRadius: blurRadius,
      padding: padding,
      margin: margin,
      backgroundColor: backgroundColor,
      showInnerBorder: showInnerBorder,
      showTopHighlight: showTopHighlight,
      animate: animate,
      animationDuration: animationDuration,
      animationCurve: animationCurve,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        onSubmitted: onSubmitted,
        inputFormatters: inputFormatters,
        enabled: enabled,
        focusNode: focusNode,
        maxLines: maxLines,
        minLines: minLines,
        maxLength: maxLength,
        autofocus: autofocus,
        style: const TextStyle(
          color: AyaColors.textPrimary,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          errorText: errorText,
          prefixIcon: prefix,
          suffixIcon: suffix,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              color: AyaColors.glassBorder,
              width: 1.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              color: AyaColors.glassBorder,
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              color: AyaColors.lavenderVibrant,
              width: 1.5,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              color: Colors.red.shade300,
              width: 1.5,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              color: Colors.red.shade300,
              width: 1.5,
            ),
          ),
          filled: true,
          fillColor: Colors.transparent,
          labelStyle: TextStyle(
            color: AyaColors.textPrimary.withValues(alpha: 0.6),
            fontSize: 16,
          ),
          hintStyle: TextStyle(
            color: AyaColors.textPrimary.withValues(alpha: 0.5),
            fontSize: 16,
          ),
          errorStyle: TextStyle(
            color: Colors.red.shade300,
            fontSize: 14,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }
}

class AyaGlassPasswordInput extends StatefulWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? errorText;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final bool enabled;
  final FocusNode? focusNode;
  final int? maxLength;
  final bool autofocus;
  final double borderRadius;
  final double blurRadius;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Color? backgroundColor;
  final bool showInnerBorder;
  final bool showTopHighlight;
  final bool animate;
  final Duration animationDuration;
  final Curve animationCurve;

  const AyaGlassPasswordInput({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.errorText,
    this.textInputAction = TextInputAction.next,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.inputFormatters,
    this.enabled = true,
    this.focusNode,
    this.maxLength,
    this.autofocus = false,
    this.borderRadius = 12.0,
    this.blurRadius = 10.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.margin = EdgeInsets.zero,
    this.backgroundColor,
    this.showInnerBorder = true,
    this.showTopHighlight = true,
    this.animate = true,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
  });

  @override
  State<AyaGlassPasswordInput> createState() => _AyaGlassPasswordInputState();
}

class _AyaGlassPasswordInputState extends State<AyaGlassPasswordInput> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return AyaGlassInput(
      controller: widget.controller,
      label: widget.label,
      hint: widget.hint,
      errorText: widget.errorText,
      obscureText: _obscureText,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: widget.textInputAction,
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingComplete,
      onSubmitted: widget.onSubmitted,
      inputFormatters: widget.inputFormatters,
      enabled: widget.enabled,
      focusNode: widget.focusNode,
      maxLength: widget.maxLength,
      autofocus: widget.autofocus,
      borderRadius: widget.borderRadius,
      blurRadius: widget.blurRadius,
      padding: widget.padding,
      margin: widget.margin,
      backgroundColor: widget.backgroundColor,
      showInnerBorder: widget.showInnerBorder,
      showTopHighlight: widget.showTopHighlight,
      animate: widget.animate,
      animationDuration: widget.animationDuration,
      animationCurve: widget.animationCurve,
      suffix: IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility : Icons.visibility_off,
          color: AyaColors.textPrimary.withValues(alpha: 0.6),
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      ),
    );
  }
}
