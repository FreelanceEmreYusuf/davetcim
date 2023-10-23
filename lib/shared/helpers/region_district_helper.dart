import 'package:cloud_firestore/cloud_firestore.dart';

import '../environments/db_constants.dart';
import '../models/district_model.dart';
import '../models/region_model.dart';
import '../services/database.dart';

class RegionDistrictHelper {
  Database db = Database();

  Future<List<RegionModel>> fillRegionList() async {
    CollectionReference docsRef = db.getCollectionRef(DBConstants.regionDb);
    var response = await docsRef.where('isActive', isEqualTo:true)
        /*.orderBy('id', descending: false)*/.get();

    var list = response.docs;
    List<RegionModel> regionList = [];
    list.forEach((region) {
      Map item = region.data();
      if (item!=null && item["id"] == 34) {
        regionList.add(RegionModel.fromMap(item));
      }
    });
    list.forEach((region) {
      Map item = region.data();
      if (item!=null && item["id"] == 6) {
        regionList.add(RegionModel.fromMap(item));
      }
    });
    list.forEach((region) {
      Map item = region.data();
      if (item!=null && item["id"] == 35) {
        regionList.add(RegionModel.fromMap(item));
      }
    });
    list.forEach((region) {
      Map item = region.data();
      if (item!=null && item["id"] != 34 && item["id"] != 35 && item["id"] != 6) {
        regionList.add(RegionModel.fromMap(item));
      }
    });

    return regionList;
  }

  Future<List<DistrictModel>> fillDistrictList(int regionCode) async {
    var response = await db
        .getCollectionRef(DBConstants.districtDb)
        .where('regionId', isEqualTo: regionCode).get();

    var list = response.docs;
    List<DistrictModel> districtList = [];
    list.forEach((region) {
      Map item = region.data();
      districtList.add(DistrictModel.fromMap(item));
    });

    return districtList;
  }

}