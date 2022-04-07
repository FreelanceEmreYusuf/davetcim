import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davetcim/environments/db_constants.dart';
import 'package:davetcim/shared/models/district_model.dart';
import 'package:davetcim/shared/models/invitation_type_model.dart';
import 'package:davetcim/shared/models/organization_type_model.dart';
import 'package:davetcim/shared/models/region_model.dart';
import 'package:davetcim/shared/models/sequence_order_model.dart';
import 'package:davetcim/shared/services/database.dart';
import 'package:davetcim/shared/sessions/application_session.dart';
import 'package:flutter/cupertino.dart';

List<RegionModel> regionList =
    ApplicationSession.filterScreenSession.regionModelList;
List<OrganizationTypeModel> organizationTypeList =
    ApplicationSession.filterScreenSession.organizationTypeList;
List<SequenceOrderModel> sequenceOrderList =
    ApplicationSession.filterScreenSession.sequenceOrderList;
List<InvitationTypeModel> invitationList =
    ApplicationSession.filterScreenSession.invitationTypeList;
List<DistrictModel> districtList = [];


class SearchViewModel extends ChangeNotifier {
  Database db = Database();

  Future<List<DistrictModel>> fillDistrictlist(int regionCode) async {
    CollectionReference docsRef =
    db.getCollectionRef(DBConstants.districtDb);
    var response = await docsRef.where('regionId', isEqualTo: regionCode).get();

    var list = response.docs;
    print('Length : '+ list.length.toString());
    List<DistrictModel> districtList = [];
    if (regionCode == 0) {
      districtList.add(DistrictModel(
        id: 0,
        name: 'İl Seçiniz',
        regionId: 0,
      ));
    } else {
      print('Region Code :' + regionCode.toString());
      list.forEach((district) {
        print(district.id);
        Map item = district.data();
        districtList.add(DistrictModel.fromMap(item));
      });
    }

    return districtList;
  }





}
