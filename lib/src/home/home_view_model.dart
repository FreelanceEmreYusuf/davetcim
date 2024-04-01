import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davetcim/shared/models/corporation_model.dart';
import 'package:davetcim/shared/services/database.dart';
import 'package:flutter/cupertino.dart';
import '../../shared/environments/db_constants.dart';
import '../../shared/models/corporation_event_log_model.dart';
import '../../shared/sessions/user_state.dart';
import '../../shared/utils/date_utils.dart';

class HomeViewModel extends ChangeNotifier {

  Database db = Database();

  String getUserName() {
    if (UserState.isPresent()) {
      return UserState.username;
    }
    return "";
  }

  Stream<List<CorporationModel>> getHomeCorporationList(List<int> corporationsOrderedId)  {
    if(corporationsOrderedId.isNotEmpty){
      Stream<List<DocumentSnapshot>> corporationDocList = db.getCollectionRef("Corporation")
       //   .where("id", whereIn: corporationsOrderedId)
          .where('isActive', isEqualTo: true)
          .snapshots()
          .map((event) {
        List<DocumentSnapshot> docs = event.docs;
        List<DocumentSnapshot> sortedDocs = [];
        for (int id in corporationsOrderedId) {
          DocumentSnapshot doc = docs.firstWhere(
                (element) => element['id'] == id,
            orElse: () => null,
          );

          if (doc != null) {
            sortedDocs.add(doc);
          }
        }

        return sortedDocs;
      });
      Stream<List<CorporationModel>> corporationList = corporationDocList
          .map((event) => event.map((e) => CorporationModel.fromMap(e.data())).toList());

      return corporationList;
    }

     return null;

    }


  Future<List<int>> getMountLogs(int maxCorp) async {
    var response = await db
        .getCollectionRef(DBConstants.corporationEventLogDb)
        .where(
        'date', isGreaterThanOrEqualTo: DateConversionUtils.getCurrentDateAsInt(
        DateTime(DateTime
            .now()
            .year, DateTime
            .now()
            .month - 1, DateTime
            .now()
            .day)))
        .get();

    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      List<CorporationEventLogModel> corporationEventLogModelList = [];
      List<Map<int,int>> corporations = [];
      Map<int,int> corporation = {};
      int totalPoint =0;
      for (int i = 0; i < list.length; i++) {
        corporationEventLogModelList.add(CorporationEventLogModel.fromMap(list[i].data()));
      }
      for(int j = 0; j<corporationEventLogModelList.length; j++){
        totalPoint = (corporationEventLogModelList[j].commentCount*3)+
            (corporationEventLogModelList[j].favoriteCount*3)+
            (corporationEventLogModelList[j].reservationCount*5)+
            (corporationEventLogModelList[j].visitCount*1);

        corporation= {
          corporationEventLogModelList[j].corporationId: totalPoint
        };
        corporations.add(corporation);
      }

        Map<int, int> distinctCorporations = {};

        for (var map in corporations) {
          map.forEach((key, value) {
            if (distinctCorporations.containsKey(key)) {
              distinctCorporations[key] += value;
            } else {
              distinctCorporations[key] = value;
            }
          });
        }
      var orderedCorporationIdList = distinctCorporations.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));
      if(orderedCorporationIdList.length <maxCorp){
        maxCorp = orderedCorporationIdList.length;
      }
      return orderedCorporationIdList.map((entry) => entry.key).toList().sublist(0,maxCorp);
    }
    return null;
  }

}

