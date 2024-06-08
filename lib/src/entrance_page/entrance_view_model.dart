import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davetcim/shared/environments/db_constants.dart';
import 'package:davetcim/shared/helpers/corporate_helper.dart';
import 'package:davetcim/shared/models/customer_model.dart';
import 'package:davetcim/shared/models/invitation_type_model.dart';
import 'package:davetcim/shared/models/organization_type_model.dart';
import 'package:davetcim/shared/models/sequence_order_model.dart';
import 'package:davetcim/shared/services/database.dart';
import 'package:davetcim/shared/sessions/organization_items_state.dart';
import 'package:flutter/cupertino.dart';
import '../../shared/helpers/customer_helper.dart';
import '../../shared/helpers/region_district_helper.dart';
import '../../shared/helpers/remember_me_helper.dart';
import '../../shared/models/region_model.dart';
import '../../shared/models/remember_me_model.dart';
import '../../shared/utils/device_info.dart';

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

  Future<void> controlAndFillUserSession() async {
    RememberMeHelper rememberMeHelper = RememberMeHelper();
    String imeiNumber = await DeviceInfo.getDeviceImeiNumber();
    RememberMeModel rememberMeModel = await rememberMeHelper.getByUserImeiCode(imeiNumber);

    if (rememberMeModel != null) {
      CustomerHelper customerHelper = CustomerHelper();
      CustomerModel customerModel =
        await customerHelper.getCustomerByUserName(rememberMeModel.userName);
      await customerHelper.fillUserSession(customerModel);
    }
  }

  Future<List<OrganizationTypeModel>> fillOrganizationTypeList() async {
    CollectionReference docsRef =
        db.getCollectionRef(DBConstants.organizationTypeDb);
    var response = await docsRef.orderBy('name').get();

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
    var response = await docsRef.orderBy('name').get();

    var list = response.docs;
    List<InvitationTypeModel> invitationTypeList = [];
    list.forEach((invitationType) {
      Map item = invitationType.data();
      InvitationTypeModel invitationTypeModel = InvitationTypeModel.fromMap(item);
      invitationTypeModel.isChecked = false;
      invitationTypeList.add(invitationTypeModel);
    });

    return invitationTypeList;
  }

  Future<List<SequenceOrderModel>> fillSequenceOrderList() async {
    CollectionReference docsRef =
        db.getCollectionRef(DBConstants.sequenceOrderDb);
    var response = await docsRef.orderBy('name').get();

    var list = response.docs;
    List<SequenceOrderModel> sequenceOrderList = [];
    list.forEach((sequenceOrder) {
      Map item = sequenceOrder.data();
      SequenceOrderModel sequenceOrderModel = SequenceOrderModel.fromMap(item);
      sequenceOrderModel.isChecked = false;
      sequenceOrderList.add(sequenceOrderModel);
    });

    return sequenceOrderList;
  }
}
