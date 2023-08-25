import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davetcim/shared/models/comment_model.dart';
import 'package:davetcim/shared/models/image_model.dart';
import 'package:davetcim/src/comments/comments_view_model.dart';
import 'package:davetcim/util/comments.dart';
import 'package:flutter/cupertino.dart';
import '../../../shared/enums/reservation_status_enum.dart';
import '../../../shared/environments/db_constants.dart';
import '../../../shared/models/reservation_model.dart';
import '../../../shared/services/database.dart';
import '../../notifications/notifications_view_model.dart';

class ManageCorporationPhotosViewModel extends ChangeNotifier {
  Database db = Database();

  Future<List<ImageModel>> getCorporatePhotos(int corporateId) async {
    var response = await db
        .getCollectionRef(DBConstants.imagesDb)
        .where('corporationId', isEqualTo: corporateId)
        //.orderBy('id', descending: true)
        .get();

    List<ImageModel> imageList = [];
    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      for (int i = 0; i < list.length; i++) {
        Map item = list[i].data();
        imageList.add(ImageModel.fromMap(item));
      }
    }
    return imageList;
  }
/*
  Future<void> deleteService(CommentModel commentModel) async {
    CollectionReference servicesListRef =
    db.getCollectionRef(DBConstants.commentDb);
    var response = await servicesListRef
        .where('corporationId', isEqualTo: commentModel.corporationId)
        .where('id', isEqualTo: commentModel.id).get();
    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      Map item = list[0].data();
      CommentModel commentModel = CommentModel.fromMap(item);
      db.deleteDocument(DBConstants.commentDb, commentModel.id.toString());
      if (commentModel.isApproved) {
        CommentsViewModel commentsViewModel = CommentsViewModel();
        commentsViewModel.deleteProductRating(commentModel.corporationId, commentModel.star);
      }
    }
  }

  Future<void> updateComment(CommentModel model) async {
    CommentModel commentModel = new CommentModel(
        id: model.id,
        corporationId: model.corporationId,
        comment: model.comment,
        customerId: model.customerId,
        date: model.date,
        isApproved: true,
        star: model.star,
        userName: model.userName
    );
    db.editCollectionRef(DBConstants.commentDb, commentModel.toMap());

    CommentsViewModel commentsViewModel = CommentsViewModel();
    commentsViewModel.approveProductRating(model.corporationId, model.star);
  }
*/
}