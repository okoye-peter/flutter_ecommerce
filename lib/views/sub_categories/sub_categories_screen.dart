import 'package:ecommerce/core/constants/image_strings.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/widgets/appbar/appbar.dart';
import 'package:ecommerce/core/widgets/images/rounded_image.dart';
import 'package:ecommerce/core/widgets/products/product_card_horizontal.dart';
import 'package:ecommerce/core/widgets/texts/section_heading.dart';
import 'package:flutter/material.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(title: Text('Sports shirts'), showBackArrow: true,),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Banner
              TRoundedImage(
                width: double.infinity,
                height: null,
                imageUrl: TImages.subCategoryBanner,
                applyImageRadius: true,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // sub-categories
              Column(
                children: [
                  // - Heading
                  TSectionHeading(title: 'Sport Shoes', onPressed: () {},),
                  const SizedBox(height: TSizes.spaceBtwItem / 2,),

                  SizedBox(
                    height: 120,
                    child: ListView.separated(
                      itemCount: 4,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) => const SizedBox(width: TSizes.spaceBtwItem,),
                      itemBuilder: (context, index) => TProductCardHorizontal(),
                    ),
                  )

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}