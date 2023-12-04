import 'package:davetcim/shared/environments/db_constants.dart';
import 'package:davetcim/shared/models/application_image_model.dart';
import 'package:davetcim/shared/models/bypass_info_page_model.dart';
import 'package:davetcim/shared/services/database.dart';
import 'package:davetcim/shared/utils/device_info.dart';
import 'package:flutter/cupertino.dart';

class WalkthroughViewModel extends ChangeNotifier {
  Database db = Database();

  Future<void> createBypassInfoData() async {
    BypassInfoPageModel model = new BypassInfoPageModel(
        id: new DateTime.now().millisecondsSinceEpoch,
        imeiCode: await DeviceInfo.getDeviceImeiNumber());
    db.editCollectionRef(DBConstants.bypassInfoPageDb, model.toMap());
  }

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

  Future<List<ApplicationImageModel>> getApplicationImageList() async {
    var response = await db
        .getCollectionRef(DBConstants.applicationImagesDb)
        .get();

    List<ApplicationImageModel> applicationImageList = [];
    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      for (int i = 0; i < list.length; i++) {
        applicationImageList.add(ApplicationImageModel.fromMap(list[i].data()));
      }
    }

    return applicationImageList;
  }


}
