import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davetcim/shared/environments/const.dart';
import 'package:davetcim/shared/helpers/region_district_helper.dart';
import 'package:davetcim/shared/models/comment_model.dart';
import 'package:davetcim/shared/models/reservation_model.dart';
import 'package:davetcim/shared/services/database.dart';
import 'package:davetcim/shared/utils/language.dart';

import '../environments/db_constants.dart';
import '../models/corporation_model.dart';
import '../models/customer_model.dart';
import '../models/region_model.dart';

class ConversionHelper {

  Future<void> editRegions() async {
    Database db = Database();
    RegionDistrictHelper helper = RegionDistrictHelper();
    List<RegionModel> regionList =await   helper.fillRegionList();

    for(int i = 0; i < regionList.length; i++) {
      RegionModel region = regionList[i];
      region.isActive = false;
      db.editCollectionRef(DBConstants.regionDb, region.toMap());
    }
  }

}