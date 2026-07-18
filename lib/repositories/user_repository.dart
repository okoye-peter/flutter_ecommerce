import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/core/errors/firebase_auth_exception.dart';
import 'package:ecommerce/core/errors/format_exception.dart';
import 'package:ecommerce/core/errors/platform_exception.dart';
import 'package:ecommerce/models/user_model.dart';
import 'package:flutter/services.dart';

class UserRepository {
  UserRepository({FirebaseFirestore? firebaseFirestore})
    : _firebaseFireStore = firebaseFirestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firebaseFireStore;

  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _firebaseFireStore
          .collection('Users')
          .doc(user.id)
          .set(user.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
