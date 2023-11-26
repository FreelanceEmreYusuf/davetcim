import 'package:davetcim/shared/models/comment_model.dart';
import 'package:davetcim/shared/sessions/application_cache.dart';
import 'package:davetcim/src/admin_corporate_panel/reservation/reservation_corporate_view_model.dart';
import 'package:davetcim/src/admin_corporate_panel/seans/seans_corporate_add_view.dart';
import 'package:davetcim/src/admin_corporate_panel/seans/seans_corporate_view_model.dart';
import 'package:davetcim/widgets/corporate_comments_card_widget.dart';
import 'package:flutter/material.dart';
import '../../../shared/models/corporate_sessions_model.dart';
import '../../../shared/models/reservation_model.dart';
import '../../../shared/utils/utils.dart';
import '../../../widgets/app_bar/app_bar_view.dart';
import '../../../widgets/reservation_all_corporate_card_widget.dart';
import '../../../widgets/reservation_corporate_card_widget.dart';
import '../../../widgets/seans_corporate_card_widget.dart';
import '../../reservation/reservation_view_model.dart';
import 'manage_comment_corporate_view_model.dart';


class ManageCommentCorporateView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<ManageCommentCorporateView> {
  List<CommentModel> commentList = [];
  final registerFormKey = GlobalKey <FormState> ();

  @override
  void initState() {
    callGetComments();
    super.initState();
  }

  void callGetComments() async {
    ManageCommentCorporateViewModel model = ManageCommentCorporateViewModel();
    commentList = await model.getCorporateComments(ApplicationCache.userCache.corporationId);

    setState(() {
      commentList = commentList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMenu(pageName: "Yorum Yönetimi", isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: ListView(
          children: <Widget>[
            Divider(),
            SizedBox(height: 10.0),
            GridView.builder(
              shrinkWrap: true,
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 5),
              ),
              itemCount: commentList == null
                  ? 0
                  : commentList.length,
              itemBuilder: (BuildContext context, int index) {
                CommentModel item = commentList[index];
                return CorporateCommentsCardWidget(model: item);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar:  Padding(
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
                  child: FittedBox(
                    child: Text(
                      "Yeşil : Onaylanmış Yorum",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onPressed: () async {

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
                  style: TextButton.styleFrom(backgroundColor: Colors.grey,),
                  child: FittedBox(
                    child: Text( 
                      "Gri : Onay Bekleyen Yorum",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onPressed: () async {

                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

