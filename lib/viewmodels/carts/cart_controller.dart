import 'package:ecommerce/core/constants/enums.dart';
import 'package:ecommerce/core/providers/providers.dart';
import 'package:ecommerce/core/widgets/loaders/snacks_loader.dart';
import 'package:ecommerce/models/cart_item_model.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/repositories/authentication_repository.dart';
import 'package:ecommerce/repositories/cart_repository.dart';
import 'package:ecommerce/viewmodels/products/details/variation_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cart_controller.g.dart';

@Riverpod(keepAlive: true)
class CartController extends _$CartController {
  late CartRepository _repo;
  late AuthenticationRepository _authRepo;

  @override
  FutureOr<List<CartItemModel>> build() {
    _repo = CartRepository();
    _authRepo = ref.watch(authRepositoryProvider);
    ref.watch(authStateChangesProvider);
    return fetchCartItems();
  }

  Future<List<CartItemModel>> fetchCartItems() async {
    final userId = _authRepo.currentUser?.uid;
    if (userId == null) return [];
    return _repo.fetchCartItems(userId);
  }

  void addToCart(ProductModel product, int quantity) {
    if (quantity <= 0) {
      TSnacksLoader.errorSnackBar(
        title: 'Invalid quantity',
        message: 'Quantity must be greater than zero.',
      );
      return;
    }

    // Read (not watch) — this is a one-off lookup for this action, not a
    // dependency CartController should stay subscribed to. Watching it here
    // would keep VariationController (autoDispose) alive for as long as the
    // keepAlive CartController lives, leaking its selection across products.
    final variationController = ref.read(variationControllerProvider.notifier);

    if (product.productType == ProductType.variable.name) {
      final variation = variationController.state.resolvedVariation;
      if (variation == null) {
        TSnacksLoader.errorSnackBar(
          title: 'No variation selected',
          message: 'Please select a variation before adding to cart.',
        );
        return;
      }
      if (variation.stock < 1) {
        TSnacksLoader.errorSnackBar(
          title: 'Out of stock',
          message: 'The selected variation is out of stock.',
        );
        return;
      }
    } else if (product.stock < 1) {
      TSnacksLoader.errorSnackBar(
        title: 'Out of stock',
        message: 'The selected product is out of stock.',
      );
      return;
    }

    final cartItem = _convertToCartItem(product, quantity, variationController);

    final items = List<CartItemModel>.from(state.value ?? []);
    final index = items.indexWhere(
      (item) =>
          item.productId == cartItem.productId &&
          item.variationId == cartItem.variationId,
    );

    final CartItemModel savedItem;
    if (index >= 0) {
      savedItem = items[index].copyWith(
        quantity: items[index].quantity + quantity,
      );
      items[index] = savedItem;
    } else {
      savedItem = cartItem;
      items.add(savedItem);
    }

    state = AsyncValue.data(items);
    _persistCartItem(savedItem);
  }

  Future<void> _persistCartItem(CartItemModel item) async {
    final userId = _authRepo.currentUser?.uid;
    if (userId == null) return;

    try {
      await _repo.saveCartItem(userId, item);
    } catch (e) {
      TSnacksLoader.errorSnackBar(title: 'Error', message: e.toString());
    }
  }

  CartItemModel _convertToCartItem(
    ProductModel product,
    int quantity,
    VariationController variationController,
  ) {
    if (product.productType == ProductType.single.name) {
      variationController.resetSelectedAttribute();
    }

    final variation = variationController.state.resolvedVariation;
    final price = variation != null
        ? (variation.salePrice > 0.0 ? variation.salePrice : variation.price)
        : (product.salePrice > 0.0 ? product.salePrice : product.price);

    return CartItemModel(
      productId: product.id,
      title: product.title,
      price: price,
      quantity: quantity,
      variationId: variation?.id ?? '',
      image: variation?.image ?? product.thumbnail,
      brandName: product.brand?.name ?? '',
      selectedVariation: variation?.attributeValues,
    );
  }

  void updateCartItemQuantity(CartItemModel item, int newQuantity) {
    if (newQuantity < 0) {
      TSnacksLoader.errorSnackBar(
        title: 'Invalid quantity',
        message: 'Quantity cannot be negative.',
      );
      return;
    }

    if (newQuantity == 0) {
      removeCartItem(item);
      return;
    }

    final items = List<CartItemModel>.from(state.value ?? []);
    final index = items.indexWhere(
      (cartItem) =>
          cartItem.productId == item.productId &&
          cartItem.variationId == item.variationId,
    );

    if (index >= 0) {
      items[index] = items[index].copyWith(quantity: newQuantity);
      state = AsyncValue.data(items);
      _persistCartItem(items[index]);
    }
  }

  int getProductQuantityInCart(String productId) {
    final foundItem = state.value
        ?.where((item) => item.productId == productId)
        .fold(0, (previousValue, element) => previousValue + element.quantity);
    return foundItem ?? 0;
  }

  int getProductVariationQuantityInCart(String productId, String variationId) {
    final foundItem = state.value?.firstWhere(
      (item) => item.productId == productId && item.variationId == variationId,
      orElse: () => CartItemModel.empty(),
    );
    return foundItem?.quantity ?? 0;
  }

  Future<void> clearCart() async {
    final userId = _authRepo.currentUser?.uid;
    if (userId == null) return;

    try {
      await _repo.clearCart(userId);
      state = AsyncValue.data([]);
    } catch (e) {
      TSnacksLoader.errorSnackBar(
        title: 'Error',
        message: 'Failed to clear cart.',
      );
    }
  }

  Future<void> removeCartItem(CartItemModel item) async {
    final userId = _authRepo.currentUser?.uid;
    if (userId == null) return;

    try {
      await _repo.deleteCartItem(userId, item);
      final items = List<CartItemModel>.from(state.value ?? []);
      items.removeWhere(
        (cartItem) =>
            cartItem.productId == item.productId &&
            cartItem.variationId == item.variationId,
      );
      state = AsyncValue.data(items);
      TSnacksLoader.successSnackBar(
        title: 'Success',
        message: '${item.title} has been removed from cart successfully ',
      );
    } catch (e) {
      TSnacksLoader.errorSnackBar(
        title: 'Error',
        message: 'Failed to remove item from cart.',
      );
    }
  }

  String getProductInCartTotal(String productId) {
    final foundItem = state.value
        ?.where((item) => item.productId == productId)
        .fold<double>(
          0.0,
          (previousValue, element) =>
              previousValue + (element.price * element.quantity),
        );
    return foundItem?.toStringAsFixed(2) ?? '0.0';
  }

  String getTotalCartPrice() {
    return state.value
            ?.fold<double>(
              0.0,
              (total, item) => total + (item.price * item.quantity),
            )
            .toStringAsFixed(2) ??
        '0.0';
  }

  String getTotalCartItems() {
    return state.value?.length.toString() ?? '0';
  }
}
