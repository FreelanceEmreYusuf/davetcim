import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davetcim/shared/models/corporation_model.dart';
import 'package:flutter/material.dart';

import '../../shared/enums/corporation_event_log_enum.dart';
import '../../shared/environments/const.dart';
import '../../shared/environments/db_constants.dart';
import '../../shared/helpers/corporate_helper.dart';
import '../../shared/models/user_fav_products.dart';
import '../../shared/services/database.dart';
import '../../shared/sessions/user_state.dart';
import '../../shared/utils/language.dart';
import '../../shared/utils/utils.dart';
import '../admin_corporate_panel/corporation_analysis/corporation_analysis_view_model.dart';

class FavProductsViewModel extends ChangeNotifier {
  Database db = Database();

  Future<List<int>> getFavProductsList() async {
    CollectionReference notRef =
    db.getCollectionRef(DBConstants.favProductsDb);
    var response = await notRef
        .where('customerId', isEqualTo: UserState.id)
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
        .where('id', whereIn: UserState.favoriteCorporationList)
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
    if (!UserState.isPresent() ) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(LanguageConstants
                .dialogGoToLoginForFavoriteProduct[LanguageConstants.languageFlag]), duration: Duration(seconds: 1),));
    } else {
      CollectionReference docsRef =
      db.getCollectionRef(DBConstants.favProductsDb);
      var response = await docsRef
          .where('corporationId', isEqualTo: corporationId)
          .where('customerId', isEqualTo: UserState.id)
          .get();
      var list = response.docs;

      if (list.length > 0) {
        await list[0].reference.delete();
        CorporateHelper corporateHelper = CorporateHelper();
        CorporationModel corporateModel = await corporateHelper.getCorporate(corporationId);
        corporateModel.point = corporateModel.point -
            Constants.favoriteAdditionPoint;
        db.editCollectionRef(DBConstants.corporationDb, corporateModel.toMap());
      } else {
        UserFavProductsModel favProductsModel = new UserFavProductsModel(
            id: new DateTime.now().millisecondsSinceEpoch,
            corporationId: corporationId,
            customerId: UserState.id,
            image: img,
            recordDate: Timestamp.now());

       db.editCollectionRef(DBConstants.favProductsDb, favProductsModel.toMap());

        CorporateHelper corporateHelper = CorporateHelper();
        CorporationModel corporateModel = await corporateHelper.getCorporate(corporationId);
        corporateModel.point = corporateModel.point +
            Constants.favoriteAdditionPoint;
        db.editCollectionRef(DBConstants.corporationDb, corporateModel.toMap());

       CorporationAnalysisViewModel corporationAnalysisViewModel = CorporationAnalysisViewModel();
       await corporationAnalysisViewModel.editDailyLog(corporationId, CorporationEventLogEnum.newFavorite.name, 0);
      }

      FavProductsViewModel favMdl = FavProductsViewModel();
      UserState.favoriteCorporationList = await favMdl.getFavProductsList();

      if (callerPage != null) {
        Utils.navigateToPage(context, callerPage);
      }
    }
  }
}