enum TextSizes { small, medium, large }

class OrderStatus {
  OrderStatus._();
  static const String processing = 'processing';
  static const String shipped = 'shipped';
  static const String delivered = 'delivered';
}

class PaymentMethods {
  PaymentMethods._();
  static const String paypal = 'paypal';
  static const String googlPay = 'googlPay';
  static const String applePay = 'applePay';
  static const String visa = 'visa';
  static const String masterCard = 'masterCard';
  static const String creditCard = 'creditCard';
  static const String paystack = 'paystack';
  static const String razorPay = 'razorPay';
  static const String paytm = 'paytm';
}

enum ProductType { single, variable }
