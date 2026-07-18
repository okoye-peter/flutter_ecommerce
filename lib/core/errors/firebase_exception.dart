/// Maps generic Firebase (e.g. Firestore) error codes to user-friendly messages.
class TFirebaseException implements Exception {
  TFirebaseException(this.code);

  final String code;

  String get message {
    switch (code) {
      case 'permission-denied':
        return 'You do not have permission to perform this action.';
      case 'unavailable':
        return 'Service is temporarily unavailable. Please try again.';
      case 'not-found':
        return 'The requested data could not be found.';
      case 'already-exists':
        return 'This data already exists.';
      case 'cancelled':
        return 'The operation was cancelled.';
      case 'deadline-exceeded':
        return 'The request timed out. Please try again.';
      case 'resource-exhausted':
        return 'Too many requests. Please try again later.';
      case 'unauthenticated':
        return 'Please log in to continue.';
      default:
        return 'Something went wrong. Please try again.';
    }
  }

  @override
  String toString() => message;
}
