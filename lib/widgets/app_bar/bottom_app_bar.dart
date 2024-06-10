import 'package:davetcim/src/fav_products/favorite_screen_with_appbar.dart';
import 'package:davetcim/src/join/join_view.dart';
import 'package:davetcim/src/user_reservations/user_reservations_with_app_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_provider.dart';
import '../../shared/environments/const.dart';
import '../../shared/models/customer_model.dart';
import '../../shared/sessions/user_state.dart';
import '../../shared/utils/utils.dart';
import '../../src/profile/profile_view_with_app_bar.dart';
import '../bounce_button.dart';
import '../indicator.dart';
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
    Color isLoginColor = UserState.isPresent() ? Colors.lightGreen :  Theme.of(context).textTheme.caption.color;

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
                      BounceButton(
                        child: Icon(
                          Icons.home,
                          size: MediaQuery.of(context).size.height / 22,
                          color: widget.page == 0
                              ? Theme.of(context).accentColor
                              : Theme.of(context).textTheme.caption.color,
                        ),
                        onTap: (){
                         // Utils.navigateToPage(context, SelectLocationPage());
                          widget.pageController.jumpToPage(0);
                        },
                        height: MediaQuery.of(context).size.height / 17,
                        width: MediaQuery.of(context).size.width / 10,
                        duration: Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Provider.of<AppProvider>(context).theme  ==
                              Constants.lightTheme
                              ? Colors.transparent
                              : Colors.transparent,
                        ),
                      ),
                      BounceButton(
                        child: Icon(
                          Icons.favorite,
                          size: MediaQuery.of(context).size.height / 22,
                          color: widget.page == 1
                              ? Theme.of(context).accentColor
                              : Theme.of(context).textTheme.caption.color,
                        ),
                        onTap: (){
                          if (!UserState.isPresent()) {
                            Utils.navigateToPage(context, JoinView(childPage: new FavoriteScreenWithAppBar()));
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Favori mekanlar listenizi görüntüleyebilmek için öncelikli üye girişi yapmalısınız."),
                                  duration: Duration(milliseconds: 2500),));
                          } else {
                            widget.pageController.jumpToPage(1);
                          }
                        },
                        height: MediaQuery.of(context).size.height / 17,
                        width: MediaQuery.of(context).size.width / 10,
                        duration: Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Provider.of<AppProvider>(context).theme ==
                              Constants.lightTheme
                              ? Colors.transparent
                              : Colors.transparent,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.search,
                          size: MediaQuery.of(context).size.height / 22,
                          color: Theme.of(context).primaryColor,
                        ),
                        color: widget.page == 2
                            ? Theme.of(context).accentColor
                            : Theme.of(context).textTheme.caption.color,
                        onPressed: () => widget.pageController.jumpToPage(2),
                      ),
                      BounceButton(
                        child: Icon(
                          Icons.shopping_cart,
                          size: MediaQuery.of(context).size.height / 22,
                          color: widget.page == 3
                              ? Theme.of(context).accentColor
                              : Theme.of(context).textTheme.caption.color,
                        ),
                        onTap: (){
                          if (!UserState.isPresent()) {
                            Utils.navigateToPage(context, JoinView(childPage: new UserReservationsWithAppBarScreen()));
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Sepetinizi görüntüleyebilmek için öncelikli üye girişi yapmalısınız."),
                                  duration: Duration(milliseconds: 2500),));
                          } else {
                            widget.pageController.jumpToPage(3);
                          }
                        },
                        height: MediaQuery.of(context).size.height / 17,
                        width: MediaQuery.of(context).size.width / 10,
                        duration: Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Provider.of<AppProvider>(context).theme ==
                              Constants.lightTheme
                              ? Colors.transparent
                              : Colors.transparent,
                        ),
                      ),
                      BounceButton(
                        child: Icon(
                          Icons.person,
                          size: MediaQuery.of(context).size.height / 22,
                          color: widget.page == 4
                              ? Theme.of(context).accentColor
                              : isLoginColor,
                        ),
                        onTap: (){
                          if (!UserState.isPresent()) {
                            Utils.navigateToPage(context, JoinView(childPage: new ProfileWithAppBar()));
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Profilinizi görüntüleyebilmek için öncelikli üye girişi yapmalısınız."),
                                  duration: Duration(milliseconds: 2500),));
                          } else {
                          widget.pageController.jumpToPage(4);
                          }
                        },
                        height: MediaQuery.of(context).size.height / 17,
                        width: MediaQuery.of(context).size.width / 10,
                        duration: Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Provider.of<AppProvider>(context).theme ==
                              Constants.lightTheme
                              ? Colors.transparent
                              : Colors.transparent,
                        ),
                      ),
                      SizedBox(width: 7),
                    ],
                  ),
                  color: Theme.of(context).primaryColor,
                  shape: CircularNotchedRectangle(),
                );
              } else {
                return Center(
                  child: Indicator(),
                );
              }
            })


    );
  }
}
