import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class AppConnection {
  //check whether device is connected to internet ot not
  static Future<bool> checkConnectivityState() async {
    final ConnectivityResult result = await Connectivity().checkConnectivity();

    if (result == ConnectivityResult.wifi) {
      debugPrint('Connected to a Wi-Fi network');
      return true;
    } else if (result == ConnectivityResult.mobile) {
      debugPrint('Connected to a mobile network');
      return true;
    } else {
      debugPrint('Not connected to any network');
      return false;
    }
  }
}
