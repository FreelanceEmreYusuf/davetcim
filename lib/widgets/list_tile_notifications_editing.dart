import 'package:flutter/material.dart';
import '../shared/utils/language.dart';
import '../src/notifications/notifications_view_model.dart';


class ListTileNotificationsEditing extends StatefulWidget {
  final String comment;
  final int id;
  final int basketId;
  final int commentId;
  final int categoryId;
  final bool isForAdmin;
  const ListTileNotificationsEditing(
      this.comment, this.id, this.basketId, this.commentId, this.categoryId,
      this.isForAdmin);
  @override
  _ListTileNotificationsEditingState createState() =>
      _ListTileNotificationsEditingState();
}

class _ListTileNotificationsEditingState
    extends State<ListTileNotificationsEditing> {
  void deleteNotification(int id) async {
    NotificationsViewModel notificationsViewModel = NotificationsViewModel();
    notificationsViewModel.deleteNotification(context, id);
  }
/*
  void goToNotificationDetail() async {
    if (widget.basketId > 0 && widget.isForAdmin) {
      goToAdminApproveCard();
    } else if (widget.basketId > 0 && !widget.isForAdmin) {
      goToUserCardDetail();
    } else if (widget.commentId > 0 && widget.isForAdmin) {
      goToAdminCommentsScreen();
    } else if (widget.commentId > 0 && !widget.isForAdmin) {
      goToUserCommentsScreen();
    } else if (widget.categoryId > 0) {
      goToProductDetail();
    }
  }

  void goToAdminApproveCard() async {
    CollectionReference docsRef = Utils.getCollectionRef(Constants.basketDb);
    var response = await docsRef.where('id', isEqualTo: widget.basketId).get();

    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      Map item = list[0].data();

      if (item["status"] == 2 || item["status"] == 3) {
        Dialogs.showAlertMessage(
            context,
            "",
            LanguageConstants
                .cardApprovedOrRejected[LanguageConstants.languageFlag]);
      } else {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return AdminBasketApprove(
                item["userId"],
                widget.basketId,
                item["totalCount"],
                item["productCount"],
                item["userMessage"],
                Utils.StringGetDateTime(item["entranceDate"]),
              );
            },
          ),
        );
      }
    }
  }

  void goToUserCardDetail() async {
    CollectionReference docsRef = Utils.getCollectionRef(Constants.basketDb);
    var response = await docsRef.where('id', isEqualTo: widget.basketId).get();

    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      Map item = list[0].data();

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return AdminOldBasketShowDetail(
              item["userId"],
              widget.basketId,
              item["totalCount"],
              item["productCount"],
              Utils.StringGetDateTime(item["entranceDate"]),
              item["userMessage"],
              item["status"],
            );
          },
        ),
      );
    }
  }

  void goToAdminCommentsScreen() async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return AdminCommentScreen();
        },
      ),
    );
  }

  void goToUserCommentsScreen() async {
    CollectionReference docsRef =
    Utils.getCollectionRef(Constants.productCommentsDb);
    var response = await docsRef.where('id', isEqualTo: widget.commentId).get();

    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      Map item = list[0].data();
      int categoryId = item["categoryId"];
      int productId = item["productId"];

      CollectionReference productsRef =
      Utils.getCollectionRef(Constants.productDb);

      var responsePrd =
      await productsRef.where('id', isEqualTo: productId).get();

      if (responsePrd.docs != null && responsePrd.docs.length > 0) {
        var listPrd = responsePrd.docs;
        Map itemPrd = listPrd[0].data();

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return ProductDetailsWithComment(categoryId,
                  itemPrd["ratingCount"], itemPrd["averageRating"], productId);
            },
          ),
        );
      }
    }
  }

  void goToProductDetail() async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return FilteredProductsScreenState(widget.categoryId);
        },
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
      //  goToNotificationDetail();
      },
      leading: CircleAvatar(
        backgroundColor: Colors.red,
        child: Icon(
          Icons.notifications,
          color: Colors.white,
        ),
      ),
      title: Text(widget.comment),
      trailing: IconButton(
        icon: Icon(
          Icons.delete,
          size: 20.0,
        ),
        color: Colors.red,
        splashColor: Colors.red,
        onPressed: () {
          deleteNotification(widget.id);
        },
        tooltip: LanguageConstants.sil[LanguageConstants.languageFlag],
      ),
    );
  }
}
