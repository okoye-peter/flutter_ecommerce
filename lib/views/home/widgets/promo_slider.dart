import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/widgets/curved_edges/circular_container.dart';
import 'package:ecommerce/core/widgets/images/rounded_image.dart';
import 'package:ecommerce/core/widgets/loaders/error_retry_widget.dart';
import 'package:ecommerce/core/widgets/loaders/shimmer_effect.dart';
import 'package:ecommerce/viewmodels/banners/banner_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TPromoSlider extends ConsumerWidget {
  const TPromoSlider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(bannerControllerProvider.notifier);
    final bannerState = ref.watch(bannerControllerProvider);

    return bannerState.when(
      loading: () => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TShimmerEffect(width: double.infinity, height: 200, radius: 6),
          const SizedBox(height: TSizes.spaceBtwItem),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TShimmerEffect(width: 20, height: 4, radius: 2),
              const SizedBox(width: 10),
              TShimmerEffect(width: 20, height: 4, radius: 2),
              const SizedBox(width: 10),
              TShimmerEffect(width: 20, height: 4, radius: 2),
              const SizedBox(width: 10),
              TShimmerEffect(width: 20, height: 4, radius: 2),
            ],
          ),
        ],
      ),
      error: (error, stackTrace) => TErrorRetryWidget(
        message: error.toString(),
        onRetry: () => ref.invalidate(bannerControllerProvider),
      ),
      data: (bannerData) {
        if (bannerData.banners.isEmpty) {
          return const SizedBox(
            height: 200,
            child: Center(child: Text('No promotions available.')),
          );
        }
        return Column(
          children: [
            CarouselSlider(
              items: bannerData.banners
                  .map(
                    (banner) => GestureDetector(
                      onTap: () => context.push(banner.targetScreen),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: TRoundedImage(
                          imageUrl: banner.imageUrl,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          isNetworkImage: true,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                viewportFraction: 1,
                autoPlay: true,
                onPageChanged: (index, _) =>
                    controller.updatePageIndicator(index),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItem),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < bannerData.banners.length; i++)
                    TCircularContainer(
                      width: 20,
                      height: 4,
                      backgroundColor: bannerData.count == i
                          ? Colors.green
                          : TColors.grey,
                      margin: const EdgeInsets.only(right: 10),
                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
