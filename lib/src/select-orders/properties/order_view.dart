import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../shared/dto/basket_user_dto.dart';
import '../../../shared/dto/order_basket_dto.dart';
import '../../../shared/utils/form_control.dart';
import '../../../shared/utils/utils.dart';
import '../../../widgets/app_bar/app_bar_view.dart';
import '../services/services_view.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
  final BasketUserDto basketModel;

  OrderScreen(
      {Key key,
        @required this.basketModel,
      })
      : super(key: key);

}

class _OrderScreenState extends State<OrderScreen>
    with AutomaticKeepAliveClientMixin<OrderScreen> {
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
  Widget build(BuildContext context) {
    super.build(context);

    if (widget.basketModel.sequenceOrderList.isEmpty ||
      widget.basketModel.invitationList.isEmpty) {
      return Scaffold(appBar:
      AppBarMenu(pageName: "Salon Özellikleri", isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
          body: Padding(
              padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
              child: Center(child: CircularProgressIndicator())));
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (registerFormKey.currentState.validate()) {
            OrderBasketDto orderBasketModel = new OrderBasketDto(
                int.parse(personCountControl.text),
                widget.basketModel.invitationList[selectedInvitationIndex].text,
                widget.basketModel.sequenceOrderList[selectedSeatingArrangement].text);
            widget.basketModel.orderBasketModel = orderBasketModel;
            Utils.navigateToPage(context, ServicesScreen(basketModel: widget.basketModel));
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
                        widget.basketModel.invitationList[selectedInvitationIndex].text,
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
                        return Container(
                          height: 200.0,
                          child: CupertinoPicker(
                              itemExtent: 32.0,
                              onSelectedItemChanged: (int index) {
                                setState(() {
                                  selectedInvitationIndex = index;
                                });
                              },
                              children: new List<Widget>.generate(
                                  widget.basketModel.invitationList.length, (int index) {
                                return new Center(
                                  child: new Text(widget.basketModel.invitationList[index].text),
                                );
                              })),
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
                        widget.basketModel.sequenceOrderList[selectedSeatingArrangement].text,
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
                        return Container(
                          height: 200.0,
                          child: CupertinoPicker(
                              itemExtent: 32.0,
                              onSelectedItemChanged: (int index) {
                                setState(() {
                                  selectedSeatingArrangement = index;
                                });
                              },
                              children: new List<Widget>.generate(
                                  widget.basketModel.sequenceOrderList.length, (int index) {
                                return new Center(
                                  child:
                                      new Text(widget.basketModel.sequenceOrderList[index].text),
                                );
                              })),
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
                            errorDesc = FormControlUtil.getMaxValueControl(int.parse(value), widget.basketModel.maxPopulation,
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
