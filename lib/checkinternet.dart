import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';

Future<bool> checkInternetConnectivity(context) async {
  final Connectivity connectivity = Connectivity();
  late ConnectivityResult connectivityResult;
  // Platform messages may fail, so we use a try/catch PlatformException.
  try {
    connectivityResult = await connectivity.checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      return false;
    }
  } on PlatformException catch (e) {
    print(e);
    return false;
  }
}
