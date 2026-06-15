import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/helpers/halper_functions.dart';
import 'package:flutter/material.dart';

class TFormDivider extends StatelessWidget {
  const TFormDivider({super.key, required this.dividerText});

  final String dividerText;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final text = dividerText.isEmpty
        ? ''
        : dividerText[0].toUpperCase() + dividerText.substring(1);

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
        Text(text, style: Theme.of(context).textTheme.labelMedium),
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
