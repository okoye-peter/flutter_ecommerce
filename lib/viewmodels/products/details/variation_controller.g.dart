// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variation_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(VariationController)
final variationControllerProvider = VariationControllerProvider._();

final class VariationControllerProvider
    extends $NotifierProvider<VariationController, VariationState> {
  VariationControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'variationControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$variationControllerHash();

  @$internal
  @override
  VariationController create() => VariationController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VariationState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VariationState>(value),
    );
  }
}

String _$variationControllerHash() =>
    r'f3ab94ff2177b8cf2bcf00129f017d03ce428f8c';

abstract class _$VariationController extends $Notifier<VariationState> {
  VariationState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<VariationState, VariationState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<VariationState, VariationState>,
              VariationState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
