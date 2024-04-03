import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../shared/models/region_model.dart';
import '../shared/sessions/organization_items_state.dart';
import '../shared/sessions/organization_type_state.dart';
import '../src/search/search_view_model.dart';
import 'filter_items/district_modal_content.dart';
import 'filter_items/organization_modal_content.dart';

class SoftFilterWidget extends StatefulWidget {

  static TextStyle kStyle =
  TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w500);

  @override
  State<SoftFilterWidget> createState() => _SoftFilterWidgetState();
}

class _SoftFilterWidgetState extends State<SoftFilterWidget> {
  List<RegionModel> regionList = OrganizationItemsState.regionModelList;

  static TextStyle kStyle =
  TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w500);

  int _cardDivisionSize = 40;
  int selectedRegion = 0;
  int selectedDistrict = 0;
  int selectedOrganizationIndex = 0;

  @override
  void initState() {
    firstInitialDistrict();
  }


  void firstInitialDistrict() async {
    regionList = OrganizationItemsState.regionModelList;
    if (regionList != null && regionList.length > 0) {
      SearchViewModel rm = SearchViewModel();
      districtList = await rm.fillDistrictlist(regionList[0].id);
      OrganizationTypeState.setDistrict(districtList);
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
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 3.0),
      child: ClipPath(
        clipper: BottomClipper(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 2.6,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/soft_filter_background.jpg'),
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
          child: Container(
            color: Colors.transparent,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.height /
                    _cardDivisionSize, MediaQuery.of(context).size.height /
                    _cardDivisionSize+5, MediaQuery.of(context).size.height /
                    _cardDivisionSize, 0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0), // Card'ı oval yapar
                  ),
                  color: Colors.white60,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
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
                                        MediaQuery.of(context).size.height / _cardDivisionSize,
                                        MediaQuery.of(context).size.height / _cardDivisionSize,
                                        MediaQuery.of(context).size.height / _cardDivisionSize,
                                        MediaQuery.of(context).size.height / _cardDivisionSize),
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
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height / 200,),
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child:  GestureDetector(
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
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height / 200,),
                              Expanded(
                                child:  GestureDetector(
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
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height / 100,),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.height / 25, 0, MediaQuery.of(context).size.height / 25, 0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      SearchViewModel rm = SearchViewModel();
                                      rm.goToFilterPageFromSoftFilter(context,
                                        regionList[selectedRegion].id.toString(),
                                        OrganizationTypeState.districtList,
                                        OrganizationTypeState.organizationTypeList,
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.blue, // Buton rengi
                                      onPrimary: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25), // Kenar yarıçapı
                                      ),
                                    ),
                                    child: Padding(
                                      //padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 24.0),
                                      padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 10, MediaQuery.of(context).size.height / 50, MediaQuery.of(context).size.width / 10, MediaQuery.of(context).size.height / 35),
                                      child: Text(
                                        'Filtrele', // Buton metni
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context).size.height / 35,
                                          letterSpacing: 1.0,
                                          fontFamily: 'RobotoMono',
                                        ),
                                      ),
                                    ),
                                  ),
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
            ),
          ),
        ),
      ),
    );
  }
}

class BottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 50); // Sol alt köşe
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 50); // Alt kenar
    path.lineTo(size.width, 0); // Sağ alt köşe
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
