import 'package:flutter/material.dart';
import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/constants/image_strings.dart';
import 'package:ecommerce/views/home/widgets/vertical_image_text.dart';

class THomeCategories extends StatelessWidget {
  const THomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        itemCount: 6,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          // categories
          return TVerticalImageText(
            image: TImages.categoryFood,
            title: 'Shoes',
            textColor: TColors.white,
            onTap: () {},
          );
        },
      ),
    );
  }
}
