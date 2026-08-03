import 'package:ecommerce/core/widgets/icons/circular_icon.dart';
import 'package:ecommerce/viewmodels/products/favorites/favorite_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

class TFavoriteIcon extends ConsumerWidget {
  const TFavoriteIcon({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
  ref.watch(favoriteControllerProvider);
  final controller = ref.read(favoriteControllerProvider.notifier);
  final isFav = controller.isFavorite(productId);

  return TCircularIcon(
    icon: isFav ? Iconsax.heart5 : Iconsax.heart,
    color: isFav ? Colors.red : null,
    onPressed: () => controller.toggleFavorite(productId),
  );
}

}
