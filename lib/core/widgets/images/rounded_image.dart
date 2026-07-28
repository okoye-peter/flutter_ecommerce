import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/widgets/loaders/shimmer_effect.dart';
import 'package:flutter/material.dart';

class TRoundedImage extends StatelessWidget {
  const TRoundedImage({
    super.key,
    this.width,
    this.height,
    required this.imageUrl,
    this.applyImageRadius = true,
    this.border,
    this.backgroundColor = TColors.light,
    this.fit,
    this.padding,
    this.isNetworkImage = false,
    this.onPressed,
    this.borderRadius = TSizes.md,
  });

  final double? width, height;
  final double borderRadius;
  final String imageUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          border: border,
          color: backgroundColor,
        ),
        child: ClipRRect(
          borderRadius: applyImageRadius
              ? BorderRadius.circular(borderRadius)
              : BorderRadius.zero,
          child: isNetworkImage
              ? CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: fit,
                  placeholder: (context, url) => TShimmerEffect(
                    width: width ?? double.infinity,
                    height: height ?? double.infinity,
                    radius: borderRadius,
                  ),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.image_not_supported_outlined),
                )
              : Image(image: AssetImage(imageUrl), fit: fit),
        ),
      ),
    );
  }
}
