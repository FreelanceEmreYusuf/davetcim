import 'package:davetcim/shared/environments/db_constants.dart';
import 'package:davetcim/shared/services/database.dart';
import 'package:davetcim/shared/utils/device_info.dart';
import 'package:flutter/cupertino.dart';

class SplashModel extends ChangeNotifier {
  Database db = Database();

  Future<bool> willDemoShowed() async {
    var response = await db
        .getCollectionRef(DBConstants.bypassInfoPageDb)
        .where('imeiCode', isEqualTo: await DeviceInfo.getDeviceImeiNumber())
        .get();

    if (response.docs != null && response.docs.length > 0) {
      return false;
    }

    return true;
  }
}
