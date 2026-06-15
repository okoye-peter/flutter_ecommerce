import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/helpers/halper_functions.dart';
import 'package:ecommerce/views/home/home.dart';
import 'package:ecommerce/views/store/store.dart';
import 'package:ecommerce/views/wishlists/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _navigationIndexProvider = StateProvider<int>((ref) => 0);

class NavigationMenuScreen extends ConsumerWidget {
  const NavigationMenuScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(_navigationIndexProvider);
    final dark = THelperFunctions.isDarkMode(context);

    final screens = [
      const HomeScreen(),
      const StoreScreen(),
      const FavoriteScreen(),
      Container(color: Colors.grey),
    ];

    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) =>
            ref.read(_navigationIndexProvider.notifier).state = index,
        backgroundColor: dark ? TColors.black : Colors.white,
        indicatorColor: dark
            ? TColors.white.withAlpha(26)
            : TColors.black.withAlpha(26),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.store), label: 'Store'),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            label: 'Wishlist',
          ),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
