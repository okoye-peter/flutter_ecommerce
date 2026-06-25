import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/constants/image_strings.dart';
import 'package:ecommerce/core/router/app_router.dart';
import 'package:ecommerce/core/widgets/images/circular_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TUserProfileTile extends StatelessWidget {
  const TUserProfileTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: TCircularImage(image: TImages.userMaleAvatar, width: 62, height: 62),
      title: Text(
        'Okoye Dev',
        style: Theme.of(context).textTheme.headlineSmall!.apply(color: TColors.white),
      ),
      subtitle: Text(
        'okoyepete039@gmail.com',
        style: Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.white),
      ),
      trailing: IconButton(
        onPressed: () => context.push(AppRoutes.profile),
        icon: const Icon(Icons.edit_square, color: TColors.white),
      ),
    );
  }
}
