/// Maps native platform error codes (e.g. from platform channels) to
/// user-friendly messages.
class TPlatformException implements Exception {
  TPlatformException(this.code);

  final String code;

  String get message {
    switch (code) {
      case 'sign_in_failed':
        return 'Sign in failed. Please try again.';
      case 'network_error':
        return 'A network error occurred. Check your connection and try again.';
      case 'sign_in_canceled':
        return 'Sign in was cancelled.';
      default:
        return 'Something went wrong. Please try again.';
    }
  }

  @override
  String toString() => message;
}
