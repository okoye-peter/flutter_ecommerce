import 'package:ecommerce/core/constants/enums.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/models/product_variation_model.dart';

class TPricingHelper {
  TPricingHelper._();

  /// The product's price, or a `"$min - $max"` range across its variations
  /// for variable products. Pass [variation] once one is resolved from the
  /// user's attribute selection to show its exact price instead of the range.
  static String getProductPrice(
    ProductModel product, {
    ProductVariationModel? variation,
  }) {
    if (variation != null) {
      return '${variation.salePrice > 0 ? variation.salePrice : variation.price}';
    }

    if (product.productType == ProductType.single.name) {
      return '${product.salePrice > 0 ? product.salePrice : product.price}';
    }

    double smallestPrice = double.infinity;
    double largestPrice = 0.0;

    for (var variation in product.productVariations!) {
      final priceToConsider = variation.salePrice > 0.0
          ? variation.salePrice
          : variation.price;

      if (priceToConsider < smallestPrice) {
        smallestPrice = priceToConsider;
      }

      if (priceToConsider > largestPrice) {
        largestPrice = priceToConsider;
      }
    }

    if (smallestPrice == largestPrice) {
      return '$largestPrice';
    }
    return '$smallestPrice - $largestPrice';
  }

  /// The discount percentage of [salePrice] off [originalPrice], or null if
  /// there's no valid discount.
  static String? calculateSalePercentage(
    double originalPrice,
    double? salePrice,
  ) {
    if (salePrice == null || salePrice <= 0.0 || originalPrice <= 0) {
      return null;
    }

    final percentage = ((originalPrice - salePrice) / originalPrice) * 100;
    return percentage.toStringAsFixed(0);
  }

  static String getProductStockStatus(int stock) {
    return stock > 0 ? 'In Stock' : 'Out of Stock';
  }
}
