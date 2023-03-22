import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davetcim/shared/environments/const.dart';
import 'package:davetcim/shared/models/comment_model.dart';
import 'package:davetcim/shared/models/reservation_model.dart';
import 'package:davetcim/shared/services/database.dart';
import 'package:davetcim/shared/utils/language.dart';

import '../environments/db_constants.dart';
import '../models/corporation_model.dart';
import '../models/customer_model.dart';

class CommentHelper {

  Future<CommentModel> getComment(int commentId) async {
    Database db = Database();
    var response = await db
        .getCollectionRef(DBConstants.commentDb)
        .where('id', isEqualTo: commentId)
        .get();

    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      CommentModel commentModel = CommentModel.fromMap(list[0].data());
      return commentModel;
    }

    return null;
  }

}