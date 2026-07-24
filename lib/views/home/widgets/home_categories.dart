import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/router/app_router.dart';
import 'package:ecommerce/core/widgets/loaders/shimmer_effect.dart';
import 'package:ecommerce/viewmodels/categories/category_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/constants/image_strings.dart';
import 'package:ecommerce/views/home/widgets/vertical_image_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class THomeCategories extends ConsumerWidget {
  const THomeCategories({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(categoriesProvider);

    return categoriesAsync.when(
      loading: () => SizedBox(
        height: 80,
        child: ListView.separated(
          separatorBuilder: (_, _) =>
              const SizedBox(width: TSizes.spaceBtwItem),
          scrollDirection: Axis.horizontal,
          itemCount: 6,
          itemBuilder: (_, _) => const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TShimmerEffect(width: 56, height: 56, radius: 56),
              SizedBox(height: TSizes.spaceBtwItem / 2),
              TShimmerEffect(width: 56, height: 10),
            ],
          ),
        ),
      ),
      error: (error, stackTrace) => Text(
        error.toString(),
        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
          color: TColors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
      data: (_) {
        final featured = ref
            .read(categoriesProvider.notifier)
            .getFeatureCategories();
        return SizedBox(
          height: 80,
          child: ListView.builder(
            itemCount: featured.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) {
              final cat = featured[index];
              return TVerticalImageText(
                image: cat.image,
                title: cat.name,
                textColor: TColors.white,
                onTap: () => context.push(AppRoutes.subCategories),
              );
            },
          ),
        );
      },
    );
  }
}
