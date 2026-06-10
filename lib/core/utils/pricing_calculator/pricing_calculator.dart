class TPricingCalculator {
  static double calculateTotalPrice(double productPrice, String location) {
    double taxeRate = getTaxRateForLocation(location);
    double taxAmount = productPrice * taxeRate;

    double shippingCost = getShippingCost(location);

    double totalPrice = productPrice + taxAmount + shippingCost;
    return totalPrice;
  }

  static String calculateShippingCost(double productPrice, String location) {
    double shippingCost = getShippingCost(location);
    return shippingCost.toStringAsFixed(2);
  }

  static String calculateTax(double productPrice, String location) {
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = productPrice * taxRate;
    return taxAmount.toStringAsFixed(2);
  }

  static double getTaxRateForLocation(String location) {
    // lookup the tax rate for the given location from a tax rate database or api
    return 0.10;
  }

  static double getShippingCost(String location) {
    return 5.00;
  }

  // static double calculateCartTotal(CartModel cart) {
  //   return cart.items
  //       .map((e) => e.price)
  //       .fold(
  //         0,
  //         (previousPrice, currentPrice) => previousPrice + (currentPrice ?? 0),
  //       );
  // }
}
