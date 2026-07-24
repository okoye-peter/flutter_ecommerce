import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/core/errors/firebase_exception.dart';
import 'package:ecommerce/core/errors/format_exception.dart';
import 'package:ecommerce/core/errors/platform_exception.dart';
import 'package:ecommerce/models/banner_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BannerRepository {
  BannerRepository({FirebaseFirestore? db}) : _db = db ?? FirebaseFirestore.instance;

  final FirebaseFirestore _db;

  Future<List<BannerModel>> fetchBanners() async {
    try {
      final result = await _db
          .collection('Banners')
          .where('EndDate', isGreaterThanOrEqualTo: DateTime.now().toIso8601String())
          .get();
      return result.docs.map((docSnapshot) => BannerModel.fromDocSnapshot(docSnapshot)).toList();
    }  on FirebaseException catch (e) {
      throw TFirebaseException(e.code);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code);
    } catch (e, s) {
      debugPrint('BannerRepository.fetchBanners failed: $e\n$s');
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> uploadBanner() async {
    
  }
}
