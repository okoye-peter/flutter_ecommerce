import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TLoginDivider extends StatelessWidget {
  const TLoginDivider({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Divider(
            color: dark ? TColors.darkGrey : TColors.grey,
            thickness: 0.5,
            indent: 10,
            endIndent: 5,
          ),
        ),
        Text(
          TTexts.orSignInWith.capitalize!,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        Flexible(
          child: Divider(
            color: dark ? TColors.darkGrey : TColors.grey,
            thickness: 0.5,
            indent: 10,
            endIndent: 5,
          ),
        ),
      ],
    );
  }
}
