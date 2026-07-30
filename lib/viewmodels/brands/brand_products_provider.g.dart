// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand_products_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(brandProducts)
final brandProductsProvider = BrandProductsFamily._();

final class BrandProductsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ProductModel>>,
          List<ProductModel>,
          FutureOr<List<ProductModel>>
        >
    with
        $FutureModifier<List<ProductModel>>,
        $FutureProvider<List<ProductModel>> {
  BrandProductsProvider._({
    required BrandProductsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'brandProductsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$brandProductsHash();

  @override
  String toString() {
    return r'brandProductsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<ProductModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ProductModel>> create(Ref ref) {
    final argument = this.argument as String;
    return brandProducts(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is BrandProductsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$brandProductsHash() => r'81a74cfc434c31a07bc4d375150c5886a37a73a0';

final class BrandProductsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<ProductModel>>, String> {
  BrandProductsFamily._()
    : super(
        retry: null,
        name: r'brandProductsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  BrandProductsProvider call(String brandId) =>
      BrandProductsProvider._(argument: brandId, from: this);

  @override
  String toString() => r'brandProductsProvider';
}
