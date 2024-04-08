import 'package:davetcim/shared/environments/const.dart';
import 'package:davetcim/shared/models/general_data_model.dart';
import 'package:davetcim/shared/utils/language.dart';
import 'package:flutter/material.dart';

import '../../shared/helpers/general_helper.dart';
import '../../widgets/app_bar/app_bar_view.dart';
import '../../widgets/indicator.dart';

class AboutApplicationPage extends StatefulWidget {
  @override
  State<AboutApplicationPage> createState() => _AboutApplicationPageState();

}

class _AboutApplicationPageState extends State<AboutApplicationPage> {
  List<GeneralDataModel> generalDataModel = [];
  bool hasDataTaken = false;
  @override
  void initState() {
    getGeneralDatas();
    super.initState();
  }

  void getGeneralDatas() async{
    GeneralHelper generalHelperModel = new GeneralHelper();
    generalDataModel = await generalHelperModel.getGeneralData();
    setState(() {
      generalDataModel = generalDataModel;
      hasDataTaken = true;
    });
  }

  /// id 1 --> Hakkımızda / İletişim
  /// id 2 --> Uygulama Hakkında
  GeneralDataModel getSpesificData(int id) {
    GeneralDataModel generalData = generalDataModel.firstWhere((element) => element.id == id, orElse: () => null);
    return generalData;
  }


  @override
  Widget build(BuildContext context) {
    if (!hasDataTaken) {
      return Scaffold(appBar:
      AppBarMenu(pageName: "Uygulama Hakkında",  isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
          body: Padding(
              padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
              child: Center(child: Indicator())));
    }
    return Scaffold(
        appBar: AppBarMenu(pageName: LanguageConstants.uygulamaHakkinda[LanguageConstants.languageFlag], isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
        body: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blueGrey[700],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Constants.appName,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Versiyon: 1.0.0',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white54,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    GeneralHelper.generateText(getSpesificData(2)),
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[200],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),);
  }
}
