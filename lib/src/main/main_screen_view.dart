import 'package:davetcim/shared/sessions/application_context.dart';
import 'package:davetcim/src/search/search_wihthout_appbar_view.dart';
import 'package:flutter/material.dart';
import 'package:davetcim/src/user_reservations/user_reservations_view.dart';
import 'package:davetcim/src/fav_products/favorite_screen.dart';
import 'package:davetcim/src/home/home_view.dart';
import 'package:davetcim/src/profile/profile_view.dart';

import '../../shared/sessions/user_basket_state.dart';
import '../../widgets/app_bar/app_bar_view.dart';
import '../../widgets/app_bar/bottom_app_bar.dart';
import '../../widgets/bounce_button.dart';
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
        appBar: AppBarMenu(pageName: 'Davetcim', isHomnePageIconVisible: false, isNotificationsIconVisible: true, isPopUpMenuActive: true),
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: onPageChanged,
          children: <Widget>[
            Home(),
            FavoriteScreen(),
            SearchWithoutAppBarScreen(),
          //  SearchScreen(),
            UserReservationsScreen(),
            Profile(),
          ],
        ),

        bottomNavigationBar: BottomAppBarMenu(page: _page, pageController: _pageController),
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        //floatingActionButton: AnimatedFab(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.redAccent,
          elevation: 4.0,
          child: BounceButton(
            child: Icon(
              Icons.search_sharp,
              size: MediaQuery.of(context).size.height / 20,
            ),
            onTap: (){
              _pageController.jumpToPage(2);
            },
            height: MediaQuery.of(context).size.height / 17,
            width: MediaQuery.of(context).size.width / 10,
            duration: Duration(milliseconds: 300),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.redAccent,
            ),
          ),

          /*Icon(
            Icons.search,
          ),*/
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
    UserBasketState.setAsNull();
    ApplicationContext.corporationReservation = null;
    ApplicationContext.reservationDetail = null;
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
