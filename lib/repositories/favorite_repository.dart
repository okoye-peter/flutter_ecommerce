import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/core/errors/firebase_exception.dart';
import 'package:ecommerce/core/errors/format_exception.dart';
import 'package:ecommerce/core/errors/platform_exception.dart';
import 'package:ecommerce/models/favorite_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FavoriteRepository {
  FavoriteRepository({FirebaseFirestore? firebaseStore})
    : _db = firebaseStore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _db;

  Future<List<FavoriteModel>> fetchFavorites(String userId) async {
    try {
      final snapshot = await _db
          .collection('Favorites')
          .where('UserId', isEqualTo: userId)
          .get();

      return snapshot.docs.map((snap) => FavoriteModel.fromSnapshot(snap)).toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code);
    } catch (e, s) {
      debugPrint('FavoriteRepository.fetchFavorites failed: $e\n$s');
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> removeFavorite(String productId, String userId) async {
    try {
      final snapshot = await _db
          .collection('Favorites')
          .where('ProductId', isEqualTo: productId)
          .where('UserId', isEqualTo: userId)
          .get();

      final batch = _db.batch();
      for (final doc in snapshot.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code);
    } catch (e, s) {
      debugPrint('FavoriteRepository.removeFavorite failed: $e\n$s');
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> addFavorite(String productId, String userId) async {
    try {
      final favorite = await _db
          .collection('Favorites')
          .where('ProductId', isEqualTo: productId)
          .where('UserId', isEqualTo: userId)
          .get();
      if(favorite.docs.isEmpty) {
        await _db.collection('Favorites').add(FavoriteModel(productId: productId, userId: userId).toJson());
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code);
    } catch (e, s) {
      debugPrint('FavoriteRepository.addFavorite failed: $e\n$s');
      throw 'Something went wrong. Please try again';
    }
  }
}
