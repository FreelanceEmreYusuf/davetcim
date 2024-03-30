import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davetcim/shared/environments/db_constants.dart';
import 'package:davetcim/shared/models/invitation_type_model.dart';
import 'package:davetcim/shared/models/organization_type_model.dart';
import 'package:davetcim/shared/models/sequence_order_model.dart';
import 'package:davetcim/shared/services/database.dart';
import 'package:davetcim/shared/sessions/organization_items_state.dart';
import 'package:flutter/cupertino.dart';
import '../../shared/helpers/region_district_helper.dart';
import '../../shared/models/region_model.dart';

class EntrancePageModel extends ChangeNotifier {
  Database db = Database();

  Future<void> fillFilterScreenSession() async {
    if (!OrganizationItemsState.isPresent()) {
      RegionDistrictHelper regionDistrictHelper = RegionDistrictHelper();
      List<OrganizationTypeModel> organizationTypeList = await fillOrganizationTypeList();
      List<InvitationTypeModel> invitationTypeList = await fillInvitationTypeList();
      List<SequenceOrderModel> sequenceOrderList = await fillSequenceOrderList();
      List<RegionModel> regionList = await regionDistrictHelper.fillRegionList();

      OrganizationItemsState.set(organizationTypeList,
          invitationTypeList,
          sequenceOrderList,
          regionList);
    }
  }

  Future<List<OrganizationTypeModel>> fillOrganizationTypeList() async {
    CollectionReference docsRef =
        db.getCollectionRef(DBConstants.organizationTypeDb);
    var response = await docsRef.orderBy('sortingIndex').get();

    var list = response.docs;
    List<OrganizationTypeModel> organizationList = [];
    list.forEach((organizationType) {
      Map item = organizationType.data();
      OrganizationTypeModel organizationTypeModel = OrganizationTypeModel.fromMap(item);
      organizationTypeModel.isChecked = false;
      organizationList.add(organizationTypeModel);
    });

    return organizationList;
  }

  Future<List<InvitationTypeModel>> fillInvitationTypeList() async {
    CollectionReference docsRef =
        db.getCollectionRef(DBConstants.invitationTypeDb);
    var response = await docsRef.orderBy('sortingIndex').get();

    var list = response.docs;
    List<InvitationTypeModel> invitationTypeList = [];
    list.forEach((invitationType) {
      Map item = invitationType.data();
      invitationTypeList.add(InvitationTypeModel.fromMap(item));
    });

    return invitationTypeList;
  }

  Future<List<SequenceOrderModel>> fillSequenceOrderList() async {
    CollectionReference docsRef =
        db.getCollectionRef(DBConstants.sequenceOrderDb);
    var response = await docsRef.orderBy('sortingIndex').get();

    var list = response.docs;
    List<SequenceOrderModel> sequenceOrderList = [];
    list.forEach((sequenceOrder) {
      Map item = sequenceOrder.data();
      sequenceOrderList.add(SequenceOrderModel.fromMap(item));
    });

    return sequenceOrderList;
  }
}
