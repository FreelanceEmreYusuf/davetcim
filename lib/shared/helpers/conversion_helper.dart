import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davetcim/shared/helpers/region_district_helper.dart';
import 'package:davetcim/shared/services/database.dart';

import '../environments/db_constants.dart';
import '../models/region_model.dart';
import '../models/reservation_detail_model.dart';

class ConversionHelper {

  Database db = Database();

  Future<void> editRegions() async {
    RegionDistrictHelper helper = RegionDistrictHelper();
    List<RegionModel> regionList =await   helper.fillRegionList();

    for(int i = 0; i < regionList.length; i++) {
      RegionModel region = regionList[i];
      region.isActive = false;
      db.editCollectionRef(DBConstants.regionDb, region.toMap());
    }
  }

  Future<void> editReservationDetails() async {
    var response = await db
        .getCollectionRef(DBConstants.reservationDetailDb)
        .get();

    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      for (int i = 0; i < list.length; i++) {
        Map item = list[i].data();
        ReservationDetailModel detailModel = ReservationDetailModel.fromMap(item);
        detailModel.price = 500;
        detailModel.hasPrice = true;
        detailModel.priceChangedForCount = true;
        db.editCollectionRef(DBConstants.reservationDetailDb, detailModel.toMap());
      }
    }
  }

}