import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../shared/models/corporate_sessions_model.dart';
import '../shared/utils/dialogs.dart';
import '../shared/utils/language.dart';
import '../shared/utils/utils.dart';
import '../src/admin_corporate_panel/seans/seans_corporate_update_view.dart';
import '../src/admin_corporate_panel/seans/seans_corporate_view.dart';
import '../src/admin_corporate_panel/seans/seans_corporate_view_model.dart';

class SeansCorporateCardWidget extends StatefulWidget {
  final CorporateSessionsModel model;

  SeansCorporateCardWidget({
    Key key,
    @required this.model,
  }) : super(key: key);

  @override
  _SeansCorporateCardWidgetState createState() =>
      _SeansCorporateCardWidgetState();
}

class _SeansCorporateCardWidgetState
    extends State<SeansCorporateCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: Colors.white54,
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shadowColor: Colors.black,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                  widget.model.name, style: TextStyle(fontSize: 15, color: Colors.black, fontStyle: FontStyle.italic,fontWeight: FontWeight.bold)),
            ),
            Spacer(),
            SizedBox.fromSize(
              size: Size(MediaQuery.of(context).size.height / 18, MediaQuery.of(context).size.height / 10), // button width and height
              child: ClipPath(
                child: Material(
                  color: Colors.blue, // button color
                  child: InkWell(
                    splashColor: Colors.lightBlueAccent, // splash color
                    onTap: () {
                      Utils.navigateToPage(context, SeansCorporateUpdateView(sessionModel: widget.model));
                      //SeansCorporateUpdateView
                    }, // button pressed
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.update, color: Colors.white,), // icon
                //        Text("Güncelle", style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox.fromSize(
              size: Size(MediaQuery.of(context).size.height / 15, MediaQuery.of(context).size.height / 10), // button width and height
              child: ClipPath(
                child: Material(
                  color: Colors.red, // button color
                  child: InkWell(
                    splashColor: Colors.redAccent, // splash color
                    onTap: () async{
                      await Dialogs.showDialogMessage(
                          context,
                          LanguageConstants
                              .processApproveHeader[LanguageConstants.languageFlag],
                          LanguageConstants.processApproveDeleteMessage[
                          LanguageConstants.languageFlag],
                          deleteService, '');
                    }, // button pressed
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.delete, color: Colors.white), // icon
                 //       Text("Sil", style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> deleteService() async {
    CorporateSessionsViewModel service = CorporateSessionsViewModel();
    await service.deleteSession(widget.model.id);
    Utils.navigateToPage(context, SeansCorporateView());
  }

}
