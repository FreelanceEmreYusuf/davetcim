import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davetcim/shared/sessions/application_session.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../../shared/environments/db_constants.dart';
import '../../../shared/models/service_corporate_pool_model.dart';
import '../../../shared/models/service_pool_model.dart';
import '../../../shared/services/database.dart';
import '../../admin_panel/service/service_view_model.dart';


class ServiceCorporatePoolViewModel extends ChangeNotifier {
  Database db = Database();

  Future<List<ServicePoolModel>> getServiceList() async {
    ServicePoolViewModel mdl = ServicePoolViewModel();
    List<ServicePoolModel> serviceList = await mdl.getServices();
    List<ServiceCorporatePoolModel> serviceCorporateList = await getCorporateServiceList();

    for(int j = 0; j < serviceList.length; j++) {
      serviceList[j].companyHasService = false;
    }
    for (int i = 0; i < serviceCorporateList.length; i++) {
      for(int j = 0; j < serviceList.length; j++) {
        if (serviceList[j].id == serviceCorporateList[i].serviceId)  {
          serviceList[j].companyHasService = true;
        }
      }
    }

    return serviceList;
  }

  Future<List<ServiceCorporatePoolModel>> getCorporateServiceList() async {
    CollectionReference servicesListRef =
    db.getCollectionRef(DBConstants.corporationServicesDb);
    var response = await servicesListRef
        .where('corporateId', isEqualTo: ApplicationSession.userSession.corporationId).get();

    List<ServiceCorporatePoolModel> servicesList = [];
    var list = response.docs;
    for (int i = 0; i < list.length; i++) {
      ServiceCorporatePoolModel servicesModel = ServiceCorporatePoolModel.fromMap(list[i].data());
      servicesList.add(servicesModel);
    }

    return servicesList;
  }

  Future<void> addNewService(ServicePoolModel servicePoolModel, int price, bool priceChangedForCount) async {
    bool hasPrice = price == 0 ? false: true;
    ServiceCorporatePoolModel servicePool = new ServiceCorporatePoolModel(
        id: new DateTime.now().millisecondsSinceEpoch,
        serviceId: servicePoolModel.id,
        corporateId: ApplicationSession.userSession.corporationId,
        price: price,
        priceChangedForCount: priceChangedForCount,
        hasPrice: hasPrice
    );
    db.editCollectionRef(DBConstants.corporationServicesDb, servicePool.toMap());
  }

  Future<void> deleteService(ServicePoolModel servicePoolModel) async {
    CollectionReference servicesListRef =
    db.getCollectionRef(DBConstants.corporationServicesDb);
    var response = await servicesListRef
        .where('corporateId', isEqualTo: ApplicationSession.userSession.corporationId)
        .where('serviceId', isEqualTo: servicePoolModel.id).get();
    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      Map item = list[0].data();
      db.deleteDocument(DBConstants.corporationServicesDb, item['id'].toString());
    }
  }

}