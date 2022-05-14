import 'package:davetcim/src/search/search_view_model.dart';
import 'package:davetcim/src/widgets/app_bar/app_bar_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with AutomaticKeepAliveClientMixin<SearchScreen> {
  static TextStyle kStyle =
      TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w500);

  int selectedRegion = 0;
  int selectedDistrict = 0;
  int selectedSeatingArrangement = 0;
  int selectedInvitationIndex = 0;
  int selectedOrganizationIndex = 0;
  int _cardDivisionSize = 20;
  final TextEditingController _searchControl = new TextEditingController();

  DateTime date = DateTime.now().toLocal();
  DateTime time = DateTime.now().toLocal();
  DateTime endTime = DateTime.now().toLocal();

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
    callFillDistrict(regionList[selectedRegion].id);
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('Filtrele'),
        icon: const Icon(Icons.filter_list),
        backgroundColor: Colors.redAccent,
      ),
      appBar: AppBarMenu(pageName: 'Filtrele'),
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
                        invitationList[selectedInvitationIndex].name,
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
                                  invitationList.length, (int index) {
                                return new Center(
                                  child: new Text(invitationList[index].name),
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
              CupertinoPageScaffold(
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
                        organizationTypeList[selectedOrganizationIndex].name,
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
                                  organizationTypeList.length, (int index) {
                                return new Center(
                                  child: new Text(
                                      organizationTypeList[index].name),
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
                        sequenceOrderList[selectedSeatingArrangement].name,
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
                                  sequenceOrderList.length, (int index) {
                                return new Center(
                                  child:
                                      new Text(sequenceOrderList[index].name),
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
                          "İl",
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
                        regionList[selectedRegion].name,
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
                                print('Changed : ' + index.toString());
                                SearchViewModel rm = SearchViewModel();
                                setState(() {
                                  selectedRegion = index;
                                  selectedDistrict = 0;
                                });
                              },
                              children: new List<Widget>.generate(
                                  regionList.length, (int index) {
                                return new Center(
                                  child: new Text(regionList[index].name),
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
                          "İlçe",
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
                        districtList[selectedDistrict].name,
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
                                  selectedDistrict = index;
                                });
                              },
                              children: new List<Widget>.generate(
                                  districtList.length, (int index) {
                                return new Center(
                                  child: new Text(districtList[index].name),
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

  void callFillDistrict(int regionCode) async {
    SearchViewModel rm = SearchViewModel();
    districtList = await rm.fillDistrictlist(regionCode);
    setState(() {
      districtList = districtList;
    });
  }

  @override
  bool get wantKeepAlive => true;
}
