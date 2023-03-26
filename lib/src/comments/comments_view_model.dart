import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davetcim/shared/environments/db_constants.dart';
import 'package:davetcim/shared/services/database.dart';
import 'package:davetcim/shared/sessions/application_session.dart';
import 'package:davetcim/shared/utils/dialogs.dart';
import 'package:davetcim/shared/utils/language.dart';
import 'package:davetcim/src/notifications/notifications_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../shared/models/comment_model.dart';
import '../../shared/models/corporation_model.dart';
import '../../shared/utils/utils.dart';
import '../../widgets/add_comments_widget.dart';
import '../../widgets/comments_with_editing.dart';
import '../../widgets/list_tile_comments.dart';
import '../products/product_detail_view.dart';

class CommentsViewModel extends ChangeNotifier {
  Database db = Database();

  Future<void> addUserComment(BuildContext context,
      int corporationId, int star, String comment) async {
    if (ApplicationSession.userSession != null) {
      await controlAndAddComments(
          context,
          corporationId,
          star,
          comment);
    } else {
      await Dialogs.showLoginDialogMessage(context,
          AddCommentsWidget(corporationId));
    }
  }

  Future<void> controlAndAddComments(BuildContext context,
      int corporationId, int star, String comment) async {
    if (comment.length > 0) {
      CollectionReference docsRef =
        db.getCollectionRef(DBConstants.productCommentsDb);
      var response = await docsRef
          .where('userId', isEqualTo: ApplicationSession.userSession.id)
          .where('corporationId', isEqualTo: corporationId)
          .get();
      if (response.docs != null && response.docs.length > 0) {
        Dialogs.showAlertMessage(
            context,
            LanguageConstants
                .dialogUnSuccessHeader[LanguageConstants.languageFlag],
            LanguageConstants
                .processDeletePreviousMessage[LanguageConstants.languageFlag]);
      } else {
        editUserComment(context, corporationId, star, comment);
      }
    } else {
      Dialogs.showAlertMessage(
          context,
          LanguageConstants
              .dialogUnSuccessHeader[LanguageConstants.languageFlag],
          LanguageConstants
              .dialogEmptyCommentMessage[LanguageConstants.languageFlag]);
    }
  }

  Future<void> editUserComment(
      BuildContext context,
      int corporationId,
      int star,
      String comment,
      ) async {
    int commentId = new DateTime.now().millisecondsSinceEpoch;
    CommentModel commentModel = new CommentModel(
        id: commentId,
        corporationId: corporationId,
        customerId: ApplicationSession.userSession.id,
        star: star,
        isApproved: false,
        date: Timestamp.now(),
        comment: comment,
        userName: ApplicationSession.userSession.username,
       );

    db.editCollectionRef("Comments", commentModel.toMap());

    NotificationsViewModel notificationViewModel = NotificationsViewModel();
    notificationViewModel.sendNotificationsToAdminCompanyUsers(context, corporationId, commentId, 0, comment);

    Dialogs.showAlertMessage(
        context,
        LanguageConstants.dialogSuccessHeader[LanguageConstants.languageFlag],
        LanguageConstants
            .dialogCommentSuccessMessage[LanguageConstants.languageFlag]);
  }

  Future<List<Widget>> getCorporationComments(int corporationId) async {
    List<Widget> commentList = [];
    CollectionReference docsRef =
      db.getCollectionRef(DBConstants.productCommentsDb);
    var response = await docsRef
        .where('corporationId', isEqualTo: corporationId)
        .where('isApproved', isEqualTo: true)
        .get();

    var list = response.docs;

    commentList.add(AddCommentsWidget(corporationId));
    commentList.add(SizedBox(height: 25));
    commentList.add(Divider(
      thickness: 3,
    ));

    for (int i = 0; i < list.length; i++) {
      Map item = list[i].data();
      Timestamp _date = item['date'];
      DateTime date = _date.toDate().add(new Duration(hours: 3));
      String userName = item['userName'];
      commentList
          .add(ListTileComments(item['comment'], date, userName, item["star"]));
      commentList.add(Divider(
        thickness: 1,
      ));
    }

    return commentList;
  }

  Future<void> deleteUserComment(BuildContext context,
      int corporationId, int oldRating) async {
    CollectionReference docsRef =
      db.getCollectionRef(DBConstants.productCommentsDb);
    var response = await docsRef
        .where('customerId', isEqualTo: ApplicationSession.userSession.id)
        .where('corporationId', isEqualTo: corporationId)
        .get();

    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      Map item = list[0].data();
      list[0].reference.delete();
      if (item['isApproved']) {
        editProductRating(context, corporationId, oldRating);
      }
    }
  }

  Future<void> editProductRating(BuildContext context,
      int corporationId, int oldRating) async {
    CollectionReference docsRef = db.getCollectionRef(DBConstants.corporationDb);
    var response = await docsRef.where('id', isEqualTo: corporationId).get();

    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      Map item = list[0].data();
      double averageRating = double.parse(item["averageRating"].toString());
      int ratingCount = item["ratingCount"];

      if (oldRating != -1) {
        double totalRating = averageRating * ratingCount;
        ratingCount -= 1;
        totalRating -= oldRating;
        if (ratingCount > 0) {
          averageRating = totalRating / ratingCount;
        } else {
          averageRating = 0.0;
        }

        CorporationModel corporationModel = CorporationModel.fromMap(item);
        Map<String, dynamic> corporationMap = corporationModel.toMap();
        corporationMap['ratingCount'] = ratingCount;
        corporationMap['averageRating'] = averageRating;
        db.editCollectionRef(DBConstants.corporationDb, corporationMap);

        Utils.navigateToPage(context, ProductDetails(corporationId: corporationId,
            description: corporationModel.description,img: corporationModel.imageUrl,
          isFav: false, name: corporationModel.corporationName, raters: corporationModel.ratingCount,
          rating: corporationModel.averageRating
        ));
      }
    }
  }

  Future<void> approveProductRating(int corporationId, int newRating) async {
    CollectionReference docsRef = db.getCollectionRef(DBConstants.corporationDb);
    var response = await docsRef.where('id', isEqualTo: corporationId).get();

    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      Map item = list[0].data();
      double averageRating = double.parse(item["averageRating"].toString());
      int ratingCount = item["ratingCount"];

      double totalRating = (averageRating * ratingCount) + newRating;
      ratingCount += 1;
      averageRating = totalRating / ratingCount;

      CorporationModel corporationModel = CorporationModel.fromMap(item);
      Map<String, dynamic> corporationMap = corporationModel.toMap();
      corporationMap['ratingCount'] = ratingCount;
      corporationMap['averageRating'] = averageRating;
      db.editCollectionRef(DBConstants.corporationDb, corporationMap);
    }
  }

  Future<void> deleteProductRating(int corporationId, int deletedRating) async {
    CollectionReference docsRef = db.getCollectionRef(DBConstants.corporationDb);
    var response = await docsRef.where('id', isEqualTo: corporationId).get();

    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      Map item = list[0].data();
      double averageRating = double.parse(item["averageRating"].toString());
      int ratingCount = item["ratingCount"];

      double totalRating = (averageRating * ratingCount) - deletedRating;
      ratingCount -= 1;
      if (ratingCount <= 0) {
        averageRating = 0.0;
      } else {
        averageRating = totalRating / ratingCount;
      }

      CorporationModel corporationModel = CorporationModel.fromMap(item);
      Map<String, dynamic> corporationMap = corporationModel.toMap();
      corporationMap['ratingCount'] = ratingCount;
      corporationMap['averageRating'] = averageRating;
      db.editCollectionRef(DBConstants.corporationDb, corporationMap);
    }
  }

  Future<int> getOldRating(int corporationId) async {
    CollectionReference docsRef =
      db.getCollectionRef(DBConstants.productCommentsDb);

    var response = await docsRef
        .where('corporationId', isEqualTo: corporationId)
        .where('customerId', isEqualTo: ApplicationSession.userSession.id)
        .where('isApproved', isEqualTo: true)
        .get();

    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      Map item = list[0].data();
      return int.parse(item["star"].toString());
    }

    return -1;
  }


}
