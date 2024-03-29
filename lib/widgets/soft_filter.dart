import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../shared/models/organization_type_model.dart';
import '../shared/models/region_model.dart';
import '../shared/sessions/organization_items_state.dart';
import '../src/search/search_view_model.dart';

class SoftFilterWidget extends StatefulWidget {

  static TextStyle kStyle =
  TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w500);

  @override
  State<SoftFilterWidget> createState() => _SoftFilterWidgetState();
}

class _SoftFilterWidgetState extends State<SoftFilterWidget> {
  List<RegionModel> regionList = OrganizationItemsState.regionModelList;
  List<OrganizationTypeModel> organizationTypeList = OrganizationItemsState.organizationTypeList;

  static TextStyle kStyle =
  TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w500);

  int _cardDivisionSize = 40;

  int selectedRegion = 0;

  int selectedDistrict = 0;

  int selectedOrganizationIndex = 0;

  @override
  void initState() {
    super.initState();
    firstInitialDistrict();
  }

  void firstInitialDistrict() async {
    regionList = OrganizationItemsState.regionModelList;
    if (regionList != null && regionList.length > 0) {
      SearchViewModel rm = SearchViewModel();
      districtList = await rm.fillDistrictlist(regionList[0].id);
    } else {
      firstInitialDistrict();
    }
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
                                      organizationTypeList[selectedOrganizationIndex].name,
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
                                        Navigator.pop(context, organizationTypeList[selectedOrganizationIndex]); // Seçilen öğeyi geri döndürür
                                      },
                                      child: Container(
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
                                      ),
                                    );
                                  });
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
                                                  onSelectedItemChanged: (int index) async {
                                                    SearchViewModel rm = SearchViewModel();
                                                    districtList = await rm.fillDistrictlist(regionList[index].id);
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
                                            districtList[selectedDistrict].name,
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
                                            Navigator.pop(context, districtList[selectedDistrict]); // Seçilen öğeyi geri döndürür
                                          },
                                          child: Container(
                                            height: 200.0,
                                            child: CupertinoPicker(
                                              itemExtent: 32.0,
                                              onSelectedItemChanged: (int index) {
                                                setState(() {
                                                  selectedDistrict = index;
                                                });
                                              },
                                              children: List<Widget>.generate(
                                                  districtList.length, (int index) {
                                                return Center(
                                                  child: Text(districtList[index].name),
                                                );
                                              }
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
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
                                        districtList[selectedDistrict].id.toString(),
                                        organizationTypeList[selectedOrganizationIndex].id.toString(),
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
