import 'package:ecommerce/core/constants/sizes.dart';
import 'package:flutter/material.dart';

class TSpacingStyle {
  static EdgeInsetsGeometry paddingWithAppBarHeight(BuildContext context) => EdgeInsets.only(
    top: TSizes.appBarHeight + MediaQuery.of(context).padding.top,
    left: TSizes.defaultSpace,
    bottom: TSizes.defaultSpace,
    right: TSizes.defaultSpace,
  );
}
