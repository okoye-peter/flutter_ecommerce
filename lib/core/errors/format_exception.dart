/// Thrown when a value (e.g. an ID or token) is malformed.
class TFormatException implements Exception {
  const TFormatException();

  String get message =>
      'The information you entered is not in the correct format.';

  @override
  String toString() => message;
}
