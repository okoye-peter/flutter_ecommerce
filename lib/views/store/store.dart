import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/constants/image_strings.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/helpers/helper_functions.dart';
import 'package:ecommerce/core/widgets/appbar/appbar.dart';
import 'package:ecommerce/core/widgets/appbar/tab_bar.dart';
import 'package:ecommerce/core/widgets/cart/cart_counter_icon.dart';
import 'package:ecommerce/models/brand_model.dart';
import 'package:ecommerce/views/store/widgets/category_tab.dart';
import 'package:ecommerce/views/store/widgets/store_header.dart';
import 'package:flutter/material.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  static const _brands = [
    BrandModel(image: TImages.nikeBrandLogo, title: 'Nike', products: '256 products'),
    BrandModel(image: TImages.adidasBrandLogo, title: 'Adidas', products: '120 products'),
    BrandModel(image: TImages.jordanBrandLogo, title: 'Apple', products: '85 products'),
    BrandModel(image: TImages.pumaBrandLogo, title: 'Puma', products: '98 products'),
  ];

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: TAppBar(
          title: Text('Store', style: Theme.of(context).textTheme.headlineMedium),
          actions: [
            TCartCounterIcon(onPressed: () {}, iconColor: TColors.darkGrey),
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (_, _) => [
            SliverAppBar(
              pinned: true,
              floating: true,
              backgroundColor: dark ? TColors.black : TColors.white,
              expandedHeight: 430,
              flexibleSpace: Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: TStoreHeader(brands: _brands),
              ),
              bottom: TTabBar(
                padding: const EdgeInsets.only(left: TSizes.defaultSpace / 2),
                tabs: const [
                  Tab(child: Text('Sport')),
                  Tab(child: Text('Furniture')),
                  Tab(child: Text('Electronic')),
                  Tab(child: Text('Clothes')),
                  Tab(child: Text('Cosmetics')),
                ],
              ),
            ),
          ],
          body: TabBarView(
            children: [
              TCategoryTab(brand: _brands[0], imgUrl1: TImages.productImage14, imgUrl2: TImages.productImage15, imgUrl3: TImages.productImage16),
              TCategoryTab(brand: _brands[1], imgUrl1: TImages.productImage3, imgUrl2: TImages.productImage4, imgUrl3: TImages.productImage5),
              TCategoryTab(brand: _brands[2], imgUrl1: TImages.productImage13, imgUrl2: TImages.productImage12, imgUrl3: TImages.productImage11),
              TCategoryTab(brand: _brands[3], imgUrl1: TImages.productImage16, imgUrl2: TImages.productImage9, imgUrl3: TImages.productImage8),
              TCategoryTab(brand: _brands[0], imgUrl1: TImages.productImage6, imgUrl2: TImages.productImage7, imgUrl3: TImages.productImage8),
            ],
          ),
        ),
      ),
    );
  }

  
}
