import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/utils/device/device_utility.dart';
import 'package:flutter/material.dart';

class TRatingProductProgressIndicator extends StatelessWidget {
  const TRatingProductProgressIndicator({super.key, required this.ratingTotal, required this.ratingValue});

  final String ratingTotal;
  final double ratingValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(ratingTotal, style: Theme.of(context).textTheme.bodyMedium),
        ),

        Expanded(
          flex: 12,
          child: SizedBox(
            width: TDeviceUtils.getScreenHeight(context) * 0.7,
            child: LinearProgressIndicator(
              value: ratingValue,
              minHeight: 10,
              backgroundColor: TColors.grey,
              borderRadius: BorderRadius.circular(7),
              valueColor: AlwaysStoppedAnimation(TColors.primary),
            ),
          ),
        ),
      ],
    );
  }
}
