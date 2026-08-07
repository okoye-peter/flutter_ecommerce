import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/widgets/loaders/error_retry_widget.dart';
import 'package:ecommerce/viewmodels/orders/order_controller.dart';
import 'package:ecommerce/views/orders/widgets/order_item.dart';
import 'package:ecommerce/views/orders/widgets/order_item_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TOrderListItems extends ConsumerStatefulWidget {
  const TOrderListItems({super.key});

  @override
  ConsumerState<TOrderListItems> createState() => _TOrderListItemsState();
}

class _TOrderListItemsState extends ConsumerState<TOrderListItems> {
  final _scrollController = ScrollController();
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isLoadingMore) return;

    final position = _scrollController.position;
    if (position.maxScrollExtent <= 0) return;
    if (position.pixels < position.maxScrollExtent - 200) return;

    final notifier = ref.read(orderControllerProvider.notifier);
    if (!notifier.hasMore) return;

    setState(() => _isLoadingMore = true);
    notifier.fetchMoreOrders().whenComplete(() {
      if (!mounted) return;
      setState(() => _isLoadingMore = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final ordersAsyncValue = ref.watch(orderControllerProvider);

    return ordersAsyncValue.when(
      loading: () => ListView.separated(
        itemBuilder: (_, _) => const OrderItemShimmer(),
        separatorBuilder: (_, _) => const SizedBox(height: TSizes.spaceBtwItem),
        itemCount: 6,
      ),
      error: (error, trace) => TErrorRetryWidget(
        message: 'something went wrong',
        onRetry: () => ref.invalidate(orderControllerProvider),
      ),
      data: (orders) => ListView.separated(
        controller: _scrollController,
        itemBuilder: (_, int index) {
          if (index >= orders.length) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: TSizes.spaceBtwItem),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          final order = orders[index];
          return OrderItem(key: ValueKey(order.id), order: order);
        },
        separatorBuilder: (_, _) => const SizedBox(height: TSizes.spaceBtwItem),
        itemCount: orders.length + (_isLoadingMore ? 1 : 0),
      ),
    );
  }
}
