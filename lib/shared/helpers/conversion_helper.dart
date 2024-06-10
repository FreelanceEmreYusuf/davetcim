import 'package:davetcim/shared/helpers/region_district_helper.dart';
import 'package:davetcim/shared/models/corporation_model.dart';
import 'package:davetcim/shared/services/database.dart';

import '../environments/db_constants.dart';
import '../models/region_model.dart';
import '../models/reservation_detail_model.dart';
import '../models/reservation_model.dart';

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

  Future<void> editCorporation() async {
    var response = await db
        .getCollectionRef(DBConstants.corporationDb)
        .get();

    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      for (int i = 0; i < list.length; i++) {
        Map item = list[i].data();
        CorporationModel corporationModel = CorporationModel.fromMap(item);
        //corporationModel.latitude = 41.0082;
        //corporationModel.longitude = 28.9784;
        corporationModel.point = 1000 + i;

        db.editCollectionRef(DBConstants.corporationDb, corporationModel.toMap());
      }
    }
  }

  Future<void> editReservationVersion() async {
    var response = await db
        .getCollectionRef(DBConstants.corporationReservationsDb)
        .get();

    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      for (int i = 0; i < list.length; i++) {
        Map item = list[i].data();
        ReservationModel reservationModel = ReservationModel.fromMap(item);
        reservationModel.version = 1;

        db.editCollectionRef(DBConstants.corporationReservationsDb, reservationModel.toMap());
      }
    }
  }

}