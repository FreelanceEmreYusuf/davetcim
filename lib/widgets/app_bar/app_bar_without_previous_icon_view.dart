import 'package:davetcim/shared/environments/const.dart';
import 'package:davetcim/src/main/main_screen_view.dart';
import 'package:davetcim/widgets/app_bar/icon_badge_widget.dart';
import 'package:davetcim/widgets/badge.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../screens/notifications.dart';
import '../../shared/models/customer_model.dart';
import '../../shared/sessions/application_session.dart';
import '../../shared/utils/dialogs.dart';
import '../../shared/utils/language.dart';
import '../../shared/utils/utils.dart';
import '../../src/join/join_view.dart';
import '../on_error/somethingWentWrong.dart';
import '../popup_menu/popup_menu.dart';
import 'app_bar_view_model.dart';
import 'icon_badge.dart';

class AppBarMenuWithOutPreviousPageIcon extends StatefulWidget implements PreferredSizeWidget {
  final String pageName;
  final bool isHomnePageIconVisible;
  final bool isNotificationsIconVisible;
  final bool isPopUpMenuActive;

  AppBarMenuWithOutPreviousPageIcon({Key key, @required this.pageName, @required this.isHomnePageIconVisible, @required this.isNotificationsIconVisible, @required this.isPopUpMenuActive}) : super(key: key);

  @override
  _AppBarMenu createState() => _AppBarMenu();

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);
}

class _AppBarMenu extends State<AppBarMenuWithOutPreviousPageIcon> {
  @override
  static void showSucessMessage(BuildContext context) {
    Dialogs.showAlertMessageWithAction(
        context,
        "",
        LanguageConstants
            .dialogGoToLoginFromNotification[LanguageConstants.languageFlag],
        pushToJoinPage);
  }

  static void pushToJoinPage(BuildContext context) {
    Utils.navigateToPage(context, JoinView(childPage: new Notifications()));
  }

  @override
  Widget build(BuildContext context) {
    double fontSize = 25;
    AppBarViewModel mdl = new AppBarViewModel();

    return AppBar(
      centerTitle: true,
      backgroundColor: Constants.darkAccent,
      automaticallyImplyLeading: false,
      actions: <Widget>[
        if(widget.isHomnePageIconVisible)
          IconButton(
            icon: Icon(
              Icons.home,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return MainScreen();
                  },
                ),
              );
            },
          ),
        if(widget.isNotificationsIconVisible)
          IconButton(
            icon: AppBarIconBadge(
              icon: Icons.notifications,
              size: 22.0,
              count: "0",//notificationCount.toString(),
              backgroundColor: Colors.redAccent,
              fontSize: 10.0,
              textColor: Colors.white,
            ),
            onPressed: () {
              if (ApplicationSession.userSession == null) {
                showSucessMessage(context);
              } else {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return Notifications();
                    },
                  ),
                );
              }
            },
            tooltip: LanguageConstants
                .bildirimler[LanguageConstants.languageFlag],
          ),
        if(widget.isPopUpMenuActive)
          new PopUpMenu(),
      ],
      //   centerTitle: true,
      title: Text(
        widget.pageName,
        style: TextStyle(
          fontSize: fontSize,
          color: Color(0xffffffff),
          fontWeight: FontWeight.w700,
          fontFamily: 'RobotoMono',
        ),
      ),
      elevation: 0.0,
    );
  }
}
