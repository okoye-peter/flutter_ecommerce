import 'package:ecommerce/views/products/widgets/rating_product_progress_indicator.dart';
import 'package:flutter/material.dart';

class TProductOverAllProductRatings extends StatelessWidget {
  const TProductOverAllProductRatings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            '4.8',
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        Expanded(
          flex: 7,
          child: Column(
            children: [
              TRatingProductProgressIndicator(ratingTotal: '5', ratingValue: 1.0,),
              TRatingProductProgressIndicator(ratingTotal: '4', ratingValue: 0.8,),
              TRatingProductProgressIndicator(ratingTotal: '3', ratingValue: 0.6,),
              TRatingProductProgressIndicator(ratingTotal: '2', ratingValue: 0.4,),
              TRatingProductProgressIndicator(ratingTotal: '1', ratingValue: 0.2,),
          ],
          ),
        ),
      ],
    );
  }
}
