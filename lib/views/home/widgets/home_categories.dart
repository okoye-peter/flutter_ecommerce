import 'package:flutter/material.dart';
import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/constants/image_strings.dart';
import 'package:ecommerce/views/home/widgets/vertical_image_text.dart';

class THomeCategories extends StatelessWidget {
  const THomeCategories({super.key});

  static List<Map<String, String>> categories = [
    {"imgUrl": TImages.categorySport, "name": 'Sport'}, 
    {"imgUrl": TImages.categoryAutoMobile, "name": 'Automobile'},
    {"imgUrl": TImages.categoryClothing, "name": 'Clothings'},
    {"imgUrl": TImages.categoryFood, "name": 'Food'},
    // {"imgUrl": TImages.categoryFoodCat, "name": ''},
    {"imgUrl": TImages.categoryGadget, "name": 'Gadgets'},
    {"imgUrl": TImages.categoryGames, "name": 'Games'}
  ];

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
            image: categories[index]['imgUrl']!,
            title: categories[index]['name']!,
            textColor: TColors.white,
            onTap: () {},
          );
        },
      ),
    );
  }
}
