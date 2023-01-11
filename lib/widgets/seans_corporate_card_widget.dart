import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../shared/models/corporate_sessions_model.dart';
import '../shared/models/service_corporate_pool_model.dart';
import '../shared/models/service_pool_model.dart';
import '../shared/utils/dialogs.dart';
import '../shared/utils/language.dart';
import '../shared/utils/utils.dart';
import '../src/admin_corporate_panel/seans/seans_corporate_update_view.dart';
import '../src/admin_corporate_panel/seans/seans_corporate_view.dart';
import '../src/admin_corporate_panel/seans/seans_corporate_view_model.dart';
import '../src/admin_corporate_panel/service/service-corporate_view_model.dart';
import '../src/admin_corporate_panel/service/service_corporate_add_view.dart';
import '../src/admin_corporate_panel/service/service_corporate_update_view.dart';
import '../src/admin_corporate_panel/service/service_corporate_view.dart';
import '../src/admin_panel/service/service_add_view.dart';
import '../src/admin_panel/service/service_view.dart';
import '../src/admin_panel/service/service_view_model.dart';

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
    return Card(
      color: Colors.black45,
      shadowColor: Colors.black45,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height / 10,
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Text(
                widget.model.name, style: TextStyle(fontSize: 18, color: Colors.white, fontStyle: FontStyle.italic)),
            Spacer(flex: 25,),
            SizedBox.fromSize(
              size: Size(MediaQuery.of(context).size.height / 20, MediaQuery.of(context).size.height / 20), // button width and height
              child: ClipOval(
                child: Material(
                  color: Colors.white60, // button color
                  child: InkWell(
                    splashColor: Colors.lightBlue, // splash color
                    onTap: () {
                      Utils.navigateToPage(context, SeansCorporateUpdateView(sessionModel: widget.model));
                      //SeansCorporateUpdateView
                    }, // button pressed
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.update, color: Colors.white,), // icon
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Spacer(flex: 1),
            SizedBox.fromSize(
              size: Size(MediaQuery.of(context).size.height / 20, MediaQuery.of(context).size.height / 20), // button width and height
              child: ClipOval(
                child: Material(
                  color: Colors.white60, // button color
                  child: InkWell(
                    splashColor: Colors.red, // splash color
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
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Divider(
              //*iki eleman arasini bolen cizgi
              color: Colors.black45,
              thickness: 1,
              height: 20,
              indent: 5, //*soldan bosluk
              endIndent: 5, //*sagdan bosluk
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