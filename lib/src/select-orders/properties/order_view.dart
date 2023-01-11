import 'package:davetcim/shared/models/combo_generic_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../widgets/app_bar/app_bar_view.dart';
import '../properties/order_view_model.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
  final int corporationId;
  final List<ComboGenericModel> organizationTypeList;
  final List<ComboGenericModel> sequenceOrderList;
  final List<ComboGenericModel> invitationList;

  OrderScreen(
      {Key key,
        @required this.corporationId,
        @required this.organizationTypeList,
        @required this.sequenceOrderList,
        @required this.invitationList,
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
  final TextEditingController _searchControl = new TextEditingController();

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


    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
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
                        widget.invitationList[selectedInvitationIndex].text,
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
                                  widget.invitationList.length, (int index) {
                                return new Center(
                                  child: new Text(widget.invitationList[index].text),
                                );
                              })),
                        );
                      });
                },
              ),
              Card(
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
                    child: TextField(
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
                      textAlignVertical: TextAlignVertical.center,
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      controller: _searchControl,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: checkedValue,
                child: CupertinoPageScaffold(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            _showDialog(
                              CupertinoDatePicker(
                                initialDateTime: date,
                                mode: CupertinoDatePickerMode.date,
                                use24hFormat: true,
                                // This is called when the user changes the date.
                                onDateTimeChanged: (DateTime newDate) {
                                  setState(() => date = newDate);
                                },
                              ),
                            );
                          },
                          child: Card(
                            elevation: 3.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                CupertinoButton(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      MediaQuery.of(context).size.height /
                                          _cardDivisionSize,
                                      MediaQuery.of(context).size.height /
                                          _cardDivisionSize,
                                      MediaQuery.of(context).size.height /
                                          _cardDivisionSize,
                                      MediaQuery.of(context).size.height /
                                          _cardDivisionSize),
                                  child: Text(
                                    'Tarih',
                                    style: kStyle,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Text(
                                  '${date.month}-${date.day}-${date.year}',
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _showDialog(
                              CupertinoDatePicker(
                                initialDateTime: time,
                                mode: CupertinoDatePickerMode.time,
                                use24hFormat: true,
                                // This is called when the user changes the time.
                                onDateTimeChanged: (DateTime newTime) {
                                  setState(() => time = newTime);
                                },
                              ),
                            );
                          },
                          child: Card(
                            elevation: 3.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                CupertinoButton(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      MediaQuery.of(context).size.height /
                                          _cardDivisionSize,
                                      MediaQuery.of(context).size.height /
                                          _cardDivisionSize,
                                      MediaQuery.of(context).size.height /
                                          _cardDivisionSize,
                                      MediaQuery.of(context).size.height /
                                          _cardDivisionSize),
                                  child: Text(
                                    'Başlangıç Saati',
                                    style: kStyle,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Text(
                                  '${time.hour}:${time.minute}',
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _showDialog(
                              CupertinoDatePicker(
                                initialDateTime: endTime,
                                mode: CupertinoDatePickerMode.time,
                                use24hFormat: true,
                                // This is called when the user changes the time.
                                onDateTimeChanged: (DateTime newTime) {
                                  setState(() => endTime = newTime);
                                },
                              ),
                            );
                          },
                          child: Card(
                            elevation: 3.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                CupertinoButton(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      MediaQuery.of(context).size.height /
                                          _cardDivisionSize,
                                      MediaQuery.of(context).size.height /
                                          _cardDivisionSize,
                                      MediaQuery.of(context).size.height /
                                          _cardDivisionSize,
                                      MediaQuery.of(context).size.height /
                                          _cardDivisionSize),
                                  child: Text(
                                    'Bitiş Saati',
                                    style: kStyle,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Text(
                                  '${endTime.hour}:${endTime.minute}',
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                child: Card(
                  elevation: 3.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      CupertinoButton(
                        child: Text(
                          "Mekan Türü",
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
                        widget.organizationTypeList[selectedOrganizationIndex].text,
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
                                  selectedOrganizationIndex = index;
                                });
                              },
                              children: new List<Widget>.generate(
                                  widget.organizationTypeList.length, (int index) {
                                return new Center(
                                  child: new Text(
                                      widget.organizationTypeList[index].text),
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
                        widget.sequenceOrderList[selectedSeatingArrangement].text,
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
                                  widget.sequenceOrderList.length, (int index) {
                                return new Center(
                                  child:
                                      new Text(widget.sequenceOrderList[index].text),
                                );
                              })),
                        );
                      });
                },
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
