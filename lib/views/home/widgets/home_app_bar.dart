import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/constants/text_strings.dart';
import 'package:ecommerce/core/router/app_router.dart';
import 'package:ecommerce/core/widgets/appbar/appbar.dart';
import 'package:ecommerce/core/widgets/cart/cart_counter_icon.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class THomeAppBar extends StatelessWidget {
  const THomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TTexts.homeAppbarTitle,
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: TColors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            TTexts.homeAppbarSubTitle,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: TColors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
      actions: [TCartCounterIcon(onPressed: () => context.push(AppRoutes.carts), iconColor: TColors.white,)],
    );
  }
}
