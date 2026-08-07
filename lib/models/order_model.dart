import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/core/constants/enums.dart';
import 'package:ecommerce/core/helpers/helper_functions.dart';
import 'package:ecommerce/models/address_model.dart';
import 'package:ecommerce/models/cart_item_model.dart';

class OrderModel {
  final String id;
  final String userId;
  final OrderStatus status;
  final double totalAmount;
  final DateTime orderDate;
  final String paymentMethod;
  final AddressModel? address;
  final DateTime? deliveryDate;
  final List<CartItemModel> items;

  OrderModel({
    required this.id,
    required this.userId,
    required this.status,
    required this.totalAmount,
    required this.orderDate,
    this.paymentMethod = 'paystack',
    this.address,
    this.deliveryDate,
    required this.items,
  });

  String get formattedOrderDate => THelperFunctions.getFormattedDate(orderDate);

  String get formattedDeliveryDate => deliveryDate != null
      ? THelperFunctions.getFormattedDate(deliveryDate!)
      : '';

  String get orderStatusText => status == OrderStatus.delivered
      ? 'Delivered'
      : status == OrderStatus.shipped
      ? 'Shipment on the way'
      : 'Processing';

  static OrderModel empty() {
    return OrderModel(
      id: '',
      userId: '',
      status: OrderStatus.processing,
      totalAmount: 0.0,
      orderDate: DateTime.now(),
      items: [],
    );
  }

  factory OrderModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    if (data == null) return OrderModel.empty();

    return OrderModel(
      id: data['Id'] ?? '',
      userId: data['UserId'] ?? '',
      status: OrderStatus.values.byName(data['Status'] ?? 'processing'),
      totalAmount: (data['TotalAmount'] ?? 0.0).toDouble(),
      orderDate: DateTime.parse(data['OrderDate']),
      paymentMethod: data['PaymentMethod'] ?? 'paystack',
      address: data['Address'] != null
          ? AddressModel.fromJson(Map<String, dynamic>.from(data['Address']))
          : null,
      deliveryDate: data['DeliveryDate'] != null
          ? DateTime.parse(data['DeliveryDate'])
          : null,
      items: (data['Items'] as List<dynamic>? ?? [])
          .map((item) => CartItemModel.fromJson(Map<String, dynamic>.from(item)))
          .toList(),
    );
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['Id'] ?? '',
      userId: json['UserId'] ?? '',
      status: OrderStatus.values.byName(json['Status'] ?? 'processing'),
      totalAmount: (json['TotalAmount'] ?? 0.0).toDouble(),
      orderDate: DateTime.parse(json['OrderDate']),
      paymentMethod: json['PaymentMethod'] ?? 'paystack',
      address: json['Address'] != null
          ? AddressModel.fromJson(Map<String, dynamic>.from(json['Address']))
          : null,
      deliveryDate: json['DeliveryDate'] != null
          ? DateTime.parse(json['DeliveryDate'])
          : null,
      items: (json['Items'] as List<dynamic>? ?? [])
          .map((item) => CartItemModel.fromJson(Map<String, dynamic>.from(item)))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'UserId': userId,
      'Status': status.name,
      'TotalAmount': totalAmount,
      'OrderDate': orderDate.toIso8601String(),
      'PaymentMethod': paymentMethod,
      'Address': address?.toJson(),
      'DeliveryDate': deliveryDate?.toIso8601String(),
      'Items': items.map((item) => item.toJson()).toList(),
    };
  }
}
