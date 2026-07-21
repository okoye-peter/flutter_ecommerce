import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/providers/providers.dart';
import 'package:ecommerce/core/router/app_router.dart';
import 'package:ecommerce/core/widgets/appbar/appbar.dart';
import 'package:ecommerce/core/widgets/curved_edges/primary_header_container.dart';
import 'package:ecommerce/core/widgets/loaders/full_screen_loader.dart';
import 'package:ecommerce/core/widgets/texts/section_heading.dart';
import 'package:ecommerce/views/settings/widgets/setting_menu_tiles.dart';
import 'package:ecommerce/views/settings/widgets/user_profile_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  // AppBar
                  TAppBar(
                    title: Text(
                      'Account',
                      style: Theme.of(
                        context,
                      ).textTheme.headlineMedium!.apply(color: TColors.white),
                    ),
                  ),
                  const SizedBox(height: TSizes.md),
                  // User Profile
                  TUserProfileTile(),
                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),

            // body
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  // -- Account Settings
                  const TSectionHeading(
                    title: 'Account Settings',
                    showActionButton: false,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItem),
                  TSettingMenuTiles(
                    icon: Icons.home_outlined,
                    title: 'My Addresses',
                    subTitle: 'Set shopping delivery address',
                    onTap: () => context.push(AppRoutes.address),
                  ),
                  TSettingMenuTiles(
                    icon: Icons.shopping_cart_outlined,
                    title: 'My Cart',
                    subTitle: 'Add, remove products and move to checkout',
                    onTap: () {},
                  ),
                  TSettingMenuTiles(
                    icon: Icons.shopping_bag_outlined,
                    title: 'My Orders',
                    subTitle: 'In-progress and Completed Orders',
                    onTap: () => context.push(AppRoutes.orders),
                  ),
                  TSettingMenuTiles(
                    icon: Icons.account_balance_outlined,
                    title: 'Bank Account',
                    subTitle: 'Withdraw balance to registered bank account',
                    onTap: () {},
                  ),
                  TSettingMenuTiles(
                    icon: Icons.discount_outlined,
                    title: 'My Coupons',
                    subTitle: 'List of all the discounted coupons',
                    onTap: () {},
                  ),
                  TSettingMenuTiles(
                    icon: Icons.notifications_outlined,
                    title: 'Notifications',
                    subTitle: 'Set any kind of notification message',
                    onTap: () {},
                  ),
                  TSettingMenuTiles(
                    icon: Icons.security,
                    title: 'Account Privacy',
                    subTitle: 'Manage data usage and connected accounts',
                    onTap: () {},
                  ),

                  // -- App Settings
                  const SizedBox(height: TSizes.spaceBtwSections),
                  const TSectionHeading(
                    title: 'App Settings',
                    showActionButton: false,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItem),
                  TSettingMenuTiles(
                    icon: Icons.upload_outlined,
                    title: 'Load Data',
                    subTitle: 'Upload data to your Cloud Firebase',
                    onTap: () {},
                  ),
                  TSettingMenuTiles(
                    icon: Icons.location_on_outlined,
                    title: 'Geolocation',
                    subTitle: 'Set recommendation based on location',
                    trailing: Switch(value: false, onChanged: (val) {}),
                  ),
                  TSettingMenuTiles(
                    icon: Icons.shopping_bag_outlined,
                    title: 'Safe Mode',
                    subTitle: 'Search result is safe for all ages',
                    trailing: Switch(value: true, onChanged: (val) {}),
                  ),
                  TSettingMenuTiles(
                    icon: Icons.image_outlined,
                    title: 'HD Image Quality',
                    subTitle: 'Set image quality to be seen',
                    trailing: Switch(value: false, onChanged: (val) {}),
                  ),

                  // -- Logout
                  const SizedBox(height: TSizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () async {
                        TFullScreenLoader.openLoadingDialog('logging out...');
                        await ref.read(authRepositoryProvider).logout();
                        TFullScreenLoader.stopLoading();
                      },
                      child: const Text('Logout'),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections * 2.5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
