import 'package:davetcim/src/search/search_view_model.dart';
import 'package:davetcim/widgets/filter_items/district_modal_content.dart';
import 'package:davetcim/widgets/filter_items/sequence_order_modal_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../shared/sessions/organization_type_state.dart';
import '../../widgets/filter_items/invitation_modal_content.dart';
import '../../widgets/filter_items/organization_modal_content.dart';

class SearchWithoutAppBarScreen extends StatefulWidget {
  @override
  _SearchWithoutAppBarScreenState createState() => _SearchWithoutAppBarScreenState();
}

class _SearchWithoutAppBarScreenState extends State<SearchWithoutAppBarScreen>
    with AutomaticKeepAliveClientMixin<SearchWithoutAppBarScreen> {
  static TextStyle kStyle =
  TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w500);

  int selectedRegion = 0;
  int selectedDistrict = 0;
  int selectedSeatingArrangement = 0;
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
  void initState() {
    firstInitialDistrict();
  }

  void firstInitialDistrict() async {
    if (regionList != null && regionList.length > 0) {
      SearchViewModel rm = SearchViewModel();
      districtList = await rm.fillDistrictlist(regionList[0].id);
      OrganizationTypeState.setDistrict(districtList);

      setState(() {
        districtList = districtList;
      });
    } else {
      firstInitialDistrict();
    }
  }

  void showOrganizationModalSheet() {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      builder: (BuildContext context) {
        return Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 100,),
                OrganizationModalContent(),
                SizedBox(height: MediaQuery.of(context).size.height / 15,),
              ],
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height / 150,
              right: MediaQuery.of(context).size.width / 150,
              left: MediaQuery.of(context).size.width / 150,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                  ),
                  onPressed: ()  {
                    setState(() {
                      regionList = regionList;
                    });
                    Navigator.pop(context);
                  },
                  child: Text(
                    "EKLE".toUpperCase(),
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void showInvitationModalSheet() {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      builder: (BuildContext context) {
        return Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 100,),
                InvitationModalContent(),
                SizedBox(height: MediaQuery.of(context).size.height / 15,),
              ],
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height / 150,
              right: MediaQuery.of(context).size.width / 150,
              left: MediaQuery.of(context).size.width / 150,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: ()  {
                    setState(() {
                      regionList = regionList;
                    });
                    Navigator.pop(context);
                  },
                  child: Text(
                    "EKLE".toUpperCase(),
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void showSequenceOrderModalSheet() {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      builder: (BuildContext context) {
        return Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 100,),
                SequenceOrderModalContent(),
                SizedBox(height: MediaQuery.of(context).size.height / 15,),
              ],
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height / 150,
              right: MediaQuery.of(context).size.width / 150,
              left: MediaQuery.of(context).size.width / 150,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: ()  {
                    setState(() {
                      regionList = regionList;
                    });
                    Navigator.pop(context);
                  },
                  child: Text(
                    "EKLE".toUpperCase(),
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void showDistrictModalSheet() {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      builder: (BuildContext context) {
        return Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 100,),
                DistrictModalContent(),
                SizedBox(height: MediaQuery.of(context).size.height / 15,),
              ],
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height / 150,
              right: MediaQuery.of(context).size.width / 150,
              left: MediaQuery.of(context).size.width / 150,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                onPressed: ()  {
                  setState(() {
                    regionList = regionList;
                  });
                  Navigator.pop(context);
                },
                child: Text(
                  "EKLE".toUpperCase(),
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
            ),
              ),),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          SearchViewModel rm = SearchViewModel();
          rm.goToFilterPage(context, regionList[selectedRegion].id.toString(),
              OrganizationTypeState.districtList,
              OrganizationTypeState.invitationTypeList,
              OrganizationTypeState.organizationTypeList,
              OrganizationTypeState.sequenceOrderList,
              _searchControl.text,
              checkedValue,
              date,
              time,
              endTime);
        },
        label: const Text('Filtrele'),
        icon: const Icon(Icons.filter_list),
        backgroundColor: Colors.redAccent,
        heroTag: 'uniqueTagForFilterButton',
      ),
      body: Container(
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
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  color: Colors.white70,
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)), // Car
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
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
                                    Expanded(
                                      child: Text(
                                        OrganizationTypeState.getInvitationSelectionText(),
                                        style: TextStyle(fontSize: 18.0),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                showInvitationModalSheet();
                              },
                            ),
                            Card(
                              elevation: 3.0,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
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
                                      //color: Colors.black,
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(10.0),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
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
                            Card(
                                elevation: 3.0,
                                child: CheckboxListTile(
                                  title: Text("Tarih filtrelensin mi?"),
                                  value: checkedValue,
                                  onChanged: (newValue) {
                                    setState(() {
                                      checkedValue = newValue;
                                    });
                                  },
                                  controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                                )
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
                                              Expanded(
                                                child: Text(
                                                  '${date.day}.${date.month}.${date.year}',
                                                  style: const TextStyle(
                                                    fontSize: 18.0,
                                                    //color: Colors.black,
                                                  ),
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
                                    Expanded(
                                      child: Text(
                                        OrganizationTypeState.getOrganizationSelectionText(),
                                        style: TextStyle(fontSize: 18.0),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                showOrganizationModalSheet();
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
                                    Expanded(
                                      child: Text(
                                        OrganizationTypeState.getSequenceOrderSelectionText(),
                                        style: TextStyle(fontSize: 18.0),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                showSequenceOrderModalSheet();
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
                                    Expanded(
                                      child: Text(
                                        regionList[selectedRegion].name,
                                        style: TextStyle(fontSize: 18.0),
                                      ),
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
                                          Navigator.pop(context, regionList[selectedRegion]); // Seçilen öğeyi geri döndürür
                                        },
                                        child: Container(
                                          height: 200.0,
                                          child: CupertinoPicker(
                                              itemExtent: 32.0,
                                              scrollController: FixedExtentScrollController(initialItem: selectedRegion),
                                              onSelectedItemChanged: (int index) async {
                                                SearchViewModel rm = SearchViewModel();
                                                districtList = await rm.fillDistrictlist(regionList[index].id);
                                                OrganizationTypeState.districtList = districtList;
                                                setState(() {
                                                  selectedRegion = index;
                                                  districtList = districtList;
                                                  selectedDistrict = 0;
                                                });
                                              },
                                              children: new List<Widget>.generate(
                                                  regionList.length, (int index) {
                                                return new Center(
                                                  child: new Text(regionList[index].name),
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
                                    Expanded(
                                      child: Text(
                                          OrganizationTypeState.getDistrictSelectionText(),
                                        style: TextStyle(fontSize: 18.0),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                showDistrictModalSheet();
                              },
                            ),
                      ],
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
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
