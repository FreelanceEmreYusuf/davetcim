import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davetcim/shared/models/corporation_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../shared/environments/db_constants.dart';
import '../../shared/models/user_fav_products.dart';
import '../../shared/services/database.dart';
import '../../shared/sessions/application_session.dart';
import '../../shared/utils/dialogs.dart';
import '../../shared/utils/language.dart';
import '../../shared/utils/utils.dart';

class FavProductsViewModel extends ChangeNotifier {
  Database db = Database();

  Future<List<int>> getFavProductsList() async {
    CollectionReference notRef =
    db.getCollectionRef(DBConstants.favProductsDb);
    var response = await notRef
        .where('customerId', isEqualTo: ApplicationSession.userSession.id)
        .get();

    List<int> favProductsList = [];
    var list = response.docs;
    for (int i = 0; i < list.length; i++) {
      Map item = list[i].data();
      favProductsList.add(int.parse(item["corporationId"].toString()));
    }

    return favProductsList;
  }

  Future<List<CorporationModel>> getFavProductDetailedList() async {
    CollectionReference notRef =
    db.getCollectionRef(DBConstants.corporationDb);
    var response = await notRef
        .where('id', whereIn: ApplicationSession.favoriteCorporationList)
        .get();

    List<CorporationModel> corpModelList = [];
    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      for (int i = 0; i < list.length; i++) {
        corpModelList.add(CorporationModel.fromMap(list[i].data()));
      }
    }

    return corpModelList;
  }

  Future<void> editFavoriteProductPage(int corporationId, String img, BuildContext context, Widget callerPage) async {

    if (ApplicationSession.userSession == null) {
      Dialogs.showAlertMessage(
          context,
          "",
          LanguageConstants
              .dialogGoToLoginForFavoriteProduct[
          LanguageConstants
              .languageFlag]);
    } else {
      CollectionReference docsRef =
      db.getCollectionRef(DBConstants.favProductsDb);
      var response = await docsRef
          .where('corporationId', isEqualTo: corporationId)
          .where('customerId', isEqualTo: ApplicationSession.userSession.id)
          .get();
      var list = response.docs;

      if (list.length > 0) {
        list[0].reference.delete();
      } else {
        UserFavProductsModel favProductsModel = new UserFavProductsModel(
            id: new DateTime.now().millisecondsSinceEpoch,
            corporationId: corporationId,
            customerId: ApplicationSession.userSession.id,
            image: img,
            recordDate: Timestamp.now());

       db.editCollectionRef(DBConstants.favProductsDb, favProductsModel.toMap());
      }

      FavProductsViewModel favMdl = FavProductsViewModel();
      ApplicationSession.favoriteCorporationList = await favMdl.getFavProductsList();

      if (callerPage != null) {
        Utils.navigateToPage(context, callerPage);
      }
    }
  }

}