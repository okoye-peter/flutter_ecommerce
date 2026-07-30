// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BrandController)
final brandControllerProvider = BrandControllerProvider._();

final class BrandControllerProvider
    extends $AsyncNotifierProvider<BrandController, List<BrandModel>> {
  BrandControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'brandControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$brandControllerHash();

  @$internal
  @override
  BrandController create() => BrandController();
}

String _$brandControllerHash() => r'eb97f4e2a186d6d8562ba52d10ca59e8a6e9a1fd';

abstract class _$BrandController extends $AsyncNotifier<List<BrandModel>> {
  FutureOr<List<BrandModel>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<BrandModel>>, List<BrandModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<BrandModel>>, List<BrandModel>>,
              AsyncValue<List<BrandModel>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
