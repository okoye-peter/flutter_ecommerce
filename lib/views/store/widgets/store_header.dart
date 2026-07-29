import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/router/app_router.dart';
import 'package:ecommerce/core/widgets/brands/brand_card.dart';
import 'package:ecommerce/core/widgets/grids/grid_layout.dart';
import 'package:ecommerce/core/widgets/search/search_container.dart';
import 'package:ecommerce/core/widgets/texts/section_heading.dart';
import 'package:ecommerce/models/brand_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TStoreHeader extends StatelessWidget {
  const TStoreHeader({super.key, required this.brands});

  final List<BrandModel> brands;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        const SizedBox(height: TSizes.spaceBtwItem),
        GestureDetector(
          onTap: () => context.push(AppRoutes.search),
          child: const TSearchContainer(
            text: '',
            showBorder: true,
            showBackground: false,
            padding: EdgeInsets.zero,
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwSections),
        TSectionHeading(title: 'Feature Brands', onPressed: () => context.push(AppRoutes.brands)),
        const SizedBox(height: TSizes.spaceBtwItem / 1.5),
        TGridLayout(
          itemCount: brands.length,
          mainAxisExtent: 80,
          itemBuilder: (_, index) {
            final brand = brands[index];
            return TBrandCard(
              image: brand.image,
              title: brand.name,
              productCount: '${brand.productsCount ?? 0} products',
              onTap: () {},
            );
          },
        ),
      ],
    );
  }
}
