import 'package:davetcim/shared/helpers/customer_helper.dart';
import 'package:davetcim/shared/models/invitation_type_model.dart';
import 'package:davetcim/shared/models/organization_type_model.dart';
import 'package:davetcim/shared/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../shared/dto/organization_type_response_dto.dart';
import '../../../shared/enums/customer_role_enum.dart';
import '../../../shared/environments/db_constants.dart';

class CommonInformationsP3ViewModel extends ChangeNotifier {
  Database db = Database();

  Future<OrganizationTypesResponseDto> getInvitationTypes() async {
    Map<String, bool> resultMap = new Map<String, bool>();
    Map<String, int> resultMap2 = new Map<String, int>();
    var response = await db
        .getCollectionRef(DBConstants.invitationTypeDb)
        .where('id', isGreaterThan: 0)
    // TODO
    //  .orderBy('sortingIndex', descending: false)
        .get();

    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      for (int i = 0; i < response.docs.length; i++) {
        InvitationTypeModel invitationTypeModel = InvitationTypeModel.fromMap(list[i].data());
        resultMap.addAll({invitationTypeModel.name: false});
        resultMap2.addAll({invitationTypeModel.name: invitationTypeModel.id});
      }

      OrganizationTypesResponseDto org = new OrganizationTypesResponseDto(resultMap, resultMap2);
      return org;
    }


  }

}