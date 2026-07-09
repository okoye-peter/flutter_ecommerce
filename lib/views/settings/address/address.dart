import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(AppRoutes.addNewAddress),
        child: Icon(Icons.add, color: TColors.white),
      ),
    );
  }
}