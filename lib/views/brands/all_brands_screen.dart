import 'package:ecommerce/core/constants/image_strings.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/router/app_router.dart';
import 'package:ecommerce/core/widgets/appbar/appbar.dart';
import 'package:ecommerce/core/widgets/brands/brand_card.dart';
import 'package:ecommerce/core/widgets/grids/grid_layout.dart';
import 'package:ecommerce/core/widgets/texts/section_heading.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(title: Text('Brands'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // - Heading
              TSectionHeading(title: 'Brands'),
              const SizedBox(height: TSizes.spaceBtwItem),

              // - Brands
              TGridLayout(
                itemCount: 10,
                mainAxisExtent: 80.0,
                itemBuilder: (context, index) => TBrandCard(
                  image: TImages.categoryClothing,
                  title: 'Nike',
                  productCount: '15 products',
                  onTap: () => context.push(AppRoutes.brandProducts('123')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
