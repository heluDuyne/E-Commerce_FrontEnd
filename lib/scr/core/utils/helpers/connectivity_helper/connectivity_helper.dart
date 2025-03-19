import 'package:connectivity_plus/connectivity_plus.dart';


/**
 * This class is used to check the connectivity of the device.
 */

class ConnectivityHelper {
  Future<bool> CheckConnectivity() async {
    final List<ConnectivityResult> connectivityResult = await Connectivity().checkConnectivity();
    return _handleResult(connectivityResult);
  }

  static Stream<List<ConnectivityResult>> listenToConnectivityChanged() {
    return Connectivity().onConnectivityChanged;
  }

  bool _handleResult(List<ConnectivityResult> connectivityResult) {
    if (connectivityResult.isEmpty) {
      return false;
    } else if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      return true;
    } else {
      return false;
    }
  }
}