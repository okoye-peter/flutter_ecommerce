// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CartController)
final cartControllerProvider = CartControllerProvider._();

final class CartControllerProvider
    extends $AsyncNotifierProvider<CartController, List<CartItemModel>> {
  CartControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cartControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cartControllerHash();

  @$internal
  @override
  CartController create() => CartController();
}

String _$cartControllerHash() => r'c09ea008ff4f6123246b5b7586da0434b4b7ce75';

abstract class _$CartController extends $AsyncNotifier<List<CartItemModel>> {
  FutureOr<List<CartItemModel>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<CartItemModel>>, List<CartItemModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<CartItemModel>>, List<CartItemModel>>,
              AsyncValue<List<CartItemModel>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
