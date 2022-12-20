
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../../shared/environments/db_constants.dart';
import '../../../shared/models/service_pool_model.dart';
import '../../../shared/services/database.dart';


class ServicePoolViewModel extends ChangeNotifier {
  Database db = Database();

  Future<List<ServicePoolModel>> getServices() async {
    List<ServicePoolModel> treeList = await getServicesTreeList();
    List<ServicePoolModel> viewList = [];
    for (int i = 0; i < treeList.length; i++) {
      ServicePoolModel item = treeList[i];
      viewList.add(item);
      viewList = addChildrenToList(viewList, item, "-");

    }
    return viewList;
  }

  List<ServicePoolModel> addChildrenToList(List<ServicePoolModel> viewList, ServicePoolModel child,  String emptyLine) {
    if (child.hasChild) {
      emptyLine += "-";
      List<ServicePoolModel> childrenList = child.childrenList;
      for (int j = 0; j < childrenList.length; j++) {
        ServicePoolModel grandChild = childrenList[j];
        grandChild.serviceName = emptyLine + grandChild.serviceName;
        viewList.add(grandChild);
        if (grandChild.hasChild) {
          addChildrenToList(viewList, grandChild, emptyLine);
        }
      }
    }
    return viewList;
  }


  Future<List<ServicePoolModel>> getServicesTreeList() async {
    List<ServicePoolModel> allList = await getServicesList();
    List<ServicePoolModel> treeList = [];

    int initializedParentId = 0;
    for (int i = 0; i < allList.length; i++) {
      ServicePoolModel poolItem = allList[i];
      if (poolItem.parentId == initializedParentId) {
        poolItem.childrenList = getChildrenList(allList, poolItem.id);
        treeList.add(poolItem);
      }
    }

    return treeList;
  }

  List<ServicePoolModel> getChildrenList(List<ServicePoolModel> allList,
      int id) {
    List<ServicePoolModel> childrenList = [];
    for (int i = 0; i < allList.length; i++) {
      ServicePoolModel poolItem = allList[i];
      if (poolItem.parentId == id) {
        if (poolItem.hasChild) {
          poolItem.childrenList = getChildrenList(allList, poolItem.id);
        }
        childrenList.add(poolItem);
      }
    }
    return childrenList;
  }


  Future<List<ServicePoolModel>> getServicesList() async {
    CollectionReference servicesListRef =
    db.getCollectionRef(DBConstants.servicesDb);
    var response = await servicesListRef.get();

    List<ServicePoolModel> servicesList = [];
    var list = response.docs;
    for (int i = 0; i < list.length; i++) {
      ServicePoolModel servicesModel = ServicePoolModel.fromMap(list[i].data());
      servicesList.add(servicesModel);
    }

    return servicesList;
  }






}