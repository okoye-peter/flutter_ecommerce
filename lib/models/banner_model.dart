import 'package:cloud_firestore/cloud_firestore.dart';

class BannerModel {
  BannerModel({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.imageUrl,
    required this.targetScreen,
  });

  final String id;
  final String startDate;
  final String endDate;
  final String imageUrl;
  final String targetScreen;

  bool get isActive {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final start = DateTime.parse(startDate);
    final end = DateTime.parse(endDate);
    return !today.isBefore(DateTime(start.year, start.month, start.day)) &&
        !today.isAfter(DateTime(end.year, end.month, end.day));
  }

  factory BannerModel.fromDocSnapshot(DocumentSnapshot<Map<String, dynamic>> json) {
    Map<String, dynamic> data = json.data()!;
    return BannerModel(
      id: json.id,
      startDate: data['StartDate'],
      endDate: data['EndDate'],
      imageUrl: data['ImageUrl'],
      targetScreen: data['TargetScreen'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'StartDate': startDate,
      'EndDate': endDate,
      'ImageUrl': imageUrl,
      'TargetScreen': targetScreen,
    };
  }
}
