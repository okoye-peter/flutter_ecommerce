import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/router/app_router.dart';
import 'package:ecommerce/core/widgets/appbar/appbar.dart';
import 'package:ecommerce/core/widgets/loaders/error_retry_widget.dart';
import 'package:ecommerce/core/widgets/loaders/loading_overlay.dart';
import 'package:ecommerce/viewmodels/addresses/address_controller.dart';
import 'package:ecommerce/views/settings/address/widget/delete_address_dialog.dart';
import 'package:ecommerce/views/settings/address/widget/single_address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class UserAddressScreen extends ConsumerWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addresses = ref.watch(addressControllerProvider);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: TColors.primary,
        onPressed: () => context.push(AppRoutes.addNewAddress),
        child: Icon(Icons.add, color: TColors.white),
      ),
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Addresses',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(TSizes.defaultSpace),
        child: addresses.when(
          data: (addresses) {
            if (addresses.isEmpty) {
              return Center(
                child: Text('No addresses found. Please add a new address.'),
              );
            }

            return ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: addresses.length,
              separatorBuilder: (context, index) =>
                  SizedBox(height: TSizes.spaceBtwItem),
              itemBuilder: (context, index) {
                final address = addresses[index];
                return TSingleAddress(
                  address: address,
                  onTap: () async {
                    TLoadingOverlay.show();
                    await ref
                        .read(addressControllerProvider.notifier)
                        .selectAddress(address.id);
                    TLoadingOverlay.hide();
                  },
                  onEdit: () =>
                      context.push(AppRoutes.addNewAddress, extra: address),
                  onDelete: () => openDeleteAddressConfirmation(
                    context,
                    ref,
                    address: address,
                  ),
                );
              },
            );
          },
          loading: () => Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => TErrorRetryWidget(
            message: 'Error loading addresses',
            onRetry: () => ref.invalidate(addressControllerProvider),
          ),
        ),
      ),
    );
  }
}
