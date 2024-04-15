import 'dart:convert';

import 'package:davetcim/shared/helpers/corporate_helper.dart';
import 'package:davetcim/shared/models/corporation_model.dart';
import 'package:davetcim/widgets/pagination/pageStatus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CorporationRepository {
  List<CorporationModel> corporates = [];
  int perPage = 10;
  int pageKey = 1;
  ValueNotifier<PageStatus> pageStatus = ValueNotifier<PageStatus>(
    PageStatus.idle,
  );

  Future getInitialUsers() async {
    pageStatus.value = PageStatus.firstPageLoading;

    try {
      await fetchUsers(1);
      if (corporates.isEmpty) {
        pageStatus.value = PageStatus.firstPageNoItemsFound;
      } else {
        pageStatus.value = PageStatus.firstPageLoaded;
      }
    } catch (e) {
      pageStatus.value = PageStatus.firstPageError;
    }
  }

  Future loadMoreUsers() async {
    pageStatus.value = PageStatus.newPageLoading;
    pageKey++;

    try {
      int currentUsersCount = corporates.length;
      await fetchUsers(pageKey);

      if (currentUsersCount == corporates.length) {
        pageStatus.value = PageStatus.newPageNoItemsFound;
      } else {
        pageStatus.value = PageStatus.newPageLoaded;
      }
    } catch (e) {
      pageStatus.value = PageStatus.newPageError;
    }
  }

  Future<void> fetchUsers(int pageKey) async {

    if(corporates.length == 0){
      CorporateHelper corporateModel = new CorporateHelper();
      List<CorporationModel>  activeCorporationList = await corporateModel.getActiveCorporates();
      corporates.addAll(activeCorporationList);
    }
    else if(corporates.length < 15 && corporates.length>0){
      CorporateHelper corporateModel = new CorporateHelper();
      CorporationModel  activeCorporationList = await corporateModel.getCorporate(1694334311791);
      corporates.add(activeCorporationList);
    }
    else{
      corporates = corporates;
    }

    //TODO : 20 şerli gruplar halinde puan sıralı salonlar çekilecek ve corporates üzerine eklenecek
    /*String apiUrl = "https://randomuser.me/api/?results=$perPage&page=$pageKey";
    final response = await http.get(Uri.parse(apiUrl));

    try {
      for (var map in jsonDecode(response.body)["results"]) {
        corporates.add(CorporationModel.fromMap(map));
      }
    } catch (e) {
      throw Exception(e);
    }*/
  }
}