import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/widgets/appbar/appbar.dart';
import 'package:ecommerce/core/widgets/cart/cart_counter_icon.dart';
import 'package:flutter/material.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text('Store', style:  Theme.of(context).textTheme.headlineMedium,),
        actions: [
          TCartCounterIcon(onPressed: (){}, iconColor: TColors.darkGrey)
        ],
      ),
      body: NestedScrollView(
        headerSliverBuilder: (_, innerBoxIsScrolled) => [],
        body: Container(),
      ),
    );
  }
}