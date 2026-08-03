// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_products_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Resolves the current user's favorite product ids into [ProductModel]s.
///
/// Keeps a local id->product cache so that toggling a favorite only ever
/// fetches ids that haven't been seen before; removals are dropped from the
/// cache and the returned list without hitting Firestore again.

@ProviderFor(FavoriteProductsController)
final favoriteProductsControllerProvider =
    FavoriteProductsControllerProvider._();

/// Resolves the current user's favorite product ids into [ProductModel]s.
///
/// Keeps a local id->product cache so that toggling a favorite only ever
/// fetches ids that haven't been seen before; removals are dropped from the
/// cache and the returned list without hitting Firestore again.
final class FavoriteProductsControllerProvider
    extends
        $AsyncNotifierProvider<FavoriteProductsController, List<ProductModel>> {
  /// Resolves the current user's favorite product ids into [ProductModel]s.
  ///
  /// Keeps a local id->product cache so that toggling a favorite only ever
  /// fetches ids that haven't been seen before; removals are dropped from the
  /// cache and the returned list without hitting Firestore again.
  FavoriteProductsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'favoriteProductsControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$favoriteProductsControllerHash();

  @$internal
  @override
  FavoriteProductsController create() => FavoriteProductsController();
}

String _$favoriteProductsControllerHash() =>
    r'100c0ac67ac15fed569d72f727c71cb5eedbe5f5';

/// Resolves the current user's favorite product ids into [ProductModel]s.
///
/// Keeps a local id->product cache so that toggling a favorite only ever
/// fetches ids that haven't been seen before; removals are dropped from the
/// cache and the returned list without hitting Firestore again.

abstract class _$FavoriteProductsController
    extends $AsyncNotifier<List<ProductModel>> {
  FutureOr<List<ProductModel>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<ProductModel>>, List<ProductModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<ProductModel>>, List<ProductModel>>,
              AsyncValue<List<ProductModel>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
