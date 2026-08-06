import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/constants/enums.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/helpers/helper_functions.dart';
import 'package:ecommerce/core/widgets/icons/circular_icon.dart';
import 'package:ecommerce/models/cart_item_model.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/viewmodels/carts/cart_controller.dart';
import 'package:ecommerce/viewmodels/products/details/variation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TBottomAddToCart extends ConsumerStatefulWidget {
  const TBottomAddToCart({super.key, required this.product});

  final ProductModel product;

  @override
  ConsumerState<TBottomAddToCart> createState() => _TBottomAddToCartState();
}

class _TBottomAddToCartState extends ConsumerState<TBottomAddToCart> {
  int _quantity = 1;

  bool get _isVariable =>
      widget.product.productType == ProductType.variable.name;

  @override
  void initState() {
    super.initState();
    // Single products always sit under variationId '', so their existing
    // cart quantity can be resolved immediately. Variable products only
    // resolve once the user picks a variation (handled by ref.listen below).
    if (!_isVariable) {
      final existingQty = ref
          .read(cartControllerProvider.notifier)
          .getProductVariationQuantityInCart(widget.product.id, '');
      if (existingQty > 0) _quantity = existingQty;
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = ref.read(cartControllerProvider.notifier);
    ref.watch(cartControllerProvider);

    ref.listen(variationControllerProvider, (previous, next) {
      if (previous?.selectedAttribute.id == next.selectedAttribute.id) return;

      final resolved = next.resolvedVariation;
      if (resolved == null) {
        setState(() => _quantity = 1);
        return;
      }

      final existingQty = controller.getProductVariationQuantityInCart(
        widget.product.id,
        resolved.id,
      );
      setState(() => _quantity = existingQty > 0 ? existingQty : 1);
    });

    final variation = _isVariable
        ? ref.watch(variationControllerProvider).resolvedVariation
        : null;
    final stock = _isVariable ? (variation?.stock ?? 0) : widget.product.stock;
    final hasSelection = !_isVariable || variation != null;
    final canSubmit = hasSelection && stock > 0;

    final variationId = variation?.id ?? '';
    final existingQty = hasSelection
        ? controller.getProductVariationQuantityInCart(
            widget.product.id,
            variationId,
          )
        : 0;
    final alreadyInCart = existingQty > 0;

    final buttonLabel = !hasSelection
        ? 'Select a Variation'
        : stock <= 0
        ? 'Out of Stock'
        : alreadyInCart
        ? 'Update Cart'
        : 'Add to Cart';

    return Container(
      padding: EdgeInsets.only(
        left: TSizes.defaultSpace,
        right: TSizes.defaultSpace,
        top: TSizes.defaultSpace / 2,
        bottom: TSizes.defaultSpace / 2 + MediaQuery.of(context).padding.bottom,
      ),
      decoration: BoxDecoration(
        color: dark ? TColors.darkerGrey : TColors.light,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              TCircularIcon(
                icon: Icons.remove,
                backgroundColor: TColors.grey,
                width: 40,
                height: 40,
                color: TColors.white,
                onPressed: _quantity > 1
                    ? () => setState(() => _quantity--)
                    : null,
              ),
              const SizedBox(width: TSizes.spaceBtwItem),
              Text('$_quantity', style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(width: TSizes.spaceBtwItem),
              TCircularIcon(
                icon: Icons.add,
                backgroundColor: TColors.black,
                width: 40,
                height: 40,
                color: TColors.white,
                onPressed: _quantity < stock
                    ? () => setState(() => _quantity++)
                    : null,
              ),
            ],
          ),

          ElevatedButton(
            onPressed: canSubmit
                ? () {
                    if (alreadyInCart) {
                      final matcher = CartItemModel.empty().copyWith(
                        productId: widget.product.id,
                        variationId: variationId,
                      );
                      controller.updateCartItemQuantity(matcher, _quantity);
                    } else {
                      controller.addToCart(widget.product, _quantity);
                    }
                  }
                : null,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(TSizes.md),
              backgroundColor: TColors.black,
              side: const BorderSide(color: TColors.black),
            ),
            child: Text(buttonLabel),
          ),
        ],
      ),
    );
  }
}
