import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davetcim/shared/dto/product_filterer.dart';
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

  Future<List<DistrictModel>> fillDistrictlist(int regionCode) async {
    CollectionReference docsRef = db.getCollectionRef(DBConstants.districtDb);
    var response = await docsRef.where('regionId', isEqualTo: regionCode).get();

    var list = response.docs;
    List<DistrictModel> districtList = [];
    list.forEach((district) {
      Map item = district.data();
      districtList.add(DistrictModel.fromMap(item));
    });

    return districtList;
  }

  void goToFilterPage(BuildContext context, String region, String district, int invitationId,
      int organizationId, int sequenceOrderId) {
    ProductFilterer filter = ProductFilterer(
      region,
      district,
      invitationId,
      organizationId,
      sequenceOrderId,
    );

    Utils.navigateToPage(context, ProductsScreen(filter));
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
/*
  @override
  void initState() {
    fillCorporationCardModel();
  }

  void fillCorporationCardModel() async {
    SearchViewModel rm = SearchViewModel();
    corpCardMdl = await rm.getCorporationCard(1);
    setState(() {
      corpCardMdl = corpCardMdl;
    });
  }*/

}
