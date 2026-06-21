import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/constants/enums.dart';
import 'package:ecommerce/core/constants/image_strings.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/helpers/helper_functions.dart';
import 'package:ecommerce/core/widgets/appbar/appbar.dart';
import 'package:ecommerce/core/widgets/appbar/tab_bar.dart';
import 'package:ecommerce/core/widgets/cart/cart_counter_icon.dart';
import 'package:ecommerce/core/widgets/grids/grid_layout.dart';
import 'package:ecommerce/core/widgets/brands/brand_card.dart';
import 'package:ecommerce/core/widgets/images/circular_image.dart';

import 'package:ecommerce/core/widgets/products/rounded_container.dart';
import 'package:ecommerce/core/widgets/search/search_container.dart';
import 'package:ecommerce/core/widgets/texts/brand_title_with_verified_icon.dart';
import 'package:ecommerce/core/widgets/texts/section_heading.dart';
import 'package:flutter/material.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    const brands = [
      {
        'image': TImages.nikeBrandLogo,
        'title': 'Nike',
        'products': '256 products',
      },
      {
        'image': TImages.adidasBrandLogo,
        'title': 'Adidas',
        'products': '120 products',
      },
      {
        'image': TImages.jordanBrandLogo,
        'title': 'Apple',
        'products': '85 products',
      },
      {
        'image': TImages.pumaBrandLogo,
        'title': 'Puma',
        'products': '98 products',
      },
    ];

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: TAppBar(
          title: Text(
            'Store',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [
            TCartCounterIcon(onPressed: () {}, iconColor: TColors.darkGrey),
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) => [
            SliverAppBar(
              pinned: true,
              floating: true,
              backgroundColor: dark ? TColors.black : TColors.white,
              expandedHeight: 430,
              flexibleSpace: Padding(
                padding: EdgeInsets.all(TSizes.defaultSpace),
                child: ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    const SizedBox(height: TSizes.spaceBtwItem),
                    const TSearchContainer(
                      text: '',
                      showBorder: true,
                      showBackground: false,
                      padding: EdgeInsets.zero,
                    ),
                    const SizedBox(height: TSizes.spaceBtwSections),

                    // Featured Brands
                    TSectionHeading(title: 'Feature Brands', onPressed: () {}),

                    const SizedBox(height: TSizes.spaceBtwItem / 1.5),

                    TGridLayout(
                      itemCount: 4,
                      mainAxisExtent: 80,
                      itemBuilder: (_, index) {
                        final brand = brands[index];

                        return TBrandCard(
                          image: brand['image']!,
                          title: brand['title']!,
                          productCount: brand['products']!,
                          onTap: () {},
                        );
                      },
                    ),
                  ],
                ),
              ),
              bottom: TTabBar(
                tabs: [
                  Tab(child: Text('Sport')),
                  Tab(child: Text('Furniture')),
                  Tab(child: Text('Electronic')),
                  Tab(child: Text('Clothes')),
                  Tab(child: Text('Cosmetics')),
                ]
              )
              // TabBar(
              //   isScrollable: true,
              //   tabAlignment: TabAlignment.start,
              //   padding: EdgeInsets.only(left: TSizes.sm),
              //   indicatorColor: TColors.primary,
              //   labelColor: dark ? TColors.white : TColors.black,
              //   unselectedLabelColor: TColors.darkGrey,
              //   tabs: [
              //     Tab(child: Text('Sport')),
              //     Tab(child: Text('Furniture')),
              //     Tab(child: Text('Electronic')),
              //     Tab(child: Text('Clothes')),
              //     Tab(child: Text('Cosmetics')),
              //   ],
              // ),
            ),

            // Tabs
          ],
          body: TabBarView(
            children: [
              Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: Column(
                  children: [
                    TRoundedContainer(
                      showBorder: true,
                      borderColor: TColors.darkGrey,
                      padding: const EdgeInsets.all(TSizes.md),
                      margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItem),
                      child: Column(
                        children: [
                          // brand with products counts
                          TBrandCard(image: brands[0]['image']!, title: brands[0]['title']!, productCount: brands.length.toString(), showBorder: false,),

                          Row(
                            children: [
                              Expanded(
                                child: TRoundedContainer(
                                  height: 100,
                                  backgroundColor: dark ? TColors.darkGrey : TColors.light,
                                  margin: const EdgeInsets.only(right: TSizes.sm),
                                  child: Image(image: AssetImage(TImages.productImage15), fit: BoxFit.contain,),
                                ),
                              ),
                              Expanded(
                                child: TRoundedContainer(
                                  height: 100,
                                  backgroundColor: dark ? TColors.darkGrey : TColors.light,
                                  margin: const EdgeInsets.only(right: TSizes.sm),
                                  child: Image(image: AssetImage(TImages.productImage16), fit: BoxFit.contain,),
                                ),
                              ),
                              Expanded(
                                child: TRoundedContainer(
                                  height: 100,
                                  backgroundColor: dark ? TColors.darkGrey : TColors.light,
                                  margin: const EdgeInsets.only(right: TSizes.sm),
                                  child: Image(image: AssetImage(TImages.productImage14), fit: BoxFit.contain,),
                                ),
                              ),
                            ],
                          )
                          // brand top 3 products Images
                        ],
                      ),
                    )
                  ],
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
