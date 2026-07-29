import 'dart:async';

import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/widgets/grids/grid_layout.dart';
import 'package:ecommerce/core/widgets/products/product_card_vertical.dart';
import 'package:ecommerce/viewmodels/products/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _textController = TextEditingController();
  Timer? _debounce;
  String _query = '';

  void _onChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      if (mounted) setState(() => _query = value.trim());
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _textController,
          autofocus: true,
          onChanged: _onChanged,
          decoration: const InputDecoration(
            hintText: 'Search in store',
            border: InputBorder.none,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: _buildResults(),
      ),
    );
  }

  Widget _buildResults() {
    if (_query.isEmpty) {
      return const Center(
        heightFactor: 4,
        child: Text('Start typing to search products'),
      );
    }

    final results = ref.watch(searchControllerProvider(_query));

    return results.when(
      loading: () => const Center(
        heightFactor: 4,
        child: CircularProgressIndicator(),
      ),
      error: (error, _) => Center(
        heightFactor: 4,
        child: Text(error.toString()),
      ),
      data: (products) {
        if (products.isEmpty) {
          return const Center(
            heightFactor: 4,
            child: Text('No products found'),
          );
        }

        return TGridLayout(
          itemCount: products.length,
          itemBuilder: (context, index) =>
              TProductCardVertical(product: products[index]),
        );
      },
    );
  }
}
