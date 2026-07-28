// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'featured_products_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(featuredProducts)
final featuredProductsProvider = FeaturedProductsProvider._();

final class FeaturedProductsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ProductModel>>,
          List<ProductModel>,
          FutureOr<List<ProductModel>>
        >
    with
        $FutureModifier<List<ProductModel>>,
        $FutureProvider<List<ProductModel>> {
  FeaturedProductsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'featuredProductsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$featuredProductsHash();

  @$internal
  @override
  $FutureProviderElement<List<ProductModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ProductModel>> create(Ref ref) {
    return featuredProducts(ref);
  }
}

String _$featuredProductsHash() => r'2e95f4a4f4666349d5c15e9177ea962ea0cf36b1';
