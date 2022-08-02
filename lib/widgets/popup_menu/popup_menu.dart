import 'dart:io';

import 'package:davetcim/shared/sessions/application_session.dart';
import 'package:davetcim/shared/utils/language.dart';
import 'package:davetcim/shared/utils/utils.dart';
import 'package:davetcim/src/home/home_view.dart';
import 'package:davetcim/src/info/about_application.dart';
import 'package:davetcim/src/info/about_us.dart';
import 'package:davetcim/src/join/join_view.dart';
import 'package:davetcim/src/main/main_screen_view.dart';
import 'package:davetcim/src/search/search_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PopUpMenu extends StatefulWidget {
  @override
  _PopUpMenu createState() => _PopUpMenu();
}

class _PopUpMenu extends State<PopUpMenu> {
  @override
  Widget build(BuildContext context) {
    if (ApplicationSession.userSession != null) {
      return getForAuthenticatedUser();
    } else {
      return getForUnauthenticatedUser();
    }
  }

  PopupMenuButton getForAuthenticatedUser() {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      icon: Icon(Icons.more_vert),
      itemBuilder: (BuildContext context) =>
      <PopupMenuEntry>[
        PopupMenuItem(
          value: 0,
          child: ListTile(
            leading: Icon(Icons.home),
            title: Text(
                LanguageConstants.anaSayfa[LanguageConstants.languageFlag]),
          ),
        ),
        PopupMenuDivider(),
        PopupMenuItem(
          value: 1,
          child: ListTile(
            leading: Icon(Icons.info),
            title: Text(
                LanguageConstants.hakkinda[LanguageConstants.languageFlag]),
          ),
        ),
        PopupMenuDivider(),
        PopupMenuItem(
          value: 2,
          child: ListTile(
            leading: Icon(Icons.info),
            title: Text(LanguageConstants
                .uygulamaHakkinda[LanguageConstants.languageFlag]),
          ),
        ),
        PopupMenuDivider(),
        PopupMenuItem(
          value: 3,
          child: ListTile(
            leading: Icon(Icons.logout),
            title:
            Text(LanguageConstants.cikis[LanguageConstants.languageFlag]),
          ),
        ),
        PopupMenuDivider(),
        PopupMenuItem(
          value: 4,
          child: ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text(LanguageConstants
                .uygulamayiKapat[LanguageConstants.languageFlag]),
          ),
        ),
      ],
      onSelected: (value) {
        if (value == 0) {
          Utils.navigateToPage(context, MainScreen());
        } else if (value == 1) {
          Utils.navigateToPage(context, AboutUsPage());
        } else if (value == 2) {
          Utils.navigateToPage(context, AboutApplicationPage());
        } else if (value == 3) {
          ApplicationSession.userSession = null;
          Utils.navigateToPage(context, MainScreen());
        } else if (value == 4) {
          if (Platform.isAndroid) {
            SystemNavigator.pop();
          } else if (Platform.isIOS) {
            exit(0);
          }
        }
      },
    );
  }


  PopupMenuButton getForUnauthenticatedUser() {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      icon: Icon(Icons.more_vert),
      itemBuilder: (BuildContext context) =>
      <PopupMenuEntry>[
        PopupMenuItem(
          value: 0,
          child: ListTile(
            leading: Icon(Icons.home),
            title: Text(
                LanguageConstants.anaSayfa[LanguageConstants.languageFlag]),
          ),
        ),
        PopupMenuDivider(),
        PopupMenuItem(
          value: 1,
          child: ListTile(
            leading: Icon(Icons.info),
            title: Text(
                LanguageConstants.hakkinda[LanguageConstants.languageFlag]),
          ),
        ),
        PopupMenuDivider(),
        PopupMenuItem(
          value: 2,
          child: ListTile(
            leading: Icon(Icons.info),
            title: Text(LanguageConstants
                .uygulamaHakkinda[LanguageConstants.languageFlag]),
          ),
        ),
        PopupMenuDivider(),
        PopupMenuItem(
          value: 3,
          child: ListTile(
            leading: Icon(Icons.login),
            title:
            Text(LanguageConstants.giris[LanguageConstants.languageFlag]),
          ),
        ),
        PopupMenuDivider(),
        PopupMenuItem(
          value: 4,
          child: ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text(LanguageConstants
                .uygulamayiKapat[LanguageConstants.languageFlag]),
          ),
        ),
      ],
      onSelected: (value) {
        if (value == 0) {
          Utils.navigateToPage(context, MainScreen());
        } else if (value == 1) {
          Utils.navigateToPage(context, AboutUsPage());
        } else if (value == 2) {
          Utils.navigateToPage(context, AboutApplicationPage());
        } else if (value == 3) {
          Utils.navigateToPage(context, JoinView());
        } else if (value == 4) {
          if (Platform.isAndroid) {
            SystemNavigator.pop();
          } else if (Platform.isIOS) {
            exit(0);
          }
        }
      },
    );
  }
}