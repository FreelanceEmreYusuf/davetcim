import 'package:davetcim/shared/sessions/application_session.dart';
import 'package:davetcim/src/search/search_wihthout_appbar_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:davetcim/screens/cart.dart';
import 'package:davetcim/screens/favorite_screen.dart';
import 'package:davetcim/src/home/home_view.dart';
import 'package:davetcim/src/profile/profile_view.dart';
import 'package:davetcim/widgets/badge.dart';

import '../../widgets/app_bar/app_bar_view.dart';
import '../search/search_view.dart';
import 'main_screen_view_model.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController _pageController;
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    MainScreenViewModel mdl = MainScreenViewModel();
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar: AppBarMenu(pageName: 'Davetçim'),
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: onPageChanged,
          children: <Widget>[
            Home(),
            FavoriteScreen(),
            SearchWithoutAppBarScreen(),
          //  SearchScreen(),
            CartScreen(),
            Profile(),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
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
                color: _page == 0
                    ? Theme.of(context).accentColor
                    : Theme.of(context).textTheme.caption.color,
                onPressed: () => _pageController.jumpToPage(0),
              ),
              IconButton(
                icon: Icon(
                  Icons.favorite,
                  size: 24.0,
                ),
                color: _page == 1
                    ? Theme.of(context).accentColor
                    : Theme.of(context).textTheme.caption.color,
                onPressed: () => _pageController.jumpToPage(1),
              ),
              IconButton(
                icon: Icon(
                  Icons.search,
                  size: 24.0,
                  color: Theme.of(context).primaryColor,
                ),
                color: _page == 2
                    ? Theme.of(context).accentColor
                    : Theme.of(context).textTheme.caption.color,
                onPressed: () => _pageController.jumpToPage(2),
              ),
              IconButton(
                icon: IconBadge(
                  icon: Icons.shopping_cart,
                  size: 24.0,
                ),
                color: _page == 3
                    ? Theme.of(context).accentColor
                    : Theme.of(context).textTheme.caption.color,
                onPressed: () => _pageController.jumpToPage(3),
              ),
              IconButton(
                  icon: Icon(
                    Icons.person,
                    size: 24.0,
                  ),
                  color: _page == 4
                      ? Theme.of(context).accentColor
                      : Theme.of(context).textTheme.caption.color,
                  onPressed: () => {
                        if (ApplicationSession.userSession == null)
                          {
                            mdl.navigateToLogin(context),
                          }
                        else
                          {
                            _pageController.jumpToPage(4),
                          }
                      }),
              SizedBox(width: 7),
            ],
          ),
          color: Theme.of(context).primaryColor,
          shape: CircularNotchedRectangle(),
        ),
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        //floatingActionButton: AnimatedFab(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.redAccent,
          elevation: 4.0,
          child: Icon(
            Icons.search,
          ),
          onPressed: () => _pageController.jumpToPage(2),
        ),
      ),
    );
  }

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }
}
