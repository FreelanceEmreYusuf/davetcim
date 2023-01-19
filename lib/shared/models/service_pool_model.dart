import 'dart:math';

import 'package:davetcim/shared/models/service_corporate_pool_model.dart';

class ServicePoolModel {
  final int id;
  final int parentId;
  String serviceName;
  final bool hasChild;
  final bool isActive;
  bool companyHasService;
  bool userBasketSelected;
  ServiceCorporatePoolModel corporateDetail;
  List<ServicePoolModel> childrenList;

  ServicePoolModel({
    this.id,
    this.parentId,
    this.serviceName,
    this.hasChild,
    this.isActive,
    this.companyHasService,
    this.userBasketSelected,
    this.corporateDetail,
    this.childrenList,
  });

  ///Object to map
  Map<String, dynamic> toMap() => {
    'id': id,
    'parentId': parentId,
    'serviceName': serviceName,
    'hasChild': hasChild,
    'isActive': isActive,
  };

  ///Map to object
  factory ServicePoolModel.fromMap(Map map) => ServicePoolModel(
    id: map['id'],
    parentId: map['parentId'],
    serviceName: map['serviceName'],
    hasChild: map['hasChild'],
    isActive: map['isActive'],
  );
}
