/// Maps Firebase Auth error codes to user-friendly messages.
class TFirebaseAuthException implements Exception {
  TFirebaseAuthException(this.code);

  final String code;

  String get message {
    switch (code) {
      case 'email-already-in-use':
        return 'This email is already registered. Try logging in instead.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'user-disabled':
        return 'This account has been disabled. Contact support for help.';
      case 'user-not-found':
        return 'No account found with this email.';
      case 'wrong-password':
      case 'invalid-credential':
        return 'Incorrect email or password.';
      case 'weak-password':
        return 'Your password is too weak. Please choose a stronger one.';
      case 'operation-not-allowed':
        return 'This sign-in method is currently disabled.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      case 'network-request-failed':
        return 'A network error occurred. Check your connection and try again.';
      case 'requires-recent-login':
        return 'Please log in again to complete this action.';
      default:
        return 'Something went wrong. Please try again.';
    }
  }

  @override
  String toString() => message;
}
