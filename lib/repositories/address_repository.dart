import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/core/errors/firebase_auth_exception.dart';
import 'package:ecommerce/core/errors/firebase_exception.dart';
import 'package:ecommerce/core/errors/format_exception.dart';
import 'package:ecommerce/core/errors/platform_exception.dart';
import 'package:ecommerce/models/address_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class AddressRepository {
  AddressRepository({FirebaseFirestore? firebaseStore})
    : _db = firebaseStore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _db;

  Future<List<AddressModel>> fetchAddresses(String userId) async {
    try {
      final snapshot = await _db
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .get();
      return snapshot.docs
          .map((snap) => AddressModel.fromSnapShot(snap))
          .toList();
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (_) {
      throw 'Something went wrong. Please try again.';
    }
  }

  CollectionReference<Map<String, dynamic>> _addresses(String userId) =>
      _db.collection('Users').doc(userId).collection('Addresses');

  Future<void> addAddress(String userId, AddressModel address) async {
    try {
      await _addresses(userId).add(address.toJson());
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (_) {
      throw 'Something went wrong. Please try again.';
    }
  }

  Future<void> updateAddress(String userId, AddressModel address) async {
    try {
      await _addresses(userId).doc(address.id).update(address.toJson());
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (_) {
      throw 'Something went wrong. Please try again.';
    }
  }

  Future<void> deleteAddress(String userId, String addressId) async {
    try {
      await _addresses(userId).doc(addressId).delete();
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (_) {
      throw 'Something went wrong. Please try again.';
    }
  }

  /// Marks [addressId] as the sole selected address, clearing the flag on
  /// every other address in the same batch so at most one stays selected.
  Future<void> selectAddress(String userId, String addressId) async {
    try {
      final snapshot = await _addresses(userId).get();

      final batch = _db.batch();
      for (final doc in snapshot.docs) {
        batch.update(doc.reference, {'SelectedAddress': doc.id == addressId});
      }
      await batch.commit();
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (_) {
      throw 'Something went wrong. Please try again.';
    }
  }
}
