import 'package:davetcim/shared/helpers/corporate_helper.dart';
import 'package:davetcim/shared/helpers/reservation_helper.dart';
import 'package:davetcim/shared/models/notification_model.dart';
import 'package:davetcim/shared/models/reservation_model.dart';
import 'package:flutter/cupertino.dart';

import '../../src/admin_corporate_panel/manage_comments/manage_comment_corporate_detail_view.dart';
import '../../src/admin_corporate_panel/reservation/reservation_corporate_detail_view.dart';
import '../../src/products/product_detail_view.dart';
import '../../src/user_reservations/user_reservation_detail_view.dart';
import '../models/comment_model.dart';
import '../models/corporation_model.dart';
import '../utils/utils.dart';
import 'comment_helper.dart';

class NotificationHelper {

  Future<void> landToNotificationPage(BuildContext context, NotificationModel notificationModel) async {
    if (notificationModel.reservationId > 0) {
      ReservationHelper reservationHelper = ReservationHelper();
      ReservationModel reservationModel = await
      reservationHelper.getReservation(notificationModel.reservationId);
      if (notificationModel.isForAdmin) {
        Utils.navigateToPage(context, ReservationCorporateDetailScreen(reservationModel : reservationModel, isFromNotification: true));
      } else {
        Utils.navigateToPage(context, UserResevationDetailScreen(reservationModel : reservationModel, isFromNotification: true));
      }

    }
    else{
      CommentHelper commentHelper = CommentHelper();
      CommentModel commentModel = await commentHelper.getComment(notificationModel.commentId);
      if (notificationModel.isForAdmin) {
        Utils.navigateToPage(context, ManageCommentCorporateDetailScreen(commentModel: commentModel, isFromNotification: true));
      } else {
        CorporateHelper corporateHelper = CorporateHelper();
        CorporationModel corporationModel = await corporateHelper.getCorporate(notificationModel.corporationId);
        Utils.navigateToPage(context, ProductDetails(corporationModel: corporationModel) );

      }

    }
  }


}

