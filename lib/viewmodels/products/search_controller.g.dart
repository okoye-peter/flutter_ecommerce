// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SearchController)
final searchControllerProvider = SearchControllerFamily._();

final class SearchControllerProvider
    extends $AsyncNotifierProvider<SearchController, List<ProductModel>> {
  SearchControllerProvider._({
    required SearchControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'searchControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$searchControllerHash();

  @override
  String toString() {
    return r'searchControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  SearchController create() => SearchController();

  @override
  bool operator ==(Object other) {
    return other is SearchControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$searchControllerHash() => r'706a318764c393746e45aa60d087fa523ccae2e5';

final class SearchControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          SearchController,
          AsyncValue<List<ProductModel>>,
          List<ProductModel>,
          FutureOr<List<ProductModel>>,
          String
        > {
  SearchControllerFamily._()
    : super(
        retry: null,
        name: r'searchControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SearchControllerProvider call(String query) =>
      SearchControllerProvider._(argument: query, from: this);

  @override
  String toString() => r'searchControllerProvider';
}

abstract class _$SearchController extends $AsyncNotifier<List<ProductModel>> {
  late final _$args = ref.$arg as String;
  String get query => _$args;

  FutureOr<List<ProductModel>> build(String query);
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
    return element.handleCreate(ref, () => build(_$args));
  }
}
