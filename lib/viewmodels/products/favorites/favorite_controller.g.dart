// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FavoriteController)
final favoriteControllerProvider = FavoriteControllerProvider._();

final class FavoriteControllerProvider
    extends $AsyncNotifierProvider<FavoriteController, List<FavoriteModel>> {
  FavoriteControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'favoriteControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$favoriteControllerHash();

  @$internal
  @override
  FavoriteController create() => FavoriteController();
}

String _$favoriteControllerHash() =>
    r'd31962146a67858fb94fa8d822e948622e8bf9ba';

abstract class _$FavoriteController
    extends $AsyncNotifier<List<FavoriteModel>> {
  FutureOr<List<FavoriteModel>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<FavoriteModel>>, List<FavoriteModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<FavoriteModel>>, List<FavoriteModel>>,
              AsyncValue<List<FavoriteModel>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
