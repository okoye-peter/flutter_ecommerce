import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/core/utils/formatters/formatter_utility.dart';

class AddressModel {
  AddressModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    this.dateTime,
    this.isSelectedAddress = false,
  });

  String id;
  final String name;
  final String phoneNumber;
  final String street;
  final String city;
  final String state;
  final String postalCode;
  final String country;
  final DateTime? dateTime;
  bool? isSelectedAddress;

  String get formattedPhoneNo =>
      TFormatter.formatPhoneNumberInternational(phoneNumber);

  static AddressModel empty() => AddressModel(
    id: '',
    name: '',
    phoneNumber: '',
    street: '',
    city: '',
    state: '',
    postalCode: '',
    country: '',
  );

  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'PhoneNumber': phoneNumber,
      'Street': street,
      'City': city,
      'State': state,
      'PostalCode': postalCode,
      'Country': country,
      'DateTime': DateTime.now(), //dateTime?.toIso8601String(),
      'SelectedAddress': isSelectedAddress ?? false,
    };
  }

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['Id'] ?? '',
      name: json['Name'] ?? '',
      phoneNumber: json['PhoneNumber'] ?? '',
      street: json['Street'] ?? '',
      city: json['City'] ?? '',
      state: json['State'] ?? '',
      postalCode: json['PostalCode'] ?? '',
      country: json['Country'] ?? '',
      dateTime: json['DateTime'] != null
          ? (json['DateTime'] as Timestamp).toDate()
          : null,
      isSelectedAddress: json['SelectedAddress'] ?? false,
    );
  }

  factory AddressModel.fromSnapShot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    if(snapshot.id.isEmpty || data.isEmpty){
      return AddressModel.empty();
    }

    return AddressModel(
      id: snapshot.id,
      name: data['Name'] ?? '',
      phoneNumber: data['PhoneNumber'] ?? '',
      street: data['Street'] ?? '',
      city: data['City'] ?? '',
      state: data['State'] ?? '',
      postalCode: data['PostalCode'] ?? '',
      country: data['Country'] ?? '',
      dateTime: (data['DateTime'] as Timestamp?)?.toDate(),
      isSelectedAddress: data['SelectedAddress'] ?? false,
    );
  }

  @override
  String  toString() {
    return '$street, $city, $state, $postalCode, $country';
  }
}
