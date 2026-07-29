import 'dart:io';

import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/helpers/helper_functions.dart';
import 'package:ecommerce/core/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TAppBar({
    super.key,
    this.title,
    this.actions,
    this.leadingIcon,
    this.leadingOnPressed,
    this.showBackArrow = false,
    this.horizontalPadding = TSizes.md,
  });

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final IconData backIcon = Platform.isAndroid ? Icons.arrow_back :  Icons.arrow_back_ios;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: AppBar(
        automaticallyImplyLeading: false, 
        leading: showBackArrow 
        ? IconButton(onPressed: () => context.pop(), icon: Icon(backIcon, color: dark ? TColors.borderPrimary : TColors.dark )) 
        : leadingIcon != null ? IconButton(onPressed: leadingOnPressed, icon: Icon(leadingIcon)) : null,
        title: title,
        actions: actions,


      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}
