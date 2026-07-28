import 'package:ecommerce/core/constants/sizes.dart';
import 'package:flutter/material.dart';

class TProductGridView extends StatelessWidget {
  const TProductGridView({
    super.key,
    this.itemCount = 4,
    this.mainAxisExtent = 304,
    required this.itemBuilder,
  });

  final int itemCount;
  final double mainAxisExtent;
  final Widget? Function(BuildContext context, int index) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: itemCount,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: TSizes.gridViewSpacing,
        crossAxisSpacing: TSizes.gridViewSpacing,
        mainAxisExtent: mainAxisExtent,
      ),
      itemBuilder: itemBuilder,
    );
  }
}
