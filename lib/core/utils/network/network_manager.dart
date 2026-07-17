import 'package:connectivity_plus/connectivity_plus.dart';

/// Checks and observes network connectivity.
class NetworkManager {
  final Connectivity _connectivity = Connectivity();

  /// Whether the device currently has network connectivity.
  Future<bool> isConnected() async {
    final result = await _connectivity.checkConnectivity();
    return !result.contains(ConnectivityResult.none);
  }

  /// Emits `true`/`false` whenever connectivity changes.
  Stream<bool> get onConnectivityChanged => _connectivity.onConnectivityChanged
      .map((results) => !results.contains(ConnectivityResult.none));
}
