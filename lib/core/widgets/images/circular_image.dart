import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/widgets/loaders/shimmer_effect.dart';
import 'package:flutter/material.dart';

class TCircularImage extends StatelessWidget {
  const TCircularImage({
    super.key,
    this.width = 56,
    this.height = 56,
    this.overlayColor,
    this.backgroundColor,
    required this.image,
    this.fit = BoxFit.cover,
    this.padding = TSizes.sm,
    this.isNetworkImage = false,
  });

  final BoxFit? fit;
  final String image;
  final bool isNetworkImage;
  final Color? overlayColor;
  final Color? backgroundColor;
  final double width, height, padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),

      color: backgroundColor,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Center(
          child: isNetworkImage
            ? CachedNetworkImage(
                imageUrl: image,
                fit: fit,
                color: overlayColor,
                placeholder: (context, url) =>
                    TShimmerEffect(width: width, height: height, radius: 100),
                errorWidget: (context, url, error) => const Icon(Icons.person),
              )
            : Image(fit: fit, color: overlayColor, image: AssetImage(image)),
        ),
      )
    );
  }
}
