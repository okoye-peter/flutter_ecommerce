import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/styles/shadow.dart';
import 'package:ecommerce/core/widgets/appbar/appbar.dart';
import 'package:ecommerce/core/widgets/curved_edges/curved_edge_widget.dart';
import 'package:ecommerce/core/widgets/icons/circular_icon.dart';
import 'package:ecommerce/core/widgets/images/rounded_image.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/viewmodels/images/images_controller.dart';
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

  @override
  Widget build(BuildContext context) {
    final images = ref.watch(productImagesProvider(widget.product));
    final selectedImage = ref.watch(imagesControllerProvider);
    final imageController = ref.read(imagesControllerProvider.notifier);

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
                child: TRoundedImage(
                  imageUrl: selectedImage.selectedProductImage,
                  isNetworkImage: true,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.contain,
                  applyImageRadius: false,
                  backgroundColor: Colors.transparent,
                  // onPressed: () => ,
                ),
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
                      onTap: () => imageController.selectImage(images[index]),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(TSizes.md),
                          boxShadow: [TShadowStyle.horizontalProductShadow],
                          border: images[index] == selectedImage.selectedProductImage
                              ? Border.all(color: TColors.primary, width: 2)
                              : null,
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
                          border: Border.all(color: selectedImage.selectedProductImage == images[index] ? TColors.primary : Colors.transparent),
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
              padding: const EdgeInsets.only(top: TSizes.spaceBtwItem),
              child: TAppBar(
                showBackArrow: true,
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
