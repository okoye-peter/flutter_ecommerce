// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkout_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CheckoutController)
final checkoutControllerProvider = CheckoutControllerProvider._();

final class CheckoutControllerProvider
    extends $NotifierProvider<CheckoutController, PaymentMethodModel> {
  CheckoutControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'checkoutControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$checkoutControllerHash();

  @$internal
  @override
  CheckoutController create() => CheckoutController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PaymentMethodModel value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PaymentMethodModel>(value),
    );
  }
}

String _$checkoutControllerHash() =>
    r'3f455bdd736669307a713491c6333bb8d3f753c9';

abstract class _$CheckoutController extends $Notifier<PaymentMethodModel> {
  PaymentMethodModel build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<PaymentMethodModel, PaymentMethodModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PaymentMethodModel, PaymentMethodModel>,
              PaymentMethodModel,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
