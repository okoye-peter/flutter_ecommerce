import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/core/constants/enums.dart';
import 'package:ecommerce/core/constants/image_strings.dart';
import 'package:ecommerce/core/providers/providers.dart';
import 'package:ecommerce/core/widgets/loaders/full_screen_loader.dart';
import 'package:ecommerce/core/widgets/loaders/snacks_loader.dart';
import 'package:ecommerce/models/cart_item_model.dart';
import 'package:ecommerce/models/order_model.dart';
import 'package:ecommerce/repositories/authentication_repository.dart';
import 'package:ecommerce/repositories/order_repository.dart';
import 'package:ecommerce/viewmodels/addresses/address_controller.dart';
import 'package:ecommerce/viewmodels/carts/cart_controller.dart';
import 'package:ecommerce/viewmodels/checkout/checkout_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'order_controller.g.dart';

@Riverpod(keepAlive: true)
class OrderController extends _$OrderController {
  static const _pageSize = 10;

  late List<CartItemModel> _cartItems;
  late AuthenticationRepository _authRepo;
  late OrderRepository _repo;
  DocumentSnapshot<Map<String, dynamic>>? _lastDocument;
  bool _hasMore = true;

  /// Whether another page of orders is available to fetch. Only updated on
  /// a successful fetch, so a transient failure never gets confused with
  /// having reached the end of the list.
  bool get hasMore => _hasMore;

  @override
  FutureOr<List<OrderModel>> build() {
    _cartItems = ref.watch(cartControllerProvider).value ?? [];
    _authRepo = ref.watch(authRepositoryProvider);
    ref.watch(authStateChangesProvider);
    _repo = OrderRepository();
    _lastDocument = null;
    _hasMore = true;
    return _fetchUserOrders();
  }

  Future<List<OrderModel>> _fetchUserOrders() async {
    final userId = _authRepo.currentUser?.uid;
    if (userId == null) return [];

    try {
      final result = await _repo.fetchOrders(userId: userId, limit: _pageSize);
      _lastDocument = result.lastDocument;
      _hasMore = result.hasMore;
      return result.items;
    } catch (e) {
      TSnacksLoader.errorSnackBar(
        title: 'Oh Snap',
        message: 'something went wrong while fetching orders',
      );
      return [];
    }
  }

  /// Fetches and appends the next page of orders, continuing from wherever
  /// the last successful fetch left off. No-op once [hasMore] is false, or
  /// while a fetch is already the current [state] value being built on.
  Future<void> fetchMoreOrders() async {
    final userId = _authRepo.currentUser?.uid;
    if (userId == null || !_hasMore) return;

    try {
      final result = await _repo.fetchOrders(
        userId: userId,
        limit: _pageSize,
        startAfter: _lastDocument,
      );
      _lastDocument = result.lastDocument ?? _lastDocument;
      _hasMore = result.hasMore;
      state = AsyncData([...?state.value, ...result.items]);
    } catch (e) {
      TSnacksLoader.errorSnackBar(
        title: 'Oh Snap',
        message: 'something went wrong while fetching orders',
      );
    }
  }

  /// Places the order and returns whether it succeeded, so callers can
  /// decide what to show next (e.g. navigate to a success screen).
  static const _networkTimeout = Duration(seconds: 15);

  Future<bool> processOrder(double totalAmount) async {
    try {
      TFullScreenLoader.openLoadingDialog(
        'Processing your Order...',
        animation: TImages.paymentProcessingAnimation,
      );
      final userId = _authRepo.currentUser?.uid;
      if (userId == null || userId.isEmpty) {
        TSnacksLoader.errorSnackBar(
          title: 'Oh Snap',
          message: 'UnAuthenticated',
        );
        TFullScreenLoader.stopLoading();
        return false;
      }

      // Read (not watch) — this is a one-off lookup for this action, not a
      // dependency this controller should stay subscribed to.
      final selectedPaymentMethod = ref.read(checkoutControllerProvider);
      final selectedAddress = ref
          .read(addressControllerProvider.notifier)
          .getSelectedAddress();

      final order = OrderModel(
        id: _repo.newOrderId(userId),
        userId: userId,
        status: OrderStatus.processing,
        totalAmount: totalAmount,
        orderDate: DateTime.now(),
        paymentMethod: selectedPaymentMethod.name,
        address: selectedAddress,
        items: _cartItems,
      );

      // Bounded so a stalled connection surfaces as an error instead of
      // leaving the loading dialog stuck open forever.
      await _repo.createOrder(order).timeout(_networkTimeout);
      state = AsyncValue.data([order, ...?state.value]);

      await ref
          .read(cartControllerProvider.notifier)
          .clearCart()
          .timeout(_networkTimeout);

      await TFullScreenLoader.stopLoading();
      TSnacksLoader.successSnackBar(
        title: 'Success',
        message: 'Your order has been placed.',
      );
      return true;
    } catch (e, s) {
      debugPrint('OrderController.processOrder failed: $e\n$s');
      TFullScreenLoader.stopLoading();
      TSnacksLoader.errorSnackBar(
        title: 'Oh Snap!',
        message: e is TimeoutException
            ? 'This is taking longer than expected. Check your connection and try again.'
            : 'Something went wrong placing your order.',
      );
      return false;
    }
  }
}
