// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_products_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(categoryProducts)
final categoryProductsProvider = CategoryProductsFamily._();

final class CategoryProductsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ProductModel>>,
          List<ProductModel>,
          FutureOr<List<ProductModel>>
        >
    with
        $FutureModifier<List<ProductModel>>,
        $FutureProvider<List<ProductModel>> {
  CategoryProductsProvider._({
    required CategoryProductsFamily super.from,
    required (String, {int limit}) super.argument,
  }) : super(
         retry: null,
         name: r'categoryProductsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$categoryProductsHash();

  @override
  String toString() {
    return r'categoryProductsProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<ProductModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ProductModel>> create(Ref ref) {
    final argument = this.argument as (String, {int limit});
    return categoryProducts(ref, argument.$1, limit: argument.limit);
  }

  @override
  bool operator ==(Object other) {
    return other is CategoryProductsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$categoryProductsHash() => r'e27f1fd3f16a9f256d1ca36005e9306e89591a62';

final class CategoryProductsFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<ProductModel>>,
          (String, {int limit})
        > {
  CategoryProductsFamily._()
    : super(
        retry: null,
        name: r'categoryProductsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CategoryProductsProvider call(String categoryId, {int limit = 4}) =>
      CategoryProductsProvider._(
        argument: (categoryId, limit: limit),
        from: this,
      );

  @override
  String toString() => r'categoryProductsProvider';
}
