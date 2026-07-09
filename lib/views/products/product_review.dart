import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/widgets/appbar/appbar.dart';
import 'package:ecommerce/views/products/widgets/product_overall_product_ratings.dart';
import 'package:ecommerce/views/products/widgets/product_rating_bar_indicator.dart';
import 'package:ecommerce/views/products/widgets/product_user_review_card.dart';
import 'package:flutter/material.dart';

class ProductReviewsScreen extends StatelessWidget {
  const ProductReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(title: Text('Reviews & Ratings'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ratings and reviews are verified and are from people who use the same type of device that you use',
              ),
              SizedBox(height: TSizes.spaceBtwItem),

              // - Overall Product Ratings
              TProductOverAllProductRatings(),

              // Ratings
              TRatingBarIndicator(rating: 3.7),
              Text('12,611', style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: TSizes.spaceBtwSections),

              // user Reviews List
              TProductUserReviewCard(),
              TProductUserReviewCard(),
              TProductUserReviewCard(),
              TProductUserReviewCard(),
              TProductUserReviewCard(),
            ],
          ),
        ),
      ),
    );
  }
}
