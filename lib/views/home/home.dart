import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/constants/image_strings.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/widgets/curved_edges/circular_container.dart';
import 'package:ecommerce/core/widgets/curved_edges/curved_edge_widget.dart';
import 'package:ecommerce/core/widgets/products/product_card_vertical.dart';
import 'package:ecommerce/core/widgets/products/product_grid_view.dart';
import 'package:ecommerce/core/widgets/search/search_container.dart';
import 'package:ecommerce/core/widgets/texts/section_heading.dart';
import 'package:ecommerce/views/home/widgets/home_app_bar.dart';
import 'package:ecommerce/views/home/widgets/home_categories.dart';
import 'package:ecommerce/views/home/widgets/promo_slider.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  // AppBar
                  const THomeAppBar(),

                  const SizedBox(height: TSizes.spaceBtwSections),

                  // search bar
                  const TSearchContainer(text: 'Search in store'),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  // categories
                  Padding(
                    padding: EdgeInsets.only(left: TSizes.defaultSpace),
                    child: Column(
                      children: [
                        // heading
                        TSectionHeading(
                          title: 'Popular Categories',
                          showActionButton: false,
                          textColor: TColors.white,
                          onPressed: () {},
                        ),
                        SizedBox(height: TSizes.spaceBtwItem),

                        // categories
                        THomeCategories(),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // carousel
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  const TPromoSlider(
                    banners: [
                      TImages.promoBanner1,
                      TImages.promoBanner2,
                      TImages.promoBanner3,
                      TImages.promoBanner6,
                    ],
                  ),

                  const SizedBox(height: TSizes.spaceBtwSections),

                  // products
                  TProductGridView(itemBuilder: (BuildContext context, int index) => TProductCardVertical(),)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TPrimaryHeaderContainer extends StatelessWidget {
  const TPrimaryHeaderContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TCurvedEdgeWidget(
      child: Container(
        color: TColors.primary,
        padding: const EdgeInsets.all(0),
        child: SizedBox(
          height: 400,
          child: Stack(
            children: [
              Positioned(
                top: -150,
                right: -250,
                child: TCircularContainer(
                  backgroundColor: TColors.textWhite.withAlpha(26),
                ),
              ),
              Positioned(
                top: 100,
                right: -300,
                child: TCircularContainer(
                  backgroundColor: TColors.textWhite.withAlpha(26),
                ),
              ),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
