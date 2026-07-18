import 'package:ecommerce/core/errors/firebase_auth_exception.dart';
import 'package:ecommerce/core/errors/firebase_exception.dart';
import 'package:ecommerce/core/errors/format_exception.dart';
import 'package:ecommerce/core/errors/platform_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class AuthenticationRepository {
  AuthenticationRepository({FirebaseAuth? firebaseAuth})
    : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseAuth _firebaseAuth;

  /// Emits whenever the signed-in user changes (including on app start,
  /// once Firebase has restored any persisted session).
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  User? get currentUser => _firebaseAuth.currentUser;

  /* --------------------------- Email & Password sign-in --------------------------- */

  /// [EmailAuthentication] - SignIn
  Future<UserCredential> loginWithEmailAndPassword(
    String email,
    String password,
  ) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// [EmailAuthentication] - REGISTER
  Future<UserCredential> registerWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
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

  /// [ReAuthenticate] - ReAuthenticate User
  Future<void> reAuthenticateWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final user = _firebaseAuth.currentUser;
    if (user == null) return;
    final credential = EmailAuthProvider.credential(
      email: email,
      password: password,
    );
    await user.reauthenticateWithCredential(credential);
  }

  /// [EmailVerification] - MAIL VERIFICATION
  Future<void> sendEmailVerification() async {
    await _firebaseAuth.currentUser?.sendEmailVerification();
  }

  /// [EmailAuthentication] - FORGET PASSWORD
  Future<void> sendPasswordResetEmail(String email) {
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> logout() => _firebaseAuth.signOut();
}
