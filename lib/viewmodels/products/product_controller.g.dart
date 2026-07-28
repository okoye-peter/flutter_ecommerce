// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProductController)
final productControllerProvider = ProductControllerProvider._();

final class ProductControllerProvider
    extends $AsyncNotifierProvider<ProductController, ProductData> {
  ProductControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'productControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$productControllerHash();

  @$internal
  @override
  ProductController create() => ProductController();
}

String _$productControllerHash() => r'33cc98f92204716d89ddf71f4484f16b698162a0';

abstract class _$ProductController extends $AsyncNotifier<ProductData> {
  FutureOr<ProductData> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<ProductData>, ProductData>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ProductData>, ProductData>,
              AsyncValue<ProductData>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
