import 'package:davetcim/shared/helpers/corporate_helper.dart';
import 'package:davetcim/src/admin_corporate_panel/reservation/reservation_corporate_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../shared/models/combo_generic_model.dart';
import '../../../shared/models/corporation_model.dart';
import '../../../shared/models/reservation_model.dart';
import '../../../shared/sessions/user_basket_state.dart';
import '../../../shared/sessions/user_state.dart';
import '../../../shared/utils/utils.dart';
import '../../../widgets/app_bar/app_bar_view.dart';
import '../../../widgets/indicator.dart';
import '../../../widgets/on_error/somethingWentWrong.dart';
import '../../../widgets/reservation_corporate_card_widget.dart';
import '../../select-orders/calender/calendar_view_model.dart';
import '../other_user_reservation/search_user_box.dart';

class ReservationCorporateView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<ReservationCorporateView> {
  final registerFormKey = GlobalKey <FormState> ();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ReservationCorporateViewModel>(
        create: (_)=>ReservationCorporateViewModel(),
        builder: (context,child) => StreamBuilder<List<ReservationModel>>(
            stream: Provider.of<ReservationCorporateViewModel>(context, listen: false)
                .getOnlineReservationlist(UserState.corporationId),
            builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
              if (asyncSnapshot.hasError) {
                return SomethingWentWrongScreen();
              } else if (asyncSnapshot.hasData) {
                List<ReservationModel> reservationList = asyncSnapshot.data;
                return Scaffold(
                  floatingActionButton: FloatingActionButton.extended(
                    onPressed: () async {
                      OrderViewModel rm = OrderViewModel();
                      List<ComboGenericModel> organizationTypeList =
                      await rm.getOrganizationUniqueIdentifiers(UserState.corporationId);
                      List<ComboGenericModel> invitationList =
                      await rm.getInvitationIdentifiers(UserState.corporationId);
                      List<ComboGenericModel> sequenceOrderList =
                      await rm.getSequenceOrderIdentifiers(UserState.corporationId);

                      CorporateHelper corporationHelper = CorporateHelper();
                      CorporationModel corporationModel = await corporationHelper.getCorporate(UserState.corporationId);
                      UserBasketState.set(corporationModel, sequenceOrderList, invitationList, reservationList);

                      Utils.navigateToPage(context, SearchUserBox());
                    },
                    label: Text('Kullanıcı Adına Rezervasyon Oluştur', style: TextStyle(fontSize: 15), maxLines: 2),
                    icon: Icon(Icons.add_circle),
                    backgroundColor: Colors.redAccent,
                  ),
                  appBar: AppBarMenu(pageName: "Aktif Talepler Online", isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
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
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                      child: ListView(
                        children: <Widget>[
                          Divider(),
                          SizedBox(height: 10.0),
                          GridView.builder(
                            shrinkWrap: true,
                            primary: false,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              childAspectRatio: 1.0,
                              crossAxisSpacing: 0.0,
                              mainAxisSpacing: 5,
                              mainAxisExtent: MediaQuery.of(context).size.height / 4.7,
                            ),
                            itemCount: reservationList == null
                                ? 0
                                : reservationList.length,
                            itemBuilder: (BuildContext context, int index) {
                              ReservationModel item = reservationList[index];
                              return ReservationCorporateCardWidget(model: item);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
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

