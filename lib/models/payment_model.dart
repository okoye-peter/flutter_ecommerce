class PaymentMethodModel {
  final String name;
  final String image;
  const PaymentMethodModel({required this.image, required this.name});

  static PaymentMethodModel empty() => const PaymentMethodModel(image: '', name: '');

  factory PaymentMethodModel.fromJson(Map<String, dynamic> data) {
    return PaymentMethodModel(
      image: data['image'] as String? ?? '',
      name: data['name'] as String? ?? '',
    );
  }

  PaymentMethodModel copyWith({String? imageUrl, String? newName}) {
    return PaymentMethodModel(image: imageUrl ?? image, name: newName ?? name);
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'name': name,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentMethodModel && name == other.name && image == other.image;

  @override
  int get hashCode => Object.hash(name, image);
}
