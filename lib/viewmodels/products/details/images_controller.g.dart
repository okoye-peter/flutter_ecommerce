// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'images_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(productImages)
final productImagesProvider = ProductImagesFamily._();

final class ProductImagesProvider
    extends $FunctionalProvider<List<String>, List<String>, List<String>>
    with $Provider<List<String>> {
  ProductImagesProvider._({
    required ProductImagesFamily super.from,
    required ProductModel super.argument,
  }) : super(
         retry: null,
         name: r'productImagesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$productImagesHash();

  @override
  String toString() {
    return r'productImagesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<List<String>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<String> create(Ref ref) {
    final argument = this.argument as ProductModel;
    return productImages(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<String>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ProductImagesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$productImagesHash() => r'826824d4269c772325e80db5b1ad815f3c0a1dd1';

final class ProductImagesFamily extends $Family
    with $FunctionalFamilyOverride<List<String>, ProductModel> {
  ProductImagesFamily._()
    : super(
        retry: null,
        name: r'productImagesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ProductImagesProvider call(ProductModel product) =>
      ProductImagesProvider._(argument: product, from: this);

  @override
  String toString() => r'productImagesProvider';
}

@ProviderFor(ImagesController)
final imagesControllerProvider = ImagesControllerFamily._();

final class ImagesControllerProvider
    extends $NotifierProvider<ImagesController, ImagesState> {
  ImagesControllerProvider._({
    required ImagesControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'imagesControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$imagesControllerHash();

  @override
  String toString() {
    return r'imagesControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ImagesController create() => ImagesController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ImagesState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ImagesState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ImagesControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$imagesControllerHash() => r'5b4c98d6627ec1a6a76cbfbb28cff46a4e0ca099';

final class ImagesControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          ImagesController,
          ImagesState,
          ImagesState,
          ImagesState,
          String
        > {
  ImagesControllerFamily._()
    : super(
        retry: null,
        name: r'imagesControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ImagesControllerProvider call(String defaultImage) =>
      ImagesControllerProvider._(argument: defaultImage, from: this);

  @override
  String toString() => r'imagesControllerProvider';
}

abstract class _$ImagesController extends $Notifier<ImagesState> {
  late final _$args = ref.$arg as String;
  String get defaultImage => _$args;

  ImagesState build(String defaultImage);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ImagesState, ImagesState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ImagesState, ImagesState>,
              ImagesState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
