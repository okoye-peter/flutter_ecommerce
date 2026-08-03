import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/router/app_router.dart';
import 'package:ecommerce/core/widgets/loaders/error_retry_widget.dart';
import 'package:ecommerce/core/widgets/loaders/shimmer_effect.dart';
import 'package:ecommerce/viewmodels/categories/category_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/core/constants/colors.dart';
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
              TShimmerEffect(width: 55, height: 55, radius: 55),
              SizedBox(height: TSizes.spaceBtwItem / 2),
              TShimmerEffect(width: 55, height: 9),
            ],
          ),
        ),
      ),
      error: (error, stackTrace) => SizedBox(
        height: 80,
        child: TErrorRetryWidget(
          message: error.toString(),
          textColor: TColors.white,
          onRetry: () => ref.invalidate(categoriesProvider),
        ),
      ),
      data: (_) {
        final featured = ref
            .read(categoriesProvider.notifier)
            .getFeatureCategories();

        if (featured.isEmpty) {
          return SizedBox(
            height: 80,
            child: Center(
              child: Text(
                'No categories found.',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.apply(color: TColors.white),
              ),
            ),
          );
        }

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
                onTap: () => context.push(AppRoutes.subCategoryDetails(cat.id)),
              );
            },
          ),
        );
      },
    );
  }
}
