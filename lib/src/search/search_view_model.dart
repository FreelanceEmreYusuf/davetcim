import 'package:davetcim/shared/environments/db_constants.dart';
import 'package:davetcim/shared/helpers/region_district_helper.dart';
import 'package:davetcim/shared/models/corporation_card_model.dart';
import 'package:davetcim/shared/models/corporation_model.dart';
import 'package:davetcim/shared/models/district_model.dart';
import 'package:davetcim/shared/models/invitation_type_model.dart';
import 'package:davetcim/shared/models/organization_type_model.dart';
import 'package:davetcim/shared/models/region_model.dart';
import 'package:davetcim/shared/models/sequence_order_model.dart';
import 'package:davetcim/shared/services/database.dart';
import 'package:davetcim/shared/utils/utils.dart';
import 'package:davetcim/src/products/products_view.dart';
import 'package:flutter/cupertino.dart';

import '../../shared/sessions/organization_items_state.dart';
import '../../shared/sessions/organization_type_state.dart';
import '../../shared/sessions/product_filterer_state.dart';

List<RegionModel> regionList =
    OrganizationItemsState.regionModelList;
List<SequenceOrderModel> sequenceOrderList =
    OrganizationItemsState.sequenceOrderList;
List<InvitationTypeModel> invitationList =
    OrganizationItemsState.invitationTypeList;
List<DistrictModel> districtList = [
  DistrictModel(
      id: 0, name: 'Tümü', regionId: 0, filteringStatus: 0, sortingIndex: 1)
];

class SearchViewModel extends ChangeNotifier {
  Database db = Database();

  Future<List<DistrictModel>> fillDistrictlist(int regionCode) async {
    RegionDistrictHelper regionDistrictHelper = RegionDistrictHelper();
    return await regionDistrictHelper.fillDistrictList(regionCode);
  }

  void goToFilterPage(BuildContext context, String region,
      List<DistrictModel> districtList,
      List<InvitationTypeModel> invitationTypeList,
      List<OrganizationTypeModel> organizationTypeList,
      List<SequenceOrderModel> sequenceOrderList,
      String maxPopulation,
      bool isTimeFilterEnabled,
      DateTime date,
      DateTime startHour,
      DateTime endHour) {
    ProductFiltererState.setFilter(
      region,
      districtList,
      invitationTypeList,
      organizationTypeList,
      sequenceOrderList,
      maxPopulation,
      isTimeFilterEnabled,
      date,
      startHour,
      endHour
    );

    Utils.navigateToPage(context, ProductsScreen(null));
  }

  void goToFilterPageFromSoftFilter(BuildContext context, String region,
      List<DistrictModel> districtList,
      List<OrganizationTypeModel> organizationTypeList
     ) {

    ProductFiltererState.setSoftFilter(
      region, districtList, organizationTypeList
    );

    Utils.navigateToPage(context, ProductsScreen(null));
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
