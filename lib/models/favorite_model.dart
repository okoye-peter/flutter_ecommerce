import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteModel {
  final String productId;
  final String userId;

  FavoriteModel({required this.productId, required this.userId});

  Map<String, dynamic> toJson() {
    return {'ProductId': productId, 'UserId': userId};
  }

  static FavoriteModel fromJson(Map<String, dynamic> json) {
    return FavoriteModel(productId: json['ProductId'] ?? '', userId: json['UserId'] ?? '');
  }

  factory FavoriteModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data();
    if (data != null) {
      return FavoriteModel(
        productId: data['ProductId'] ?? '',
        userId: data['UserId'] ?? '',
      );
    }
    return FavoriteModel.empty();
  }

  static FavoriteModel empty() {
    return FavoriteModel(productId: '', userId: '');
  }
}
