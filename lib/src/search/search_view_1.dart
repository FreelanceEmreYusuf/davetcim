import 'package:davetcim/src/search/search_view_model.dart';
import 'package:davetcim/widgets/animated_fab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:davetcim/environments/const.dart';
import 'package:davetcim/util/foods.dart';
import 'package:davetcim/widgets/smooth_star_rating.dart';

class SearchScreen1 extends StatefulWidget {
  @override
  _SearchScreen1State createState() => _SearchScreen1State();
}

class _SearchScreen1State extends State<SearchScreen1>
    with AutomaticKeepAliveClientMixin<SearchScreen1> {
  final TextEditingController _searchControl = new TextEditingController();

  static TextStyle kStyle =
      TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w500);

  int _selectedCountry = 0;
  int _selectedDistrict = 0;
  int _selectedHour = 0, _selectedMinute = 0;
  int _changedNumber = 0, _selectedNumber = 1;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
      child: ListView(
        children: <Widget>[
          Container(
            child: Column(
              children: [
                Card(
                  child: Row(
                    children: <Widget>[
                      CupertinoButton(
                          child: Text(
                            "Şehir Seçiniz:",
                            style: kStyle,
                            textAlign: TextAlign.center,
                          ),
                          padding: EdgeInsetsDirectional.fromSTEB(
                              MediaQuery.of(context).size.height / 12,
                              MediaQuery.of(context).size.height / 12,
                              MediaQuery.of(context).size.height / 12,
                              MediaQuery.of(context).size.height / 12),
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    height: 200.0,
                                    child: CupertinoPicker(
                                        itemExtent: 32.0,
                                        onSelectedItemChanged: (int index) {
                                          setState(() {
                                            _selectedCountry = index;
                                          });
                                        },
                                        children: new List<Widget>.generate(
                                            country.length, (int index) {
                                          return new Center(
                                            child: new Text(country[index],
                                                style: kStyle),
                                          );
                                        })),
                                  );
                                });
                          }),
                      Text(
                        country[_selectedCountry],
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
                Card(
                  child: Row(
                    children: <Widget>[
                      CupertinoButton(
                          child: Text(
                            "İlçe Seçiniz:",
                            style: kStyle,
                          ),
                          padding: EdgeInsetsDirectional.fromSTEB(
                              MediaQuery.of(context).size.height / 12,
                              MediaQuery.of(context).size.height / 12,
                              MediaQuery.of(context).size.height / 12,
                              MediaQuery.of(context).size.height / 12),
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    height: 200.0,
                                    child: CupertinoPicker(
                                        itemExtent: 32.0,
                                        onSelectedItemChanged: (int index) {
                                          setState(() {
                                            _selectedDistrict = index;
                                          });
                                        },
                                        children: new List<Widget>.generate(
                                            district.length, (int index) {
                                          return new Center(
                                            child: new Text(district[index],
                                                style: kStyle),
                                          );
                                        })),
                                  );
                                });
                          }),
                      Text(
                        district[_selectedDistrict],
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  child: FloatingActionButton(
                    child: Icon(Icons.navigate_next_outlined),
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                    onPressed: () => {},
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.0),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
