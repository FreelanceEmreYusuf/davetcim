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
    if (filter.invitationId > 0) {
      list = list.where('invitationId', isEqualTo: filter.invitationId);
    }
    if (filter.sequenceOrderId > 0) {
      list = list.where('sequenceOrderId', isEqualTo: filter.sequenceOrderId);
    }
    if (filter.organizationId > 0) {
      list = list.where('organizationId', isEqualTo: filter.organizationId);
    }

    Stream<List<DocumentSnapshot>> corporationDocList =
      list.snapshots().map((event) => event.docs);

    Stream<List<CorporationModel>> corporationList = corporationDocList
        .map((event) => event.map((e) => CorporationModel.fromMap(e.data())).toList());

    return corporationList;

  }
}