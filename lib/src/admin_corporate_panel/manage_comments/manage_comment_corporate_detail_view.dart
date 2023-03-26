import 'package:davetcim/shared/enums/reservation_status_enum.dart';
import 'package:davetcim/shared/models/comment_model.dart';
import 'package:davetcim/src/admin_corporate_panel/manage_comments/manage_comment_corporate_view_model.dart';
import 'package:davetcim/src/admin_corporate_panel/reservation/reservation_corporate_view_model.dart';
import 'package:davetcim/src/comments/comments_view_model.dart';
import 'package:davetcim/src/notifications/notifications_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../shared/dto/reservation_detail_view_model.dart';
import '../../../shared/models/reservation_detail_model.dart';
import '../../../shared/utils/date_utils.dart';
import '../../../shared/utils/dialogs.dart';
import '../../../shared/utils/language.dart';
import '../../../shared/utils/utils.dart';
import '../../../widgets/app_bar/app_bar_view.dart';
import '../../../widgets/grid_corporate_detail_services_summary.dart';
import '../../notifications/notifications_view_model.dart';
import 'manage_comment_corporate_view.dart';

class ManageCommentCorporateDetailScreen extends StatefulWidget {
  @override
  _ManageCommentCorporateDetailScreenState createState() => _ManageCommentCorporateDetailScreenState();
  final CommentModel commentModel;
  final bool isFromNotification;

  ManageCommentCorporateDetailScreen(
      {Key key,
        @required this.commentModel,
        @required this.isFromNotification,
      })
      : super(key: key);

}

class _ManageCommentCorporateDetailScreenState extends State<ManageCommentCorporateDetailScreen>
    with AutomaticKeepAliveClientMixin<ManageCommentCorporateDetailScreen> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (widget.commentModel == null) {
      return Scaffold(appBar:
      AppBarMenu(pageName: "Yorum Detayı", isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
          body: Padding(
              padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
              child: Center(child: CircularProgressIndicator())));
    }

    Color color = Colors.green;
    String textStr = 'ONAYLANMIŞ YORUM';
    if (!widget.commentModel.isApproved) {
      color = Colors.grey;
      textStr = 'ONAY BEKLEYEN YORUM';
    }
    var date = widget.commentModel.date;

    bool isFromNotification = false;
    if(widget.isFromNotification != null){
      isFromNotification = widget.isFromNotification;
    }

    Future<void> deleteService() async {
      NotificationsViewModel notificationsViewModel = NotificationsViewModel();
      await notificationsViewModel.deleteNotificationsFromAdminUsers(context, widget.commentModel.id, 0);
      await notificationsViewModel.sendNotificationToUser(context,widget.commentModel.corporationId,
          widget.commentModel.customerId, widget.commentModel.id, 0, false,  widget.commentModel.comment);
      ManageCommentCorporateViewModel service = ManageCommentCorporateViewModel();
      await service.deleteService(widget.commentModel);
      if(isFromNotification)
        Utils.navigateToPage(context, NotificationsView());
      else
        Utils.navigateToPage(context, ManageCommentCorporateView());
    }

    Future<void> deleteServiceWithoutDeleteNotifications() async {
      ManageCommentCorporateViewModel service = ManageCommentCorporateViewModel();
      await service.deleteService(widget.commentModel);
      Utils.navigateToPage(context, ManageCommentCorporateView());
    }

    Future<void> updateService() async {
      ManageCommentCorporateViewModel service = ManageCommentCorporateViewModel();
      await service.updateComment(widget.commentModel);
      NotificationsViewModel notificationsViewModel = NotificationsViewModel();
      await notificationsViewModel.sendNotificationToUser(context, widget.commentModel.corporationId,
          widget.commentModel.customerId, widget.commentModel.id, 0, true,  widget.commentModel.comment);
      await notificationsViewModel.deleteNotificationsFromAdminUsers(context, widget.commentModel.id, 0);

      if(isFromNotification)
        Utils.navigateToPage(context, NotificationsView());
      else
        Utils.navigateToPage(context, ManageCommentCorporateView());

    }

    Widget bottomWidget = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Container(
              height: MediaQuery.of(context).size.height / 15,
              child: TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.green,),
                child: Text(
                  "ONAYLA".toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () async {
                  await Dialogs.showDialogMessage(
                      context,
                      LanguageConstants
                          .processApproveHeader[LanguageConstants.languageFlag],
                      "Onaylamak istediğinize emin misiniz?",
                      updateService, '');
                  //Utils.navigateToPage(context, ManageCommentCorporateView());
                },
              ),
            ),
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Container(
              height: MediaQuery.of(context).size.height / 15,
              child: TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.redAccent,),
                child: Text(
                  "SİL".toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () async {
                  await Dialogs.showDialogMessage(
                      context,
                      LanguageConstants
                          .processApproveHeader[LanguageConstants.languageFlag],
                      LanguageConstants.processApproveDeleteMessage[
                      LanguageConstants.languageFlag],
                      deleteService, '');
                  //Utils.navigateToPage(context, ManageCommentCorporateView());
                },
              ),
            ),
          ),
        ],
      ),
    );
    if(widget.commentModel.isApproved){
      bottomWidget = Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Container(
                height: MediaQuery.of(context).size.height / 15,
                child: TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.redAccent,),
                  child: Text(
                    "YORUMU SİL".toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () async {
                    await Dialogs.showDialogMessage(
                        context,
                        LanguageConstants
                            .processApproveHeader[LanguageConstants.languageFlag],
                        LanguageConstants.processApproveDeleteMessage[
                        LanguageConstants.languageFlag],
                        deleteServiceWithoutDeleteNotifications, '');
                    //Utils.navigateToPage(context, ManageCommentCorporateView());
                  },
                ),
              ),
            ),
          ],
        ),
      );
    }
    return Scaffold(
      appBar: AppBarMenu(pageName: "Yorum Detayı", isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: ListView(
          children: <Widget>[
            //Müştreri
            SizedBox(height: 10.0),
            Container(
              height: MediaQuery.of(context).size.height / 13,
              child: Card(
                color: color,
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shadowColor: Colors.black,
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                        textStr, style: TextStyle(fontSize: 18, color: Colors.white, fontStyle: FontStyle.normal,fontWeight: FontWeight.bold,)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15.0),
            Container(
              height: MediaQuery.of(context).size.height / 13,
              child: Card(
                color: Colors.redAccent,
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shadowColor: Colors.black,
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                        " YORUM DETAYLARI", style: TextStyle(fontSize: 18, color: Colors.white, fontStyle: FontStyle.normal,fontWeight: FontWeight.bold,)),
                  ],
                ),
              ),
            ),
            Divider(),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  elevation: 10,
                  color: Colors.white54,
                  child: Row(
                    children: [
                      Text(
                          "Tarih : "+(DateConversionUtils.convertTimestampTString(int.parse(date.millisecondsSinceEpoch.toString())))
                              +"\n\nKullanıcı Adı : "+widget.commentModel.userName
                              +"\n\nYıldız : "+widget.commentModel.star.toString(),
                          style: TextStyle(fontSize: 16, color: Colors.black, fontStyle: FontStyle.normal,fontWeight: FontWeight.bold, )
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 13,
              child: Card(
                color: Colors.redAccent,
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shadowColor: Colors.black,
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                        " YORUM MESAJI", style: TextStyle(fontSize: 18, color: Colors.white, fontStyle: FontStyle.normal,fontWeight: FontWeight.bold,)),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  elevation: 10,
                  color: Colors.white54,
                  child: Column(
                    children: [
                      Text(
                          widget.commentModel.comment,
                          style: TextStyle(fontSize: 16, color: Colors.black, fontStyle: FontStyle.normal,fontWeight: FontWeight.bold, )
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar:  bottomWidget,

    );



  }



  @override
  bool get wantKeepAlive => true;
}
