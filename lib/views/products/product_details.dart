import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/helpers/helper_functions.dart';
import 'package:ecommerce/core/router/app_router.dart';
import 'package:ecommerce/core/widgets/loaders/error_retry_widget.dart';
import 'package:ecommerce/core/widgets/texts/section_heading.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/viewmodels/products/details/variation_controller.dart';
import 'package:ecommerce/viewmodels/products/product_details_controller.dart';
import 'package:ecommerce/views/products/widgets/bottom_add_to_cart_widget.dart';
import 'package:ecommerce/views/products/widgets/product_attribute.dart';
import 'package:ecommerce/views/products/widgets/product_details_shimmer.dart';
import 'package:ecommerce/views/products/widgets/product_images_slider.dart';
import 'package:ecommerce/views/products/widgets/product_meta_data.dart';
import 'package:ecommerce/views/products/widgets/product_rating_and_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:readmore/readmore.dart';

class ProductDetailsScreen extends ConsumerStatefulWidget {
  const ProductDetailsScreen({super.key, required this.productId});

  final String productId;

  @override
  ConsumerState<ProductDetailsScreen> createState() =>
      _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends ConsumerState<ProductDetailsScreen> {
  @override
  void initState() {
    super.initState();
    // VariationController isn't scoped per product, so a selection made on
    // a previously viewed variable product would otherwise leak in here and
    // silently block every attribute combination from ever resolving.
    // Deferred via Future() since providers can't be modified synchronously
    // during initState.
    Future(() {
      if (!mounted) return;
      ref.read(variationControllerProvider.notifier).resetSelectedAttribute();
    });
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final productAsync = ref.watch(
      productDetailsControllerProvider(widget.productId),
    );

    return Scaffold(
      bottomNavigationBar: TBottomAddToCart(product: productAsync.value ?? ProductModel.empty(),),
      body: SafeArea(
        bottom: false,
        child: productAsync.when(
          loading: () => const TProductDetailsShimmer(),
          error: (_, _) => TErrorRetryWidget(
            message: 'Something went wrong loading this product.',
            onRetry: () => ref.invalidate(
              productDetailsControllerProvider(widget.productId),
            ),
          ),
          data: (product) => SingleChildScrollView(
            child: Column(
              children: [
                // product image slider
                TProductImagesSlider(dark: dark, product: product),

                Padding(
                  padding: EdgeInsets.only(
                    right: TSizes.defaultSpace,
                    left: TSizes.defaultSpace,
                    bottom: TSizes.defaultSpace,
                  ),
                  child: Column(
                    children: [
                      // - Rating & Share
                      TRatingAndShare(),

                      // - Price, Title, Stock, & Brand
                      TProductMetaData(product: product),

                      // - Attributes
                      TProductAttributes(product: product),
                      const SizedBox(height: TSizes.spaceBtwSections),

                      // - Checkout Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text('Checkout'),
                        ),
                      ),
                      const SizedBox(height: TSizes.spaceBtwSections),

                      // - Description
                      const TSectionHeading(
                        title: 'Description',
                        showActionButton: false,
                      ),
                      const SizedBox(height: TSizes.spaceBtwSections),
                      ReadMoreText(
                        product.description?.isNotEmpty == true
                            ? product.description!
                            : product.title,
                        trimLength: 2,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'Show more',
                        trimExpandedText: ' Less',
                        moreStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                        lessStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),

                      // - Reviews
                      const Divider(),
                      const SizedBox(height: TSizes.spaceBtwSections),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TSectionHeading(
                              title: 'Reviews(199)',
                              showActionButton: false,
                            ),
                          ),
                          IconButton(
                            onPressed: () => context.push(
                              AppRoutes.productReviews(widget.productId),
                            ),
                            icon: const Icon(Icons.arrow_forward_ios, size: 18),
                          ),
                        ],
                      ),
                      const SizedBox(height: TSizes.spaceBtwSections),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
