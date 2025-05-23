import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../core/theme/app_theme.dart';

class AyaImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final bool showLoadingIndicator;
  final Widget? placeholder;
  final Widget? errorWidget;

  const AyaImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.showLoadingIndicator = true,
    this.placeholder,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    Widget image = CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) =>
          placeholder ??
          (showLoadingIndicator
              ? Container(
                  color: AyaColors.lavenderSoft,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: AyaColors.turquoise,
                    ),
                  ),
                )
              : Container(color: AyaColors.lavenderSoft)),
      errorWidget: (context, url, error) =>
          errorWidget ??
          Container(
            color: AyaColors.lavenderSoft,
            child: const Icon(
              Icons.image_not_supported,
              color: AyaColors.textPrimary,
              size: 48,
            ),
          ),
    );

    if (borderRadius != null) {
      image = ClipRRect(
        borderRadius: borderRadius!,
        child: image,
      );
    }

    return image;
  }
}
