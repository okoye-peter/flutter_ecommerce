// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_details_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProductDetailsController)
final productDetailsControllerProvider = ProductDetailsControllerFamily._();

final class ProductDetailsControllerProvider
    extends $AsyncNotifierProvider<ProductDetailsController, ProductModel> {
  ProductDetailsControllerProvider._({
    required ProductDetailsControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'productDetailsControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$productDetailsControllerHash();

  @override
  String toString() {
    return r'productDetailsControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ProductDetailsController create() => ProductDetailsController();

  @override
  bool operator ==(Object other) {
    return other is ProductDetailsControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$productDetailsControllerHash() =>
    r'692696d4ed457ef80254b0692ad95c1e3e0b7b71';

final class ProductDetailsControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          ProductDetailsController,
          AsyncValue<ProductModel>,
          ProductModel,
          FutureOr<ProductModel>,
          String
        > {
  ProductDetailsControllerFamily._()
    : super(
        retry: null,
        name: r'productDetailsControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ProductDetailsControllerProvider call(String productId) =>
      ProductDetailsControllerProvider._(argument: productId, from: this);

  @override
  String toString() => r'productDetailsControllerProvider';
}

abstract class _$ProductDetailsController extends $AsyncNotifier<ProductModel> {
  late final _$args = ref.$arg as String;
  String get productId => _$args;

  FutureOr<ProductModel> build(String productId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<ProductModel>, ProductModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ProductModel>, ProductModel>,
              AsyncValue<ProductModel>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
