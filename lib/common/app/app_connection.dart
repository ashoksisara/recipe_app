import 'package:connectivity_plus/connectivity_plus.dart';

class AppConnection {
  static Future<bool> checkConnectivityState() async {
    final ConnectivityResult result = await Connectivity().checkConnectivity();

    if (result == ConnectivityResult.wifi) {
      print('Connected to a Wi-Fi network');
      return true;
    } else if (result == ConnectivityResult.mobile) {
      print('Connected to a mobile network');
      return true;
    } else {
      print('Not connected to any network');
      return false;
    }
  }
}
