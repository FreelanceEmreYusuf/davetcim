import 'package:davetcim/shared/models/comment_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../shared/enums/reservation_status_enum.dart';
import '../shared/utils/date_utils.dart';
import '../shared/utils/utils.dart';
import '../src/admin_corporate_panel/all_reservation/all_reservation_corporate_detail_view.dart';
import '../src/admin_corporate_panel/manage_comments/manage_comment_corporate_detail_view.dart';

class CorporateCommentsCardWidget extends StatefulWidget {
  final  CommentModel model;

  CorporateCommentsCardWidget({
    Key key,
    @required this.model,
  }) : super(key: key);

  @override
  _CorporateCommentsCardWidgetState createState() =>
      _CorporateCommentsCardWidgetState();
}

class _CorporateCommentsCardWidgetState
    extends State<CorporateCommentsCardWidget> {
  @override
  Widget build(BuildContext context) {
    Color color = Colors.green;
    String text = "Onaylanmış";
    var date = widget.model.date;
    if (!widget.model.isApproved) {
      color = Colors.grey;
      text = "Onay Bekliyor";
    }
    int commentLength= widget.model.comment.length;
    String endText = "";
    if(commentLength> 20){
      commentLength = 20;
      endText = "...";
    }

    return Container(
      child: InkWell(
        onTap: (){
         Utils.navigateToPage(context, ManageCommentCorporateDetailScreen(commentModel: widget.model, isFromNotification: false,));
        },
        child: SingleChildScrollView(
          child: Card(
            color: color,
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shadowColor: Colors.black,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text((DateConversionUtils.convertTimestampTString(int.parse(date.millisecondsSinceEpoch.toString()))),
                      style: TextStyle(overflow: TextOverflow.ellipsis,   fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold,),
                      maxLines: 5,
                    ),
                  ),
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text("\n\n Kullanıcı Adı : " + widget.model.userName + "\n Onay Durumu : "+text +
                          "\n "+ widget.model.star.toString()+" Yıldız - " +"Yorum : " + widget.model.comment.substring(0,commentLength)+endText,
                        style: TextStyle(overflow: TextOverflow.ellipsis,   fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold,),
                        maxLines: 5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }

}
