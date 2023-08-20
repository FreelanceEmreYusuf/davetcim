import 'package:davetcim/shared/helpers/corporate_helper.dart';
import 'package:davetcim/shared/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../shared/dto/corporation_organizations_response_dto.dart';
import '../../../shared/dto/organization_type_response_dto.dart';
import '../../../shared/models/corporation_model.dart';
import '../../corporation_register/common_informations_p2/common_informations_p2_view_model.dart';
import '../../corporation_register/common_informations_p3/common_informations_p3_view_model.dart';
import '../../corporation_register/common_informations_p4/common_informations_p4_view_model.dart';

class CorporationCommonPropertiesEditViewModel extends ChangeNotifier {
  Database db = Database();

  Future<CorporationOrganizationsResponseDto> getCorporationOrganizationTypes(int corporateId) async {
    CorporateHelper corporateHelper = CorporateHelper();
    CorporationModel corporateModel = await corporateHelper.getCorporate(corporateId);
    List<String> organizationTypeList = corporateModel.organizationUniqueIdentifier;
    List<String> invitationTypeList = corporateModel.invitationUniqueIdentifier;
    List<String> sequenceorderList = corporateModel.sequenceOrderUniqueIdentifier;

    //organization type
    CommonInformationsP2ViewModel commonInformationsP2ViewModel = CommonInformationsP2ViewModel();
    OrganizationTypesResponseDto organizationTypes = await commonInformationsP2ViewModel.getOrganizationTypes();
    Map<String, bool> resultMap = organizationTypes.organizationTypeCheckedMap;
    Map<String, int> resultIdMap = organizationTypes.organizationTypeNameIdMap;
    for (int i = 0; i < organizationTypeList.length; i++) {
      resultIdMap.forEach((name, id) =>  {
        if (id == int.parse(organizationTypeList[i])) {
          resultMap.updateAll((key, value){
            if(key == name){
              return true;
            } else {
              return value;
            }
          })
        }
      });
    }

    //invitation type
    CommonInformationsP3ViewModel commonInformationsP3ViewModel = CommonInformationsP3ViewModel();
    OrganizationTypesResponseDto invitationTypes = await commonInformationsP3ViewModel.getInvitationTypes();
    resultMap = invitationTypes.organizationTypeCheckedMap;
    resultIdMap = invitationTypes.organizationTypeNameIdMap;
    for (int i = 0; i < invitationTypeList.length; i++) {
      resultIdMap.forEach((name, id) =>  {
        if (id == int.parse(invitationTypeList[i])) {
          resultMap.updateAll((key, value){
            if(key == name){
              return true;
            } else {
              return value;
            }
          })
        }
      });
    }

    //sequence order
    CommonInformationsP4ViewModel commonInformationsP4ViewModel = CommonInformationsP4ViewModel();
    OrganizationTypesResponseDto sequenceOrderTypes = await commonInformationsP4ViewModel.getSequenceOrderTypes();;
    resultMap = sequenceOrderTypes.organizationTypeCheckedMap;
    resultIdMap = sequenceOrderTypes.organizationTypeNameIdMap;
    for (int i = 0; i < sequenceorderList.length; i++) {
      resultIdMap.forEach((name, id) =>  {
        if (id == int.parse(sequenceorderList[i])) {
          resultMap.updateAll((key, value){
            if(key == name){
              return true;
            } else {
              return value;
            }
          })
        }
      });
    }

    return CorporationOrganizationsResponseDto(organizationTypes, sequenceOrderTypes, invitationTypes);
  }


  Future<void> setCorporationOrganizationTypes(int corporateId, organizationUniqueIdentifier,
      invitationUniqueIdentifier, sequenceOrderIdentifier) async {

    CorporateHelper corporateHelper = CorporateHelper();
    CorporationModel corporateModel = await corporateHelper.getCorporate(corporateId);
    Map<String, dynamic> corporationMap = corporateModel.toMap();
    corporationMap['organizationUniqueIdentifier'] = organizationUniqueIdentifier;
    corporationMap['invitationUniqueIdentifier'] = invitationUniqueIdentifier;
    corporationMap['sequenceOrderUniqueIdentifier'] = sequenceOrderIdentifier;
    db.editCollectionRef("Corporation", corporationMap);
  }




}
