import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/helpers/helper_functions.dart';
import 'package:ecommerce/core/widgets/products/rounded_container.dart';
import 'package:flutter/material.dart';

class TSingleAddress extends StatelessWidget {
  const TSingleAddress({super.key, required this.selectedAddress});

  final bool selectedAddress;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return TRoundedContainer(
      padding: EdgeInsets.all(TSizes.md),
      width: double.infinity,
      showBorder: true,
      backgroundColor: selectedAddress
          ? TColors.primary.withAlpha(126)
          : Colors.transparent,
      borderColor: selectedAddress
          ? Colors.transparent
          : (dark ? TColors.darkGrey : TColors.grey),
      margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItem),
      child: Stack(
        children: [
          Positioned(
            right: 5,
            top: 0,
            child: Icon(
              selectedAddress ? Icons.check_circle : null,
              color: selectedAddress
                  ? (dark ? TColors.light : TColors.dark.withValues(alpha: 0.7))
                  : null,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                // 'No 50 Palmbay Estate Abijo GRA, Lagos Nigeria',
                'John Doe',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: TSizes.sm / 2,),
              Text('(+123) 456 7890', overflow:  TextOverflow.ellipsis,),
              const SizedBox(height: TSizes.sm / 2,),
              Text(
                'No 50 Palmbay Estate Abijo GRA, Lagos Nigeria',
                softWrap: true,
                // maxLines: 2,
                // overflow: TextOverflow.ellipsis,
                // style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          )
        ],
      ),
    );
  }
}
