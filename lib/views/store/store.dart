import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/constants/image_strings.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/helpers/helper_functions.dart';
import 'package:ecommerce/core/widgets/appbar/appbar.dart';
import 'package:ecommerce/core/widgets/appbar/tab_bar.dart';
import 'package:ecommerce/core/widgets/cart/cart_counter_icon.dart';
import 'package:ecommerce/models/brand_model.dart';
import 'package:ecommerce/viewmodels/categories/category_viewmodel.dart';
import 'package:ecommerce/views/store/widgets/category_tab.dart';
import 'package:ecommerce/views/store/widgets/store_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StoreScreen extends ConsumerWidget {
  const StoreScreen({super.key});

  static final _brands = [
    BrandModel(
      id: '1',
      image: TImages.nikeBrandLogo,
      name: 'Nike',
      productsCount: 256,
    ),
    BrandModel(
      id: '2',
      image: TImages.adidasBrandLogo,
      name: 'Adidas',
      productsCount: 120,
    ),
    BrandModel(
      id: '3',
      image: TImages.jordanBrandLogo,
      name: 'Apple',
      productsCount: 85,
    ),
    BrandModel(
      id: '4',
      image: TImages.pumaBrandLogo,
      name: 'Puma',
      productsCount: 98,
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dark = THelperFunctions.isDarkMode(context);
    final featuredCategories = ref
        .read(categoriesProvider.notifier)
        .getFeatureCategories();

    return DefaultTabController(
      length: featuredCategories.length,
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
                tabs: featuredCategories.map((cat) => Tab(child: Text(cat.name))).toList(),
              ),
            ),
          ],
          body: TabBarView(
            children: featuredCategories.map((cat) => TCategoryTab(
                brand: _brands[0],
                imgUrl1: TImages.productImage14,
                imgUrl2: TImages.productImage15,
                imgUrl3: TImages.productImage16,
               )).toList()
          ),
        ),
      ),
    );
  }
}
