import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/providers/providers.dart';
import 'package:ecommerce/core/widgets/appbar/appbar.dart';
import 'package:ecommerce/core/widgets/loaders/full_screen_loader.dart';
import 'package:ecommerce/core/widgets/loaders/snacks_loader.dart';
import 'package:ecommerce/core/widgets/texts/section_heading.dart';
import 'package:ecommerce/scripts/banner_seeder.dart';
import 'package:ecommerce/scripts/category_seeder.dart';
import 'package:ecommerce/scripts/product_seeder.dart';
import 'package:ecommerce/views/settings/upload_data/widgets/upload_data_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

/// Dev-only screen for seeding Firestore collections from the app itself
/// instead of uncommenting the one-off calls in `main.dart`.
class UploadDataScreen extends ConsumerWidget {
  const UploadDataScreen({super.key});

  Future<void> _run(String loadingText, Future<void> Function() task) async {
    TFullScreenLoader.openLoadingDialog(loadingText);
    try {
      await task();
      await TFullScreenLoader.stopLoading();
      TSnacksLoader.successSnackBar(title: 'Success', message: 'Upload complete.');
    } catch (e) {
      await TFullScreenLoader.stopLoading();
      TSnacksLoader.errorSnackBar(title: 'Upload failed', message: e.toString());
    }
  }

  void _comingSoon() {
    TSnacksLoader.warningSnackBar(
      title: 'Coming soon',
      message: 'This upload is not available yet.',
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text('Upload Data', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TSectionHeading(title: 'Main Record', showActionButton: false),
            const SizedBox(height: TSizes.spaceBtwItem),
            TUploadDataTile(
              icon: Iconsax.category,
              title: 'Upload Categories',
              onTap: () => _run(
                'Uploading categories...',
                () => seedCategories(ref.read(cloudinaryRepositoryProvider)),
              ),
            ),
            TUploadDataTile(
              icon: Iconsax.shop,
              title: 'Upload Brands',
              onTap: _comingSoon,
            ),
            TUploadDataTile(
              icon: Iconsax.shopping_cart,
              title: 'Upload Products',
              onTap: () => _run(
                'Uploading products...',
                () => seedProducts(ref.read(cloudinaryRepositoryProvider)),
              ),
            ),
            TUploadDataTile(
              icon: Iconsax.gallery,
              title: 'Upload Banners',
              onTap: () => _run(
                'Uploading banners...',
                () => seedBanners(ref.read(cloudinaryRepositoryProvider)),
              ),
            ),

            const SizedBox(height: TSizes.spaceBtwSections),
            const TSectionHeading(title: 'Relationships', showActionButton: false),
            const SizedBox(height: TSizes.xs),
            Text(
              'Make sure you have already uploaded all the content above.',
              style: Theme.of(context).textTheme.labelMedium!.apply(color: TColors.darkGrey),
            ),
            const SizedBox(height: TSizes.spaceBtwItem),
            TUploadDataTile(
              icon: Iconsax.repeat,
              title: 'Upload Brands & Categories Relation Data',
              onTap: _comingSoon,
            ),
            TUploadDataTile(
              icon: Iconsax.repeat,
              title: 'Upload Product Categories Relational Data',
              onTap: _comingSoon,
            ),
          ],
        ),
      ),
    );
  }
}
