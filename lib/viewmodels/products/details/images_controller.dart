import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'images_controller.g.dart';

@riverpod
List<String> productImages(Ref ref, ProductModel product) {
  return {
    product.thumbnail,
    ...?product.images,
    ...?product.productVariations?.map((variation) => variation.image),
  }.toList();
}

class ImagesState {
  ImagesState({required this.selectedProductImage});

  final String selectedProductImage;

  ImagesState copyWith({String? selectedProductImage}) {
    return ImagesState(
      selectedProductImage: selectedProductImage ?? this.selectedProductImage,
    );
  }
}

@riverpod
class ImagesController extends _$ImagesController {
  @override
  ImagesState build(String defaultImage) {
    return ImagesState(selectedProductImage: defaultImage);
  }

  void selectImage(String image) {
    state = state.copyWith(selectedProductImage: image);
  }

  void showEnlargeImage(BuildContext context, String image) {
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => Dialog.fullscreen(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: TSizes.defaultSpace * 2, horizontal: TSizes.defaultSpace),
                child: CachedNetworkImage(imageUrl: image),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 150,
                  child: OutlinedButton(onPressed: () => Navigator.of(context).pop(), child: const Text('close')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
