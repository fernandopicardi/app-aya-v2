import 'package:flutter/material.dart';
import 'package:app_aya_v2/core/theme/app_theme.dart';
import '../core/services/animations_service.dart';

enum AyaLoadingVariant {
  spinner,
  dots,
  pulse,
}

class AyaLoading extends StatelessWidget {
  final AyaLoadingVariant variant;
  final double size;
  final Color? color;
  final String? message;

  const AyaLoading({
    super.key,
    this.variant = AyaLoadingVariant.spinner,
    this.size = 24,
    this.color,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimationsService.pulseLoading(
          _buildLoadingIndicator(),
          duration: const Duration(milliseconds: 1500),
        ),
        if (message != null) ...[
          const SizedBox(height: 16),
          AnimationsService.fadeIn(
            Text(
              message!,
              style: const TextStyle(
                color: AyaColors.textPrimary80,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildLoadingIndicator() {
    final effectiveColor = color ?? AyaColors.turquoise;

    switch (variant) {
      case AyaLoadingVariant.spinner:
        return SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(effectiveColor),
          ),
        );

      case AyaLoadingVariant.dots:
        return SizedBox(
          width: size * 2,
          height: size,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              3,
              (index) => _buildDot(index, effectiveColor),
            ),
          ),
        );

      case AyaLoadingVariant.pulse:
        return SizedBox(
          width: size,
          height: size,
          child: _PulseAnimation(
            color: effectiveColor,
          ),
        );
    }
  }

  Widget _buildDot(int index, Color color) {
    return AnimationsService.pulseLoading(
      Container(
        width: size / 3,
        height: size / 3,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
      duration: Duration(milliseconds: 1500 + (index * 200)),
    );
  }
}

class _PulseAnimation extends StatefulWidget {
  final Color color;

  const _PulseAnimation({required this.color});

  @override
  State<_PulseAnimation> createState() => _PulseAnimationState();
}

class _PulseAnimationState extends State<_PulseAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.8, end: 1.0).animate(
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

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value,
          child: Container(
            decoration: BoxDecoration(
              color: widget.color,
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }
}
