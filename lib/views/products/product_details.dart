import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/helpers/helper_functions.dart';
import 'package:ecommerce/views/products/widgets/product_images_slider.dart';
import 'package:ecommerce/views/products/widgets/product_rating_and_share.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // product image slider
            TProductImagesSlider(dark: dark),

            Padding(
              padding: EdgeInsets.only(right: TSizes.defaultSpace, left: TSizes.defaultSpace, bottom: TSizes.defaultSpace),
              child: Column(
                children: [
                  // - Rating & Share
                  TRatingAndShare()
                  
                  // - Price, Title, Stock, & Brand
                  // - Attributes
                  // - Checkout Button
                  // - Description
                  // - Reviews
                ]
              ),
            )
          ]
        ),
      ),
    );
  }
}
