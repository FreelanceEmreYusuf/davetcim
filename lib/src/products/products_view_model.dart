import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davetcim/shared/dto/product_filterer_dto.dart';
import 'package:davetcim/shared/environments/db_constants.dart';
import 'package:davetcim/shared/models/corporation_model.dart';
import 'package:davetcim/shared/models/sequence_order_model.dart';
import 'package:davetcim/shared/services/database.dart';
import 'package:davetcim/shared/utils/date_utils.dart';
import 'package:flutter/cupertino.dart';

import '../../shared/models/corporate_sessions_model.dart';
import '../../shared/models/district_model.dart';
import '../../shared/models/invitation_type_model.dart';
import '../../shared/models/organization_type_model.dart';
import '../../shared/models/reservation_model.dart';
import '../../shared/sessions/product_filterer_state.dart';
import '../reservation/reservation_view_model.dart';

class ProductsViewModel extends ChangeNotifier {

  Database db = Database();

  Future<List<int>> filterCorporationListForReservations() async {
    int filterDate = DateConversionUtils.getCurrentDateAsInt(ProductFiltererState.filter.date);
    var response = await db
        .getCollectionRef(DBConstants.corporationReservationsDb)
        .where('date', isEqualTo: filterDate)
        .where('isActive', isEqualTo: true)
        .get();

    List<int> corpModelListIDs = [];
    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      ReservationViewModel rvm = ReservationViewModel();
      List<CorporateSessionsModel> sessionList =
        await rvm.getSessionReservationForAllCorporatesExtraction(filterDate);

      for (int i = 0; i < list.length; i++) {
        Map item = list[i].data();
        ReservationModel model = ReservationModel.fromMap(item);

        List<CorporateSessionsModel> sessionCorporationList = [];
        for (int s = 0; s < sessionList.length; s++) {
          CorporateSessionsModel sessionModel = sessionList[s];
          if (sessionModel.corporationId == model.corporationId) {
            sessionCorporationList.add(sessionModel);
          }
        }

        bool hasFullReservation = true;
        for (int s = 0; s < sessionCorporationList.length; s++) {
          CorporateSessionsModel sessionModel = sessionCorporationList[s];
          if (!sessionModel.hasReservation) {
            hasFullReservation = false;
            break;
          }
        }

        if (hasFullReservation) {
          corpModelListIDs.add(model.corporationId);
        }
      }
    }

    return corpModelListIDs;
  }

  Future<List<CorporationModel>> getCorporationList() async {
    if (ProductFiltererState.filter.isSoftFilter) {
      return getSoftFilteredCorporationList();
    }

    Query list = db.getCollectionRef("Corporation");
    list = list.where('isActive', isEqualTo: true);
    if (int.parse(ProductFiltererState.filter.region) > 0) {
      list = list.where('region', isEqualTo: ProductFiltererState.filter.region);
    }
    if (ProductFiltererState.filter.maxPopulation.isNotEmpty) {
      list = list.where('maxPopulation', isGreaterThanOrEqualTo:
      int.parse(ProductFiltererState.filter.maxPopulation));
    }

    List<int> resList = [];
    if (ProductFiltererState.filter.isTimeFilterEnabled) {
      resList = await filterCorporationListForReservations();
    }

    var response = await list.get();
    List<CorporationModel> corpModelList = [];
    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      for (int i = 0; i < list.length; i++) {
        bool isEliminated = false;
        Map item = list[i].data();

        CorporationModel corporationModel = CorporationModel.fromMap(item);
        if (ProductFiltererState.filter.districtList != null) {
          List<DistrictModel> checkedDistrictList = ProductFiltererState.filter.districtList.where(
                  (item) => item.isChecked && !item.id.toString().endsWith("00")).toList();
          if (checkedDistrictList.length > 0) {
            isEliminated = true;
            for (int i = 0; i < checkedDistrictList.length; i++) {
              DistrictModel districtModel = checkedDistrictList[i];
              if (corporationModel.district == districtModel.id.toString()) {
                isEliminated = false;
                break;
              }
            }
          }
        }
        if (!isEliminated && ProductFiltererState.filter.sequenceOrderList != null) {
          List<SequenceOrderModel> checkedSequenceOrderList = ProductFiltererState.filter.sequenceOrderList.where(
                  (item) => item.isChecked && item.id > 0).toList();
          if (checkedSequenceOrderList.length > 0) {
            isEliminated = true;
            for (int i = 0; i < checkedSequenceOrderList.length; i++) {
              SequenceOrderModel sequenceOrderModel = checkedSequenceOrderList[i];
              if (corporationModel.invitationUniqueIdentifier.contains(sequenceOrderModel.id.toString())) {
                isEliminated = false;
                break;
              }
            }
          }
        }
        if (!isEliminated && ProductFiltererState.filter.invitationTypeList != null) {
          List<InvitationTypeModel> checkedInvitationTypeList = ProductFiltererState.filter.invitationTypeList.where(
                  (item) => item.isChecked && item.id > 0).toList();
          if (checkedInvitationTypeList.length > 0) {
            isEliminated = true;
            for (int i = 0; i < checkedInvitationTypeList.length; i++) {
              InvitationTypeModel invitationTypeModel = checkedInvitationTypeList[i];
              if (corporationModel.invitationUniqueIdentifier.contains(invitationTypeModel.id.toString())) {
                isEliminated = false;
                break;
              }
            }
          }
        }
        if (!isEliminated && ProductFiltererState.filter.organizationTypeList != null) {
          List<OrganizationTypeModel> checkedOrganizationTypeList = ProductFiltererState.filter.organizationTypeList.where(
                  (item) => item.isChecked && item.id > 0).toList();
          if (checkedOrganizationTypeList.length > 0) {
            isEliminated = true;
            for (int i = 0; i < checkedOrganizationTypeList.length; i++) {
              OrganizationTypeModel organizationTypeModel = checkedOrganizationTypeList[i];
              if (corporationModel.organizationUniqueIdentifier.contains(organizationTypeModel.id.toString())) {
                isEliminated = false;
                break;
              }
            }
          }
        }

        if (!isEliminated) {
          for (int j = 0; j < resList.length; j++) {
            if (corporationModel.corporationId == resList[j]) {
              isEliminated = true;
              break;
            }
          }
        }

        if (!isEliminated) {
          corpModelList.add(corporationModel);
        }
      }
    }

    corpModelList.sort((a, b) => b.point.compareTo(a.point));
    for(int i = 0; i < corpModelList.length; i++) {
      corpModelList[i].sortingIndex = i;
    }

    return corpModelList;
  }

  Future<List<CorporationModel>> getSoftFilteredCorporationList() async {
    Query list = db.getCollectionRef("Corporation");
    list = list.where('isActive', isEqualTo: true);
    if (int.parse(ProductFiltererState.filter.region) > 0) {
      list = list.where('region', isEqualTo: ProductFiltererState.filter.region);
    }

    var response = await list.get();
    List<CorporationModel> corpModelList = [];
    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      for (int i = 0; i < list.length; i++) {
        bool isEliminated = false;
        Map item = list[i].data();

        CorporationModel corporationModel = CorporationModel.fromMap(item);
        if (ProductFiltererState.filter.districtList != null) {
          List<DistrictModel> checkedDistrictList = ProductFiltererState.filter.districtList.where(
                  (item) => item.isChecked && !item.id.toString().endsWith("00")).toList();
          if (checkedDistrictList.length > 0) {
            isEliminated = true;
            for (int i = 0; i < checkedDistrictList.length; i++) {
              DistrictModel districtModel = checkedDistrictList[i];
              if (corporationModel.district == districtModel.id.toString()) {
                isEliminated = false;
                break;
              }
            }
          }
        }
        if (!isEliminated && ProductFiltererState.filter.organizationTypeList != null) {
          List<OrganizationTypeModel> checkedOrganizationTypeList = ProductFiltererState.filter.organizationTypeList.where(
                  (item) => item.isChecked && item.id > 0).toList();
          if (checkedOrganizationTypeList.length > 0) {
            isEliminated = true;
            for (int i = 0; i < checkedOrganizationTypeList.length; i++) {
              OrganizationTypeModel organizationTypeModel = checkedOrganizationTypeList[i];
              if (corporationModel.organizationUniqueIdentifier.contains(organizationTypeModel.id.toString())) {
                isEliminated = false;
                break;
              }
            }
          }
        }
        if (!isEliminated) {
          corpModelList.add(corporationModel);
        }
      }
    }

    corpModelList.sort((a, b) => b.point.compareTo(a.point));
    for(int i = 0; i < corpModelList.length; i++) {
      corpModelList[i].sortingIndex = i;
    }

    return corpModelList;
  }
}