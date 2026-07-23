import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/constants/image_strings.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/router/app_router.dart';
import 'package:ecommerce/core/widgets/curved_edges/primary_header_container.dart';
import 'package:ecommerce/core/widgets/products/product_card_vertical.dart';
import 'package:ecommerce/core/widgets/products/product_grid_view.dart';
import 'package:ecommerce/core/widgets/search/search_container.dart';
import 'package:ecommerce/core/widgets/texts/section_heading.dart';
import 'package:ecommerce/viewmodels/auth/user_controller.dart';
import 'package:ecommerce/views/home/widgets/home_app_bar.dart';
import 'package:ecommerce/views/home/widgets/home_categories.dart';
import 'package:ecommerce/views/home/widgets/promo_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

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
                        const SizedBox(height: TSizes.spaceBtwSections),
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

                  TSectionHeading(
                    title: 'Popular Products',
                    // showActionButton: false,
                    onPressed: () => context.push(AppRoutes.products),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  // products
                  TProductGridView(
                    itemBuilder: (BuildContext context, int index) =>
                        TProductCardVertical(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
