import 'dart:io';
//import 'package:unique_identifier/unique_identifier.dart';
import 'package:device_info/device_info.dart';

class DeviceInfo {

  static Future<String> getDeviceImeiNumber() async {
    if (Platform.isAndroid) {
      final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
      var data = await deviceInfoPlugin.androidInfo;
      return data.androidId;
    } else if (Platform.isIOS) {
      final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
      var data = await deviceInfoPlugin.iosInfo;
      return data.identifierForVendor;
    }
  }
}