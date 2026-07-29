import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/styles/shadow.dart';
import 'package:ecommerce/core/widgets/appbar/appbar.dart';
import 'package:ecommerce/core/widgets/curved_edges/curved_edge_widget.dart';
import 'package:ecommerce/core/widgets/icons/circular_icon.dart';
import 'package:ecommerce/core/widgets/images/rounded_image.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/viewmodels/products/details/images_controller.dart';
import 'package:ecommerce/viewmodels/products/details/variation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TProductImagesSlider extends ConsumerStatefulWidget {
  const TProductImagesSlider({
    super.key,
    required this.dark,
    required this.product,
  });

  final bool dark;
  final ProductModel product;

  @override
  ConsumerState<TProductImagesSlider> createState() => _TProductImagesSliderState();
}

class _TProductImagesSliderState extends ConsumerState<TProductImagesSlider> {

  // List<String> get _images {
  //   final images = widget.product.images ?? [];
  //   return images.isNotEmpty ? images : [widget.product.thumbnail];
  // }

  /// Tapping a thumbnail always swaps the displayed photo; if that photo
  /// also belongs to a specific variation, select it too so the price and
  /// attribute chips stay in sync, not just the image.
  void _selectImage(String image) {
    ref.read(imagesControllerProvider(widget.product.thumbnail).notifier).selectImage(image);

    for (final variation in widget.product.productVariations ?? const []) {
      if (variation.image.isNotEmpty && variation.image == image) {
        ref.read(variationControllerProvider.notifier).selectVariation(variation);
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final images = ref.watch(productImagesProvider(widget.product));
    final selectedImage = ref.watch(imagesControllerProvider(widget.product.thumbnail));
    final imageController = ref.read(
      imagesControllerProvider(widget.product.thumbnail).notifier,
    );

    // Swap the displayed image to match the variation the user just picked.
    ref.listen(variationControllerProvider, (previous, next) {
      final image = next.resolvedVariation?.image;
      if (image != null &&
          image.isNotEmpty &&
          image != previous?.resolvedVariation?.image) {
        imageController.selectImage(image);
      }
    });

    return TCurvedEdgeWidget(
      child: Container(
        color: widget.dark ? TColors.darkGrey : TColors.light,
        child: Stack(
          children: [
            SizedBox(
              height: 400,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(TSizes.productImageRadius * 2),
                child:  Center(
                  child: GestureDetector(
                    onTap: () =>  imageController.showEnlargeImage(context, selectedImage.selectedProductImage),
                    child: CachedNetworkImage(
                      imageUrl: selectedImage.selectedProductImage,
                      progressIndicatorBuilder: (_, __, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress, color: TColors.primary,),
                    ),
                  ),
                ),
                // child: TRoundedImage(
                //   imageUrl: selectedImage.selectedProductImage,
                //   isNetworkImage: true,
                //   width: double.infinity,
                //   height: double.infinity,
                //   fit: BoxFit.contain,
                //   applyImageRadius: false,
                //   backgroundColor: Colors.transparent,
                //   onPressed: ,
                //   // onPressed: () => ,
                // ),
              ),
            ),

            if (images.length > 1)
              Positioned(
                right: 0,
                bottom: 30,
                left: TSizes.defaultSpace,
                child: SizedBox(
                  height: 80,
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (_, index) => GestureDetector(
                      onTap: () => _selectImage(images[index]),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(TSizes.md),
                          boxShadow: [TShadowStyle.horizontalProductShadow],
                          // border: images[index] == selectedImage.selectedProductImage
                          //     ? Border.all(color: TColors.primary, width: 2)
                          //     : null,
                        ),
                        child: TRoundedImage(
                          imageUrl: images[index],
                          isNetworkImage: true,
                          width: 80,
                          height: 80,
                          fit: BoxFit.contain,
                          backgroundColor: widget.dark
                              ? TColors.dark
                              : TColors.white,
                          padding: const EdgeInsets.all(TSizes.sm),
                          border: Border.all(color: selectedImage.selectedProductImage == images[index] ? Colors.grey.shade500 : Colors.transparent),
                        ),
                      ),
                    ),
                    separatorBuilder: (_, _) =>
                        const SizedBox(width: TSizes.spaceBtwItem),
                    itemCount: images.length,
                  ),
                ),
              ),

            Padding(
              padding: const EdgeInsets.only(top: TSizes.spaceBtwItem / 3),
              child: TAppBar(
                showBackArrow: true,
                horizontalPadding: 0,
                actions: [
                  TCircularIcon(icon: Icons.favorite, color: Colors.red),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
