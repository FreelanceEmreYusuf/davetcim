import 'package:flutter/cupertino.dart';

import '../../shared/services/database.dart';

class ProductsViewDetailModel extends ChangeNotifier {
  Database db = Database();

  Future<List<String>> getImagesList(int corporationId) async {
    var response = await db
        .getCollectionRef("Images")
        .where('corporationId', isEqualTo: corporationId)
        .get();

    List<String> imageList = [];
    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      for (int i = 0; i < list.length; i++) {
        Map item = list[i].data();
        imageList.add(item["imageUrl"]);
      }
    }

    return imageList;
  }

}