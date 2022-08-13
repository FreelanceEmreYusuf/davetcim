import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../shared/models/customer_model.dart';
import '../../shared/sessions/application_session.dart';
import '../../shared/utils/dialogs.dart';
import '../../shared/utils/language.dart';
import '../../src/main/main_screen_view_model.dart';
import '../badge.dart';
import '../on_error/somethingWentWrong.dart';
import 'app_bar_view_model.dart';

class BottomAppBarMenu extends StatefulWidget implements PreferredSizeWidget {
  final PageController pageController;
  final int page;

  BottomAppBarMenu({Key key, @required this.pageController, @required this.page}) : super(key: key);

  @override
  _BottomAppBarMenu createState() => _BottomAppBarMenu();

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);
}

class _BottomAppBarMenu extends State<BottomAppBarMenu> {
  @override
  Widget build(BuildContext context) {
    double fontSize = 20;
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
                int basketCount = 0;

                if (userList.length > 0) {
                  CustomerModel mdl = userList[0];
                  notificationCount = mdl.notificationCount;
                  basketCount = mdl.basketCount;
                }

                return BottomAppBar(
                  child: new Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(width: 7),
                      IconButton(
                        icon: Icon(
                          Icons.home,
                          size: 24.0,
                        ),
                        color: widget.page == 0
                            ? Theme.of(context).accentColor
                            : Theme.of(context).textTheme.caption.color,
                        onPressed: () => widget.pageController.jumpToPage(0),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.favorite,
                          size: 24.0,
                        ),
                        color: widget.page == 1
                            ? Theme.of(context).accentColor
                            : Theme.of(context).textTheme.caption.color,
                        onPressed: () {
                          if (ApplicationSession.userSession == null) {
                            Dialogs.showAlertMessage(
                                context,
                                "",
                                "Favori ürünlerinizi görüntüleyebilmek için öncelikli üye girişi yapmalısınız.");
                          } else {
                            widget.pageController.jumpToPage(1);
                          }
                        }
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.search,
                          size: 24.0,
                          color: Theme.of(context).primaryColor,
                        ),
                        color: widget.page == 2
                            ? Theme.of(context).accentColor
                            : Theme.of(context).textTheme.caption.color,
                        onPressed: () => widget.pageController.jumpToPage(2),
                      ),
                      IconButton(
                        icon: IconBadge(
                          icon: Icons.shopping_cart,
                          size: 24.0,
                          count: basketCount,
                        ),
                        color: widget.page == 3
                            ? Theme.of(context).accentColor
                            : Theme.of(context).textTheme.caption.color,
                        onPressed: () => widget.pageController.jumpToPage(3),
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.person,
                            size: 24.0,
                          ),
                          color: widget.page == 4
                              ? Theme.of(context).accentColor
                              : Theme.of(context).textTheme.caption.color,
                          onPressed: () => {
                            if (ApplicationSession.userSession == null) {
                                Dialogs.showAlertMessage(
                                context,
                                "",
                                "Profilinizi görüntüleyebilmek için öncelikli üye girişi yapmalısınız."),
                              } else {
                                widget.pageController.jumpToPage(4),
                              }
                          }),
                      SizedBox(width: 7),
                    ],
                  ),
                  color: Theme.of(context).primaryColor,
                  shape: CircularNotchedRectangle(),
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
