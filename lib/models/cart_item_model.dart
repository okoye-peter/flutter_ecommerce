import 'package:cloud_firestore/cloud_firestore.dart';

class CartItemModel {
  CartItemModel({
    required this.productId,
    required this.quantity,
    this.variationId = '',
    this.image,
    this.price = 0.0,
    this.title = '',
    this.brandName,
    this.selectedVariation,
  });

  String productId;
  String title;
  double price;
  String? image;
  int quantity;
  String variationId;
  String? brandName;
  Map<String, dynamic>? selectedVariation;

  static CartItemModel empty() => CartItemModel(productId: '', quantity: 0);

  CartItemModel copyWith({
    String? productId,
    String? title,
    double? price,
    String? image,
    int? quantity,
    String? variationId,
    String? brandName,
    Map<String, dynamic>? selectedVariation,
  }) {
    return CartItemModel(
      productId: productId ?? this.productId,
      title: title ?? this.title,
      price: price ?? this.price,
      image: image ?? this.image,
      quantity: quantity ?? this.quantity,
      variationId: variationId ?? this.variationId,
      brandName: brandName ?? this.brandName,
      selectedVariation: selectedVariation ?? this.selectedVariation,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ProductId': productId,
      'Title': title,
      'Price': price,
      'Image': image,
      'Quantity': quantity,
      'VariationId': variationId,
      'BrandName': brandName,
      'SelectedVariation': selectedVariation,
    };
  }

  factory CartItemModel.fromSnapShot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    if(snapshot.id.isEmpty || data.isEmpty){
      return CartItemModel.empty();
    }

    return CartItemModel(
      productId: data['ProductId'] ?? '',
      title: data['Title'] ?? '',
      price: (data['Price'] ?? 0.0).toDouble(),
      image: data['Image'],
      quantity: data['Quantity'] ?? 0,
      variationId: data['VariationId'] ?? '',
      brandName: data['BrandName'],
      selectedVariation: data['SelectedVariation'] != null ? Map<String, dynamic>.from(data['SelectedVariation']) : null,
    );
  }
}
