import 'package:card_swiper/card_swiper.dart';
import 'package:davetcim/src/comments/comments_view_model.dart';
import 'package:davetcim/src/products/product_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:davetcim/screens/notifications.dart';
import 'package:davetcim/shared/environments/const.dart';
import 'package:davetcim/widgets/badge.dart';
import 'package:davetcim/widgets/smooth_star_rating.dart';

import '../../shared/dto/basket_user_dto.dart';
import '../../shared/models/combo_generic_model.dart';
import '../../shared/models/reservation_model.dart';
import '../../shared/sessions/application_context.dart';
import '../../shared/sessions/user_basket_state.dart';
import '../../shared/utils/dialogs.dart';
import '../../shared/utils/utils.dart';
import '../../widgets/app_bar/app_bar_view.dart';
import '../../widgets/carousel_calender_order_widget.dart';
import '../../widgets/carousel_calender_widget.dart';
import '../../widgets/hashtag_widget.dart';
import '../../widgets/star_and_comment.dart';
import '../fav_products/fav_products_view_model.dart';
import '../join/join_view.dart';
import '../reservation/reservation_view_model.dart';
import '../select-orders/calender/calendar_view.dart';
import '../select-orders/properties/order_view.dart';
import '../select-orders/properties/order_view_model.dart';

class CommentsView extends StatefulWidget {
  @override
  _CommentsViewState createState() => _CommentsViewState();
  final  List<Widget> commentList;

  CommentsView(
      {Key key,
      @required this.commentList})
      : super(key: key);
}

class _CommentsViewState extends State<CommentsView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarMenu(pageName: "Yorumlar", isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: (MediaQuery.of(context).size.width / 12)),
        child: Container(
            height: MediaQuery.of(context).size.height,
            child:
            ListView(
              padding: const EdgeInsets.all(10.0),
              children: widget.commentList, // <<<<< Note this change for the return type
            )
        ),
      ),
      );
  }
}
