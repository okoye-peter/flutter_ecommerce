import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/router/app_router.dart';
import 'package:ecommerce/core/widgets/appbar/appbar.dart';
import 'package:ecommerce/viewmodels/carts/cart_controller.dart';
import 'package:ecommerce/views/cart/widgets/cart_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text('Cart', style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: const TCartList(),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
          onPressed: () => context.push(AppRoutes.checkout),
          child: Consumer(
            builder: (_, ref, _) {
              final cartAsync = ref.watch(cartControllerProvider);
              return cartAsync.when(
                data: (_) => Text(
                  'Checkout \$${ref.read(cartControllerProvider.notifier).getTotalCartPrice()}',
                ),
                loading: () => const CircularProgressIndicator(),
                error: (e, _) => const Text('Failed to load cart'),
              );
            },
          ),
        ),
      ),
    );
  }
}
