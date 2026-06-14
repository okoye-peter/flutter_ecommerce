import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/helpers/halper_functions.dart';
import 'package:ecommerce/views/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationMenuScreen extends StatefulWidget {
  const NavigationMenuScreen({super.key});

  @override
  State<NavigationMenuScreen> createState() => _NavigationMenuScreenState();
}

class _NavigationMenuScreenState extends State<NavigationMenuScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
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
      ),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final List<Widget> screens = [
    HomeScreen(), // Home
    Container(color: Colors.orange), // Store
    Container(color: Colors.yellow), // Wishlist
    Container(color: Colors.grey), // Profile
  ];
}
