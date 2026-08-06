import 'package:ecommerce/core/constants/image_strings.dart';
import 'package:ecommerce/core/providers/providers.dart';
import 'package:ecommerce/core/utils/local_storage/local_storage.dart';
import 'package:ecommerce/models/payment_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'checkout_controller.g.dart';

@Riverpod(keepAlive: true)
class CheckoutController extends _$CheckoutController {
  late LocalStorage _storage;
  static final String _prefKey = LocalStorage.scopedKey('selectedPaymentMethod');

  @override
  PaymentMethodModel build() {
    _storage = ref.read(localStorageProvider);
    if (_storage.hasKey(_prefKey)) {
      return PaymentMethodModel.fromJson(_storage.readObject(_prefKey)!);
    }

    return const PaymentMethodModel(image: TImages.paystack, name: 'Paystack');
  }

  List<PaymentMethodModel> getPaymentMethods() {
    return const [
      PaymentMethodModel(image: TImages.paystack, name: 'Paystack'),
      PaymentMethodModel(image: TImages.stripe, name: 'Stripe'),
      PaymentMethodModel(image: TImages.flutterwave, name: 'Flutterwave'),
    ];
  }

  void saveSelectedPaymentOption(PaymentMethodModel payment) {
    _storage.writeObject(_prefKey, payment.toJson());
    state = state.copyWith(newName: payment.name, imageUrl: payment.image);
  }
}
