import 'package:davetcim/shared/helpers/parameters_helper.dart';
import 'package:davetcim/shared/models/paramters_model.dart';
import 'package:davetcim/shared/services/database.dart';

import '../environments/db_constants.dart';
import '../models/corporation_model.dart';
import '../sessions/home_items_state.dart';

class CorporateHelper {

  Future<CorporationModel> getCorporate(int corporateId) async {
    Database db = Database();
    var response = await db
        .getCollectionRef(DBConstants.corporationDb)
        .where('id', isEqualTo: corporateId)
        .get();

    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      CorporationModel corporate = CorporationModel.fromMap(list[0].data());
      return corporate;
    }

    return null;
  }

  Future<List<CorporationModel>> getPopularCorporate() async {
    if (HomeItemsState.isPresentForCorporationList()) {
      return HomeItemsState.corporationList;
    }

    Database db = Database();
    ParametersHelper parametersHelper = ParametersHelper();
    ParametersModel parametersModel = await parametersHelper.getParametersData();
    List<CorporationModel> corpModelList =[];
    var response = await db
        .getCollectionRef(DBConstants.corporationDb)
        .where('isActive', isEqualTo: true)
        .orderBy('point', descending: true)
        .limit(parametersModel.homeItemSize)
        .get();

    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      for (int i = 0; i < list.length; i++) {
        corpModelList.add(CorporationModel.fromMap(list[i].data()));
      }

      HomeItemsState.corporationList = corpModelList;
      return corpModelList;
    }

    return null;
  }

  Future<List<CorporationModel>> getPopularFirst100Corporate() async {
    Database db = Database();
    ParametersHelper parametersHelper = ParametersHelper();
    ParametersModel parametersModel = await parametersHelper.getParametersData();
    List<CorporationModel> corpModelList =[];
    var response = await db
        .getCollectionRef(DBConstants.corporationDb)
        .where('isActive', isEqualTo: true)
        .orderBy('point', descending: true)
        .limit(100)
        .get();

    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      for (int i = 0; i < list.length; i++) {
        corpModelList.add(CorporationModel.fromMap(list[i].data()));
      }
      return corpModelList;
    }

    return null;
  }

  Future<List<CorporationModel>> getPopularFirst100CorporateWithCity(String region) async {

    Database db = Database();
    ParametersHelper parametersHelper = ParametersHelper();
    ParametersModel parametersModel = await parametersHelper.getParametersData();
    List<CorporationModel> corpModelList =[];
    var response = await db
        .getCollectionRef(DBConstants.corporationDb)
        .where('isActive', isEqualTo: true)
        .where('region', isEqualTo: region)
        .orderBy('point', descending: true)
        .limit(100)
        .get();

    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      for (int i = 0; i < list.length; i++) {
        corpModelList.add(CorporationModel.fromMap(list[i].data()));
      }
      return corpModelList;
    }

    return null;
  }

  Future<List<CorporationModel>> getPopularCorporateForSlider() async {
    if (HomeItemsState.isPresentForPopularCorporationList()) {
      return HomeItemsState.popularCorporationModelList;
    }

    Database db = Database();
    ParametersHelper parametersHelper = ParametersHelper();
    ParametersModel parametersModel = await parametersHelper.getParametersData();
    List<CorporationModel> corpModelList =[];
    var response = await db
        .getCollectionRef(DBConstants.corporationDb)
        .where('isActive', isEqualTo: true)
        .where('isPopularCorporation', isEqualTo: true)
        .orderBy('point', descending: true)
        .limit(parametersModel.homeSliderItemSize)
        .get();

    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      for (int i = 0; i < list.length; i++) {
        corpModelList.add(CorporationModel.fromMap(list[i].data()));
      }

      HomeItemsState.popularCorporationModelList = corpModelList;
      return corpModelList;
    }

    return null;
  }

  Future<List<CorporationModel>> getCorporateByCompany(int companyId) async {
    Database db = Database();
    List<CorporationModel> corporationList = [];
    var response = await db
        .getCollectionRef(DBConstants.corporationDb)
        .where('companyId', isEqualTo: companyId)
        .get();

    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      for (int i = 0; i < list.length; i++) {
        corporationList.add(CorporationModel.fromMap(list[i].data()));
      }
    }

    return corporationList;
  }

  Future<bool> isCorporationActive(int corporateId) async{
    CorporationModel corporationModel = await this.getCorporate(corporateId);
    if(corporationModel != null && corporationModel.isActive)
      return true;
    else
      return false;
  }

  Future<bool> isCorporationPopular(int corporateId) async{
    CorporationModel corporationModel = await this.getCorporate(corporateId);
    if(corporationModel != null && corporationModel.isPopularCorporation)
      return true;
    else
      return false;
  }

  Future<List<CorporationModel>> getActiveCorporates() async {
    Database db = Database();
    List<CorporationModel> corporationList =[];
    var response = await db
        .getCollectionRef(DBConstants.corporationDb)
        .where('isActive', isEqualTo: true)
        .get();

    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      for (int i = 0; i < list.length; i++) {
        corporationList.add(CorporationModel.fromMap(list[i].data()));
      }
      return corporationList;
    }

    return null;
  }
}


