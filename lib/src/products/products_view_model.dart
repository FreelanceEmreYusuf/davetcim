import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davetcim/shared/dto/product_filterer.dart';
import 'package:davetcim/shared/models/corporation_model.dart';
import 'package:davetcim/shared/services/database.dart';
import 'package:flutter/cupertino.dart';

class ProductsViewModel extends ChangeNotifier {

  Database db = Database();

  Stream<List<CorporationModel>> getCorporationList(ProductFilterer filter)  {
    Query list  = db.getCollectionRef("Corporation");
    if (int.parse(filter.region) > 0) {
      list = list.where('region', isEqualTo: filter.region);
    }
    if (!filter.district.contains('00')) {
      list = list.where('district', isEqualTo: filter.district);
    }
    if (filter.invitationUniqueIdentifier != "0") {
      list = list.where('invitationUniqueIdentifier',  arrayContains: filter.invitationUniqueIdentifier);
    }
    if (filter.sequenceOrderUniqueIdentifier != "0") {
      list = list.where('sequenceOrderUniqueIdentifier', arrayContains: filter.sequenceOrderUniqueIdentifier);
    }
    if (filter.organizationUniqueIdentifier != "0") {
      list = list.where('organizationUniqueIdentifier', arrayContains: filter.organizationUniqueIdentifier);
    }

    Stream<List<DocumentSnapshot>> corporationDocList =
      list.snapshots().map((event) => event.docs);

    Stream<List<CorporationModel>> corporationList = corporationDocList
        .map((event) => event.map((e) => CorporationModel.fromMap(e.data())).toList());

    return corporationList;

  }
}