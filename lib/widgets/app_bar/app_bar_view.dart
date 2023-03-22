import 'package:davetcim/shared/environments/const.dart';
import 'package:davetcim/src/main/main_screen_view.dart';
import 'package:davetcim/widgets/app_bar/icon_badge_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../screens/notifications.dart';
import '../../shared/models/customer_model.dart';
import '../../shared/sessions/application_session.dart';
import '../../shared/utils/dialogs.dart';
import '../../shared/utils/language.dart';
import '../../shared/utils/utils.dart';
import '../../src/join/join_view.dart';
import '../../src/notifications/notifications_view.dart';
import '../badge.dart';
import '../on_error/somethingWentWrong.dart';
import '../popup_menu/popup_menu.dart';
import 'app_bar_view_model.dart';

class AppBarMenu extends StatefulWidget implements PreferredSizeWidget {
  final String pageName;
  final bool isHomnePageIconVisible;
  final bool isNotificationsIconVisible;
  final bool isPopUpMenuActive;

  AppBarMenu({Key key, @required this.pageName, @required this.isHomnePageIconVisible, @required this.isNotificationsIconVisible, @required this.isPopUpMenuActive}) : super(key: key);

  @override
  _AppBarMenu createState() => _AppBarMenu();

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);
}

class _AppBarMenu extends State<AppBarMenu> {
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
    double fontSize = 15;
    AppBarViewModel mdl = new AppBarViewModel();

    return ChangeNotifierProvider<AppBarViewModel>(
        create: (_)=>AppBarViewModel(),
        builder: (context,child) => StreamBuilder<List<CustomerModel>>(
                stream: Provider.of<AppBarViewModel>(context, listen: false).getUserInfo(),
                builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
                  if (asyncSnapshot.hasError) {
                    return SomethingWentWrongScreen();
                  } else if (asyncSnapshot.hasData) {
                    List<CustomerModel> userList = asyncSnapshot.data;
                    int notificationCount = 0;

                    if (userList.length > 0) {
                      CustomerModel mdl = userList[0];
                      notificationCount = mdl.notificationCount;
                    }

                    return AppBar(
                      backgroundColor: Constants.darkAccent,
                      automaticallyImplyLeading: false,
                      leading: IconButton(
                        icon: Icon(
                          Icons.keyboard_backspace,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      actions: <Widget>[
                        if(widget.isNotificationsIconVisible)
                          IconButton(
                            icon: AppBarIconBadge(
                              icon: Icons.notifications,
                              size: 22.0,
                              count: notificationCount.toString(),
                              backgroundColor: Colors.redAccent,
                              fontSize: 10.0,
                              textColor: Colors.white,
                            ),
                          onPressed: () {
                            if (ApplicationSession.userSession == null) {
                              showSucessMessage(context);
                            } else {
                              Utils.navigateToPage(context, NotificationsView());
                            }
                          },
                          tooltip: LanguageConstants
                              .bildirimler[LanguageConstants.languageFlag],
                        ),
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
                        if(widget.isPopUpMenuActive)
                          new PopUpMenu(),
                      ],
                      centerTitle: true,
                      title: Text(
                        widget.pageName,
                        style: TextStyle(
                          fontSize: fontSize,
                          color: Color(0xffffffff),
                          fontWeight: FontWeight.w900,
                          fontFamily: 'RobotoMono',
                        ),
                      ),
                      elevation: 0.0,
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })


        );
  }
}
