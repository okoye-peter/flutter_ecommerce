import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/widgets/curved_edges/circular_container.dart';
import 'package:ecommerce/core/widgets/images/rounded_image.dart';
import 'package:ecommerce/viewmodels/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TPromoSlider extends ConsumerWidget {
  const TPromoSlider({super.key, required this.banners});

  final List<String> banners;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(homeControllerProvider);
    final notifier = ref.read(homeControllerProvider.notifier);

    return Column(
      children: [
        CarouselSlider(
          items: banners
              .map(
                (banner) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: TRoundedImage(
                    imageUrl: banner,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              )
              .toList(),
          options: CarouselOptions(
            viewportFraction: 1,
            autoPlay: true,
            onPageChanged: (index, _) => notifier.updatePageIndicator(index),
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwItem),
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < banners.length; i++)
                TCircularContainer(
                  width: 20,
                  height: 4,
                  backgroundColor:
                      currentIndex == i ? Colors.green : TColors.grey,
                  margin: const EdgeInsets.only(right: 10),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
