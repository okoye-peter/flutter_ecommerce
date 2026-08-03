// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand_category_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(bransForCategory)
final bransForCategoryProvider = BransForCategoryFamily._();

final class BransForCategoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<BrandModel>>,
          List<BrandModel>,
          FutureOr<List<BrandModel>>
        >
    with $FutureModifier<List<BrandModel>>, $FutureProvider<List<BrandModel>> {
  BransForCategoryProvider._({
    required BransForCategoryFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'bransForCategoryProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$bransForCategoryHash();

  @override
  String toString() {
    return r'bransForCategoryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<BrandModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<BrandModel>> create(Ref ref) {
    final argument = this.argument as String;
    return bransForCategory(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is BransForCategoryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$bransForCategoryHash() => r'c7ad8683c7e769a42d2f4c0590374639a5a2050b';

final class BransForCategoryFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<BrandModel>>, String> {
  BransForCategoryFamily._()
    : super(
        retry: null,
        name: r'bransForCategoryProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  BransForCategoryProvider call(String categoryId) =>
      BransForCategoryProvider._(argument: categoryId, from: this);

  @override
  String toString() => r'bransForCategoryProvider';
}
