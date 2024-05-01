import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../providers/app_provider.dart';
import '../../../shared/environments/const.dart';
import '../../../shared/models/reservation_model.dart';
import '../../../shared/sessions/reservation_edit_state.dart';
import '../../../shared/utils/utils.dart';
import '../../../widgets/app_bar/app_bar_view.dart';
import '../../../widgets/bounce_button.dart';
import '../../../widgets/carousel_corporate_admin_calender_widget.dart';
import '../AdminCorporatePanel.dart';
import 'all_reservation_corporate_view.dart';
import 'all_reservation_corporate_view_model.dart';

class AllReservationLandingView extends StatefulWidget {
  final int pageIndex;
  AllReservationLandingView({
    Key key,
    this.pageIndex,
  }) : super(key: key);
  @override
  _AllReservationLandingViewState createState() => _AllReservationLandingViewState();
}

class _AllReservationLandingViewState extends State<AllReservationLandingView>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  List<ReservationModel> reservationList = [];
  final registerFormKey = GlobalKey <FormState> ();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, initialIndex: 0, length: 2);
    _tabController.index = widget.pageIndex;
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(
        title: FittedBox(
          child: BounceButton(
            child: Text(
              "Rezervasyon Geçmişi",
              style: TextStyle(
                fontSize: 20,
                color: Color(0xffffffff),
                fontWeight: FontWeight.w700,
                fontFamily: 'RobotoMono',
              ),
            ),
            onTap: (){

            },
            duration: Duration(milliseconds: 300),
            decoration: BoxDecoration(
                color: Provider.of<AppProvider>(context).theme ==
                    Constants.lightTheme
                    ? Colors.redAccent
                    : Constants.darkAccent,
                borderRadius: BorderRadius.circular(50)
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_backspace,
          ),
          onPressed: () => {
            Utils.navigateToPage(context, AdminCorporatePanelPage()),
          },
        ),
        elevation: 8.0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white38,
          labelStyle: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w800,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w800,
          ),
          tabs: <Widget>[
            FittedBox(
              child: Tab(
                text: "Takvim",
              ),
            ),
            FittedBox(
                child: Tab(
                  text: "Liste",
                )
            ),
          ],
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/filter_page_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        foregroundDecoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.1), // Filtre yoğunluğu
            ],
          ),
        ),
        child: TabBarView(
          controller: _tabController,
          children: <Widget>[
            CalenderCorporateAdminCarousel(),
            AllReservationCorporateView(),
          ],
        ),
      ),
    );
  }
}
