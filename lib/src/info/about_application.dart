import 'package:davetcim/shared/environments/const.dart';
import 'package:davetcim/shared/models/general_data_model.dart';
import 'package:davetcim/shared/utils/language.dart';
import 'package:flutter/material.dart';

import '../../shared/helpers/general_helper.dart';
import '../../widgets/app_bar/app_bar_view.dart';

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
              child: Center(child: CircularProgressIndicator())));
    }
    return Scaffold(
        appBar: AppBarMenu(pageName: LanguageConstants.uygulamaHakkinda[LanguageConstants.languageFlag], isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                      GeneralHelper.generateText(getSpesificData(2)),
                    /*LanguageConstants
                        .uygulamaBilgilendirme[LanguageConstants.languageFlag],*/
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white60,
                      fontStyle: FontStyle.italic,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(10.0, 10.0),
                          blurRadius: 2.0,
                          color: Colors.black54,
                        ),
                        Shadow(
                          offset: Offset(10.0, 10.0),
                          blurRadius: 1.0,
                          color: Colors.black54,
                        ),
                      ],
                      fontFamily: 'RobotoMono',
                    ),
                    overflow: TextOverflow.clip,
                  ),
                  color: Constants.lightPrimary,
                ),
              ],
            )));
  }
}
