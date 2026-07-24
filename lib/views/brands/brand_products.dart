import 'package:ecommerce/core/constants/image_strings.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/widgets/appbar/appbar.dart';
import 'package:ecommerce/core/widgets/brands/brand_card.dart';
import 'package:ecommerce/core/widgets/products/sortable_products.dart';
import 'package:flutter/material.dart';

class BrandProductsScreen extends StatelessWidget {
  const BrandProductsScreen({super.key, required this.brandId});

  final String brandId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(title: Text('Nike'), showBackArrow: true,),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Brand Details
              TBrandCard(image: TImages.nikeBrandLogo, title: 'Nike', productCount: '23 products', showBorder: true,),
              SizedBox(height: TSizes.spaceBtwSections,),
        
              TSortableProducts()
            ],
          ),
        ),
      ),
    );
  }
}