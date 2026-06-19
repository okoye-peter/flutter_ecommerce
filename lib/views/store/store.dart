import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/helpers/halper_functions.dart';
import 'package:ecommerce/core/widgets/appbar/appbar.dart';
import 'package:ecommerce/core/widgets/cart/cart_counter_icon.dart';
import 'package:ecommerce/core/widgets/images/circular_image.dart';
import 'package:ecommerce/core/widgets/products/rounded_container.dart';
import 'package:ecommerce/core/widgets/search/search_container.dart';
import 'package:ecommerce/core/widgets/texts/section_heading.dart';
import 'package:flutter/material.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: TAppBar(
        title: Text('Store', style: Theme.of(context).textTheme.headlineMedium),
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
            expandedHeight: 400,
            flexibleSpace: Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace),
              child: ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  const SizedBox(height: TSizes.spaceBtwItem),
                  const TSearchContainer(text: '', showBorder: true, showBackground: false, padding: EdgeInsets.zero,),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  // Featured Brands
                  TSectionHeading(title: 'Feature Brands', onPressed: () {},),

                  const SizedBox(height: TSizes.spaceBtwItem / 1.5),

                  TRoundedContainer(
                    padding: const EdgeInsets.all(TSizes.sm),
                    showBorder: true,
                    backgroundColor: Colors.transparent,
                    child: Row(
                      children: [
                        TCircularImage(image: '', backgroundColor: dark ? TColors.black : TColors.white,),
                        const SizedBox(width: TSizes.spaceBtwItem / 2),

                        Column(
                          children: [
                            
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
        body: Container(),
      ),
    );
  }
}
