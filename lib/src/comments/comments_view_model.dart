import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davetcim/shared/environments/db_constants.dart';
import 'package:davetcim/shared/helpers/corporate_helper.dart';
import 'package:davetcim/shared/services/database.dart';
import 'package:davetcim/shared/utils/dialogs.dart';
import 'package:davetcim/shared/utils/language.dart';
import 'package:davetcim/src/notifications/notifications_view_model.dart';
import 'package:flutter/material.dart';

import '../../shared/environments/const.dart';
import '../../shared/models/comment_model.dart';
import '../../shared/models/corporation_model.dart';
import '../../shared/sessions/user_state.dart';
import '../../shared/utils/utils.dart';
import '../../widgets/add_comments_widget.dart';
import '../../widgets/list_tile_comments.dart';
import '../products/product_detail_view.dart';

class CommentsViewModel extends ChangeNotifier {
  Database db = Database();

  Future<void> addUserComment(BuildContext context,
      int corporationId, int star, String comment) async {
    if (UserState != null) {
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
          .where('customerId', isEqualTo: UserState.id)
          .where('corporationId', isEqualTo: corporationId)
          .get();
      if (UserState.corporationId == corporationId) {
        Dialogs.showInfoModalContent(
            context,
            "Uyarı",
            "Firmanıza ait salon için yorum yapamazsınız.", null);
        return;
      }
      if (response.docs != null && response.docs.length > 0) {
        Dialogs.showInfoModalContent(
            context,
            LanguageConstants
                .dialogUnSuccessHeader[LanguageConstants.languageFlag],
            LanguageConstants
                .processDeletePreviousMessage[LanguageConstants.languageFlag], null);
      } else {
        editUserComment(context, corporationId, star, comment);
      }
    } else {
      Dialogs.showInfoModalContent(
          context,
          LanguageConstants
              .dialogUnSuccessHeader[LanguageConstants.languageFlag],
          LanguageConstants
              .dialogEmptyCommentMessage[LanguageConstants.languageFlag], null);
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
        customerId: UserState.id,
        star: star,
        isApproved: false,
        date: Timestamp.now(),
        comment: comment,
        userName: UserState.username,
       );

    db.editCollectionRef(DBConstants.productCommentsDb, commentModel.toMap());

    NotificationsViewModel notificationViewModel = NotificationsViewModel();
    notificationViewModel.sendNotificationsToAdminCompanyUsers(context, corporationId, commentId, 0, comment);

    Dialogs.showInfoModalContent(
        context,
        LanguageConstants.dialogSuccessHeader[LanguageConstants.languageFlag],
        LanguageConstants
            .dialogCommentSuccessMessage[LanguageConstants.languageFlag], null);
  }

  Future<List<Widget>> getCorporationComments(int corporationId) async {
    List<Widget> commentList = [];
    CollectionReference docsRef =
      db.getCollectionRef(DBConstants.productCommentsDb);
    var response = await docsRef
        .where('corporationId', isEqualTo: corporationId)
        .where('isApproved', isEqualTo: true)
        .orderBy('date', descending: true)
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
      //DateTime date = _date.toDate().add(new Duration(hours: 3));
      DateTime date = _date.toDate();
      String userName = item['userName'];
      commentList
          .add(ListTileComments(item['comment'], date, userName, item["star"], item["corporationId"] ));
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
        .where('customerId', isEqualTo: UserState.id)
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
      CorporationModel corporationModel = CorporationModel.fromMap(item);
      double averageRating = corporationModel.averageRating;
      int ratingCount = corporationModel.ratingCount;

      if (oldRating != -1) {
        double totalRating = averageRating * ratingCount;
        ratingCount -= 1;
        totalRating -= oldRating;
        if (ratingCount > 0) {
          averageRating = totalRating / ratingCount;
        } else {
          averageRating = 0.0;
        }

        corporationModel.ratingCount = ratingCount;
        corporationModel.averageRating = averageRating;

        if (oldRating == 3)
          corporationModel.point = corporationModel.point - Constants.threeStarAdditionPoint;
        if (oldRating == 4)
          corporationModel.point = corporationModel.point - Constants.fourStarAdditionPoint;
        if (oldRating == 5)
          corporationModel.point = corporationModel.point - Constants.fiveStarAdditionPoint;

        db.editCollectionRef(DBConstants.corporationDb, corporationModel.toMap());
        Utils.navigateToPage(context, ProductDetails(corporationModel: corporationModel));
      }
    }
  }

  Future<void> approveProductRating(int corporationId, int newRating) async {
    CorporateHelper corporateHelper = CorporateHelper();
    CorporationModel corporationModel = await corporateHelper.getCorporate(corporationId);
    double averageRating = corporationModel.averageRating;
    int ratingCount = corporationModel.ratingCount;

    double totalRating = (averageRating * ratingCount) + newRating;
    ratingCount += 1;
    averageRating = totalRating / ratingCount;

    corporationModel.ratingCount = ratingCount;
    corporationModel.averageRating = averageRating;

    if (newRating == 3)
      corporationModel.point = corporationModel.point + Constants.threeStarAdditionPoint;
    if (newRating == 4)
      corporationModel.point = corporationModel.point + Constants.fourStarAdditionPoint;
    if (newRating == 5)
      corporationModel.point = corporationModel.point + Constants.fiveStarAdditionPoint;

    db.editCollectionRef(DBConstants.corporationDb, corporationModel.toMap());
  }

  Future<void> deleteProductRating(int corporationId, int deletedRating) async {
    CorporateHelper corporateHelper = CorporateHelper();
    CorporationModel corporationModel = await corporateHelper.getCorporate(corporationId);
    double averageRating = corporationModel.averageRating;
    int ratingCount = corporationModel.ratingCount;

    double totalRating = (averageRating * ratingCount) - deletedRating;
    ratingCount -= 1;
    if (ratingCount <= 0) {
      averageRating = 0.0;
    } else {
      averageRating = totalRating / ratingCount;
    }

    corporationModel.ratingCount = ratingCount;
    corporationModel.averageRating = averageRating;

    if (deletedRating == 3)
      corporationModel.point = corporationModel.point - Constants.threeStarAdditionPoint;
    if (deletedRating == 4)
      corporationModel.point = corporationModel.point - Constants.fourStarAdditionPoint;
    if (deletedRating == 5)
      corporationModel.point = corporationModel.point - Constants.fiveStarAdditionPoint;

    db.editCollectionRef(DBConstants.corporationDb, corporationModel.toMap());
  }

  Future<int> getOldRating(int corporationId) async {
    CollectionReference docsRef =
      db.getCollectionRef(DBConstants.productCommentsDb);

    var response = await docsRef
        .where('corporationId', isEqualTo: corporationId)
        .where('customerId', isEqualTo: UserState.id)
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
