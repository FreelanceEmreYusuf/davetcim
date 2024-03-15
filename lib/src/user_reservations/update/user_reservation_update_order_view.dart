import 'package:davetcim/shared/enums/corporation_service_selection_enum.dart';
import 'package:davetcim/src/user_reservations/update/user_reservation_update_services_package_view.dart';
import 'package:davetcim/src/user_reservations/update/user_reservation_update_services_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../shared/dto/order_basket_dto.dart';
import '../../../shared/dto/reservation_detail_view_dto.dart';
import '../../../shared/utils/form_control.dart';
import '../../../shared/utils/utils.dart';
import '../../../widgets/app_bar/app_bar_view.dart';
import '../../select-orders/calender/calendar_view_model.dart';

class UserReservationUpdateOrderScreen extends StatefulWidget {
  @override
  _UserReservationUpdateOrderScreenState createState() => _UserReservationUpdateOrderScreenState();
  final ReservationDetailViewDto detailResponse;

  UserReservationUpdateOrderScreen(
      {Key key,
        @required this.detailResponse,
      })
      : super(key: key);

}

class _UserReservationUpdateOrderScreenState extends State<UserReservationUpdateOrderScreen>
    with AutomaticKeepAliveClientMixin<UserReservationUpdateOrderScreen> {
  static TextStyle kStyle =
      TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w500);

  int selectedSeatingArrangement = 0;
  int selectedInvitationIndex = 0;
  int selectedOrganizationIndex = 0;
  int _cardDivisionSize = 20;
  final TextEditingController personCountControl = new TextEditingController();
  final registerFormKey = GlobalKey <FormState> ();

  DateTime date = DateTime.now().toLocal();
  DateTime time = DateTime.now().toLocal();
  bool checkedValue = false;

  DateTime endTime = DateTime.now().toLocal().add(new Duration(hours: 2));
  bool hasDataTaken = false;

  // This shows a CupertinoModalPopup with a reasonable fixed height which hosts CupertinoDatePicker.
  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
              height: 216,
              padding: const EdgeInsets.only(top: 6.0),
              // The Bottom margin is provided to align the popup above the system navigation bar.
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              // Provide a background color for the popup.
              color: CupertinoColors.systemBackground.resolveFrom(context),
              // Use a SafeArea widget to avoid system overlaps.
              child: SafeArea(
                top: false,
                child: child,
              ),
            ));
  }

  @override
  void initState() {
    fillOrderViewParams();

  }

  void fillOrderViewParams() async {
    OrderViewModel rm = OrderViewModel();
    widget.detailResponse.invitationList = await rm.getInvitationIdentifiers(widget.detailResponse.corporateModel.corporationId);
    widget.detailResponse.sequenceOrderList = await rm.getSequenceOrderIdentifiers(widget.detailResponse.corporateModel.corporationId);

    for (int i = 0; i < widget.detailResponse.invitationList.length; i++) {
      if (widget.detailResponse.invitationList[i].text == widget.detailResponse.reservationModel.invitationType) {
        selectedInvitationIndex = i;
      }
    }
    for (int i = 0; i < widget.detailResponse.sequenceOrderList.length; i++) {
      if (widget.detailResponse.sequenceOrderList[i].text == widget.detailResponse.reservationModel.seatingArrangement) {
        selectedSeatingArrangement = i;
      }
    }
    personCountControl.text = widget.detailResponse.reservationModel.invitationCount.toString();

    setState(() {
      selectedInvitationIndex = selectedInvitationIndex;
      selectedSeatingArrangement = selectedSeatingArrangement;
      hasDataTaken = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (!hasDataTaken) {
      return Scaffold(appBar:
      AppBarMenu(pageName: "Salon Özellikleri", isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
          body: Padding(
              padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
              child: Center(child: CircularProgressIndicator())));
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: ()  {
          if (registerFormKey.currentState.validate()) {
            OrderBasketDto orderBasketModel = new OrderBasketDto(
                int.parse(personCountControl.text),
                widget.detailResponse.invitationList[selectedInvitationIndex].text,
                widget.detailResponse.sequenceOrderList[selectedSeatingArrangement].text);
            widget.detailResponse.orderBasketModel = orderBasketModel;
            if (widget.detailResponse.corporateModel.serviceSelection == CorporationServiceSelectionEnum.customerSelectsBoth
              || widget.detailResponse.corporateModel.serviceSelection == CorporationServiceSelectionEnum.customerSelectsCorporationPackage) {
              Utils.navigateToPage(context, UserReservationUpdateServicesPackageView(detailResponse: widget.detailResponse));
            } else {
              Utils.navigateToPage(context, UserReservationUpdateServicesScreen(detailResponse: widget.detailResponse));
            }
          }
        },
        label: const Text('Devam'),
        icon: const Icon(Icons.filter_list),
        backgroundColor: Colors.redAccent,
      ),
      appBar: AppBarMenu(pageName: "Salon Özellikleri", isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              GestureDetector(
                child: Card(
                  elevation: 3.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      CupertinoButton(
                        child: Text(
                          "Davet Türü",
                          style: kStyle,
                          textAlign: TextAlign.center,
                        ),
                        padding: EdgeInsetsDirectional.fromSTEB(
                            MediaQuery.of(context).size.height /
                                _cardDivisionSize,
                            MediaQuery.of(context).size.height /
                                _cardDivisionSize,
                            MediaQuery.of(context).size.height /
                                _cardDivisionSize,
                            MediaQuery.of(context).size.height /
                                _cardDivisionSize),
                      ),
                      Text(
                        widget.detailResponse.invitationList[selectedInvitationIndex].text,
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pop(context, widget.detailResponse.invitationList[selectedInvitationIndex]); // Seçilen öğeyi geri döndürür
                          },
                          child: Container(
                            height: 200.0,
                            child: CupertinoPicker(
                                itemExtent: 32.0,
                                onSelectedItemChanged: (int index) {
                                  setState(() {
                                    selectedInvitationIndex = index;
                                  });
                                },
                                children: new List<Widget>.generate(
                                    widget.detailResponse.invitationList.length, (int index) {
                                  return new Center(
                                    child: new Text(widget.detailResponse.invitationList[index].text),
                                  );
                                })),
                          ),
                        );
                      });
                },
              ),
              GestureDetector(
                child: Card(
                  elevation: 3.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      CupertinoButton(
                        child: Text(
                          "Oturma Düzeni",
                          style: kStyle,
                        ),
                        padding: EdgeInsetsDirectional.fromSTEB(
                            MediaQuery.of(context).size.height /
                                _cardDivisionSize,
                            MediaQuery.of(context).size.height /
                                _cardDivisionSize,
                            MediaQuery.of(context).size.height /
                                _cardDivisionSize,
                            MediaQuery.of(context).size.height /
                                _cardDivisionSize),
                      ),
                      Text(
                        widget.detailResponse.sequenceOrderList[selectedSeatingArrangement].text,
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pop(context, widget.detailResponse.sequenceOrderList[selectedSeatingArrangement]); // Seçilen öğeyi geri döndürür
                          },
                          child: Container(
                            height: 200.0,
                            child: CupertinoPicker(
                                itemExtent: 32.0,
                                onSelectedItemChanged: (int index) {
                                  setState(() {
                                    selectedSeatingArrangement = index;
                                  });
                                },
                                children: new List<Widget>.generate(
                                    widget.detailResponse.sequenceOrderList.length, (int index) {
                                  return new Center(
                                    child:
                                        new Text(widget.detailResponse.sequenceOrderList[index].text),
                                  );
                                })),
                          ),
                        );
                      });
                },
              ),
              Form(
                key: registerFormKey,
                child: Card(
                  elevation: 3.0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width / 20, 0, 0, 0),
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          hintText: "Davetli Sayısı gir..",
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.redAccent,
                          ),
                          hintStyle: TextStyle(
                            fontSize: 15.0,
                            color: Colors.redAccent,
                          ),
                        ),
                        validator: (value) {
                          String errorDesc = FormControlUtil.getErrorControl(FormControlUtil.getStringEmptyValueControl(value));
                          if (errorDesc != null && errorDesc.trim().length > 0) {
                            return errorDesc;
                          } else {
                            errorDesc = FormControlUtil.getMaxValueControl(int.parse(value), widget.detailResponse.corporateModel.maxPopulation,
                                "Bu salonun max kapasitesi ");
                            return errorDesc;
                          }
                        },
                        textAlignVertical: TextAlignVertical.center,
                        maxLines: 1,
                        keyboardType: TextInputType.number,
                        controller: personCountControl,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 15,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
