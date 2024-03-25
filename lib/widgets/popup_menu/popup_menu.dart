import 'dart:io';

import 'package:davetcim/shared/utils/language.dart';
import 'package:davetcim/shared/utils/utils.dart';
import 'package:davetcim/src/admin_panel/AdminPanel.dart';
import 'package:davetcim/src/info/about_application.dart';
import 'package:davetcim/src/info/about_us.dart';
import 'package:davetcim/src/join/join_view.dart';
import 'package:davetcim/src/main/main_screen_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../shared/enums/customer_role_enum.dart';
import '../../shared/helpers/corporate_helper.dart';
import '../../shared/sessions/user_state.dart';
import '../../src/admin_corporate_panel/AdminCorporatePanel.dart';

class PopUpMenu extends StatefulWidget {
  @override
  _PopUpMenu createState() => _PopUpMenu();
}



class _PopUpMenu extends State<PopUpMenu> {
  bool isCorpActive = false;
  void isCorporationActive(int corporateId) async{
    CorporateHelper _corporateHelper = CorporateHelper();
    isCorpActive = await _corporateHelper.isCorporationActive(corporateId);
    setState(() {
      isCorpActive = isCorpActive;
    });
  }
  @override
  void initState() {
    if (UserState.isPresent()) {
      isCorporationActive(UserState.corporationId);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (UserState.isPresent()) {
      if (UserState.roleId == CustomerRoleEnum.admin) {
        return getForAdmin();
      } else if (UserState.roleId == CustomerRoleEnum.organizationOwner) {
        if(isCorpActive && UserState.corporationId !=0 )
          return getForCorporateAdmin();
        else
        return getForAuthenticatedUser();
      }else {
        return getForAuthenticatedUser();
      }
    } else {
      return getForUnauthenticatedUser();
    }
  }

  PopupMenuButton getForAdmin() {
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
            leading: Icon(Icons.admin_panel_settings),
            title: Text(
                LanguageConstants.adminPaneli[LanguageConstants.languageFlag]),
          ),
        ),
        PopupMenuDivider(),
        PopupMenuItem(
          value: 4,
          child: ListTile(
            leading: Icon(Icons.logout),
            title:
            Text(LanguageConstants.cikis[LanguageConstants.languageFlag]),
          ),
        ),
        PopupMenuDivider(),
        PopupMenuItem(
          value: 5,
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
          Utils.navigateToPage(context, AdminPanelPage());
        } else if (value == 4) {
          UserState.setAsNull();
          Utils.navigateToPage(context, MainScreen());
        } else if (value == 5) {
          if (Platform.isAndroid) {
            SystemNavigator.pop();
          } else if (Platform.isIOS) {
            exit(0);
          }
        }
      },
    );
  }

  PopupMenuButton getForCorporateAdmin() {
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
            leading: Icon(Icons.admin_panel_settings),
            title: Text(
                LanguageConstants.adminPaneli[LanguageConstants.languageFlag]),
          ),
        ),
        PopupMenuDivider(),
        PopupMenuItem(
          value: 4,
          child: ListTile(
            leading: Icon(Icons.logout),
            title:
            Text(LanguageConstants.cikis[LanguageConstants.languageFlag]),
          ),
        ),
        PopupMenuDivider(),
        PopupMenuItem(
          value: 5,
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
          Utils.navigateToPage(context, AdminCorporatePanelPage());
        } else if (value == 4) {
          UserState.setAsNull();
          Utils.navigateToPage(context, MainScreen());
        } else if (value == 5) {
          if (Platform.isAndroid) {
            SystemNavigator.pop();
          } else if (Platform.isIOS) {
            exit(0);
          }
        }
      },
    );
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
          UserState.setAsNull();
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