// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AddressController)
final addressControllerProvider = AddressControllerProvider._();

final class AddressControllerProvider
    extends $AsyncNotifierProvider<AddressController, List<AddressModel>> {
  AddressControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'addressControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$addressControllerHash();

  @$internal
  @override
  AddressController create() => AddressController();
}

String _$addressControllerHash() => r'1007f884dad21dd44de24900299e3feaea83beec';

abstract class _$AddressController extends $AsyncNotifier<List<AddressModel>> {
  FutureOr<List<AddressModel>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<AddressModel>>, List<AddressModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<AddressModel>>, List<AddressModel>>,
              AsyncValue<List<AddressModel>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
