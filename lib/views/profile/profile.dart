import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/widgets/appbar/appbar.dart';
import 'package:ecommerce/core/widgets/loaders/error_retry_widget.dart';
import 'package:ecommerce/viewmodels/auth/user_controller.dart';
import 'package:ecommerce/views/profile/widgets/profile_details.dart';
import 'package:ecommerce/views/profile/widgets/profile_details_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userControllerProvider);

    return Scaffold(
      appBar: TAppBar(title: Text('Profile'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: userState.when(
            data: (user) => TProfileDetails(user: user),
            loading: () => const TProfileDetailsShimmer(),
            error: (_, _) => TErrorRetryWidget(
              message: 'Something went wrong loading your profile.',
              onRetry: () => ref.invalidate(userControllerProvider),
            ),
          ),
        ),
      ),
    );
  }
}
