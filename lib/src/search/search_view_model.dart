import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davetcim/shared/dto/product_filterer_dto.dart';
import 'package:davetcim/shared/environments/db_constants.dart';
import 'package:davetcim/shared/models/corporation_card_model.dart';
import 'package:davetcim/shared/models/corporation_model.dart';
import 'package:davetcim/shared/models/district_model.dart';
import 'package:davetcim/shared/models/invitation_type_model.dart';
import 'package:davetcim/shared/models/organization_type_model.dart';
import 'package:davetcim/shared/models/region_model.dart';
import 'package:davetcim/shared/models/sequence_order_model.dart';
import 'package:davetcim/shared/services/database.dart';
import 'package:davetcim/shared/sessions/application_session.dart';
import 'package:davetcim/shared/utils/utils.dart';
import 'package:davetcim/src/products/products_view.dart';
import 'package:flutter/cupertino.dart';

List<RegionModel> regionList =
    ApplicationSession.filterScreenSession.regionModelList;
List<OrganizationTypeModel> organizationTypeList =
    ApplicationSession.filterScreenSession.organizationTypeList;
List<SequenceOrderModel> sequenceOrderList =
    ApplicationSession.filterScreenSession.sequenceOrderList;
List<InvitationTypeModel> invitationList =
    ApplicationSession.filterScreenSession.invitationTypeList;
List<DistrictModel> districtList = [
  DistrictModel(
      id: 0, name: 'Tümü', regionId: 0, filteringStatus: 0, sortingIndex: 1)
];

class SearchViewModel extends ChangeNotifier {
  Database db = Database();

  List<DistrictModel> fillDistrictlist(int regionCode)  {
    List<DistrictModel> districtList = ApplicationSession.getDistrictList(regionCode);
    return districtList;
  }

  void goToFilterPage(BuildContext context, String region, String district,
      String invitationUniqueIdentifier,
      String organizationUniqueIdentifier,
      String sequenceOrderUniqueIdentifier,
      String maxPopulation,
      bool isTimeFilterEnabled,
      DateTime date,
      DateTime startHour,
      DateTime endHour) {
    ProductFiltererDto filter = ProductFiltererDto(
      region,
      district,
      invitationUniqueIdentifier,
      organizationUniqueIdentifier,
      sequenceOrderUniqueIdentifier,
      maxPopulation,
      isTimeFilterEnabled,
      date,
      startHour,
      endHour,
    );

    Utils.navigateToPage(context, ProductsScreen(filter, null));
  }




  Future<CorporationCardModel> getCorporationCard(int corporationId) async {
    CorporationModel mdl = await getCorporationModel(1);
    String imageURL = await  getImageURL(mdl.corporationId);
    return CorporationCardModel(corporationName: mdl.corporationName, image: imageURL);
  }

  Future<CorporationModel> getCorporationModel(int corporationId) async {
    var response = await db
        .getCollectionRef(DBConstants.corporationDb)
        .where('id', isEqualTo: corporationId)
        .get();

    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;

      Map corpMap = list[0].data();
      return CorporationModel(corporationId: corpMap["id"], corporationName: corpMap["corporationName"] );
    }

    return null;
  }

  Future<String> getImageURL(int corporationId) async {
    var response = await db
        .getCollectionRef(DBConstants.imagesDb)
        .where('corporationId', isEqualTo: corporationId)
        .get();

    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;

      Map item = list[0].data();
      return item['imageUrl'];

    } else {
      return "";
    }
  }

}
