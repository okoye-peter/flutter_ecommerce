import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/core/errors/firebase_exception.dart';
import 'package:ecommerce/core/errors/format_exception.dart';
import 'package:ecommerce/core/errors/platform_exception.dart';
import 'package:ecommerce/models/user_model.dart';
import 'package:ecommerce/repositories/authentication_repository.dart';
import 'package:flutter/services.dart';

class UserRepository {
  UserRepository({
    required this._authenticationRepository,
    FirebaseFirestore? firebaseFirestore,
  }) : _firebaseFireStore = firebaseFirestore ?? FirebaseFirestore.instance;

  final AuthenticationRepository _authenticationRepository;
  final FirebaseFirestore _firebaseFireStore;

  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _firebaseFireStore
          .collection('Users')
          .doc(user.id)
          .set(user.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnapShot = await _firebaseFireStore
          .collection('Users')
          .doc(_authenticationRepository.currentUser?.uid)
          .get();

      if (documentSnapShot.exists) {
        return UserModel.fromSnapshot(documentSnapShot);
      } else {
        return UserModel.empty();
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> updateUserDetails(UserModel updatedUser) async {
    try {
      await _firebaseFireStore
          .collection('Users')
          .doc(updatedUser.id)
          .update(updatedUser.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _firebaseFireStore.collection('Users').doc(_authenticationRepository.currentUser?.uid).update(json);
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> removeUserRecord(String userId) async {
    try {
      await _firebaseFireStore.collection('Users').doc(userId).delete();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
