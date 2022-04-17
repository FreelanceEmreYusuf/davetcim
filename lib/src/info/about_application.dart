import 'package:davetcim/environments/const.dart';
import 'package:davetcim/shared/utils/language.dart';
import 'package:davetcim/src/widgets/app_bar/app_bar_view.dart';
import 'package:flutter/material.dart';

class AboutApplicationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarMenu(
            pageName: LanguageConstants
                .uygulamaHakkinda[LanguageConstants.languageFlag]),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    LanguageConstants
                        .uygulamaBilgilendirme[LanguageConstants.languageFlag],
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
