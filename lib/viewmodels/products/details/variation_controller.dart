import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/models/product_variation_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'variation_controller.g.dart';

class VariationState {
  VariationState({
    ProductVariationModel? selectedAttribute,
    Map<String, String>? selectedAttributes,
    this.variationStockStatus = '',
  }) : selectedAttribute = selectedAttribute ?? ProductVariationModel.empty(),
       selectedAttributes = selectedAttributes ?? {};

  ProductVariationModel selectedAttribute;
  String variationStockStatus;
  Map<String, String> selectedAttributes;

  /// The matched variation once a full set of attributes resolves to one,
  /// or null while the selection is empty/partial.
  ProductVariationModel? get resolvedVariation =>
      selectedAttribute.id.isNotEmpty ? selectedAttribute : null;

  VariationState copyWith({
    ProductVariationModel? selectedAttribute,
    String? variationStockStatus,
    Map<String, String>? selectedAttributes,
  }) {
    return VariationState(
      selectedAttribute: selectedAttribute ?? this.selectedAttribute,
      variationStockStatus: variationStockStatus ?? this.variationStockStatus,
      selectedAttributes: selectedAttributes ?? this.selectedAttributes,
    );
  }
}

@riverpod
class VariationController extends _$VariationController {
  @override
  VariationState build() {
    return VariationState();
  }

  void getProductVariationStockStatus() {
    state = state.copyWith(
      variationStockStatus: state.selectedAttribute.stock > 0
          ? 'In Stock'
          : 'Out of Stock',
    );
  }

  void onSelectAttribute(
    ProductModel product,
    String attributeName,
    String attributeValue,
  ) {
    final selectedAttributes = Map<String, String>.from(state.selectedAttributes)
      ..[attributeName] = attributeValue;

    final variation = (product.productVariations ?? []).firstWhere(
      (variation) =>
          _isSameAttributeValues(variation.attributeValues, selectedAttributes),
      orElse: () => ProductVariationModel.empty(),
    );

    state = state.copyWith(
      selectedAttributes: selectedAttributes,
      selectedAttribute: variation,
      variationStockStatus: variation.stock > 0 ? 'In Stock' : 'Out of Stock',
    );
  }

  bool _isSameAttributeValues(
    Map<String, String> variationAttributes,
    Map<String, String> selectedAttributes,
  ) {
    if (variationAttributes.length != selectedAttributes.length) return false;

    for (final entry in variationAttributes.entries) {
      if (selectedAttributes[entry.key] != entry.value) return false;
    }

    return true;
  }

  /// Values [attributeName] can still take on given what's already picked
  /// for the *other* attributes — a catalog rarely stocks every combination,
  /// so e.g. once Color=Grey is chosen, Size must only offer the sizes that
  /// actually exist for Grey, not every size that exists for any color.
  Set<String?> getAttributesAvailabilityInVariation(
    List<ProductVariationModel> variation,
    String attributeName,
    Map<String, String> selectedAttributes,
  ) {
    return variation
        .where((v) {
          final value = v.attributeValues[attributeName];
          if (value == null || value.isEmpty || v.stock <= 0) return false;

          for (final entry in selectedAttributes.entries) {
            if (entry.key == attributeName) continue;
            if (v.attributeValues[entry.key] != entry.value) return false;
          }
          return true;
        })
        .map((v) => v.attributeValues[attributeName])
        .toSet();
  }

  /// Selects a specific variation directly (e.g. the user tapped its photo
  /// in the image carousel rather than an attribute chip), keeping the
  /// attribute selections and resolved variation in sync either way.
  void selectVariation(ProductVariationModel variation) {
    state = state.copyWith(
      selectedAttributes: variation.attributeValues,
      selectedAttribute: variation,
      variationStockStatus: variation.stock > 0 ? 'In Stock' : 'Out of Stock',
    );
  }

  void resetSelectedAttribute() {
    state = state.copyWith(
      selectedAttribute: ProductVariationModel.empty(),
      variationStockStatus: '',
      selectedAttributes: {},
    );
  }
}
