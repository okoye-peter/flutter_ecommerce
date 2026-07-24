// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BannerController)
final bannerControllerProvider = BannerControllerProvider._();

final class BannerControllerProvider
    extends $AsyncNotifierProvider<BannerController, BannerState> {
  BannerControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bannerControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bannerControllerHash();

  @$internal
  @override
  BannerController create() => BannerController();
}

String _$bannerControllerHash() => r'7c085d8675f28ef4153774b2160409f6aca7381f';

abstract class _$BannerController extends $AsyncNotifier<BannerState> {
  FutureOr<BannerState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<BannerState>, BannerState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<BannerState>, BannerState>,
              AsyncValue<BannerState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
