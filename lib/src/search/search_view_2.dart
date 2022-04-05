import 'package:davetcim/src/search/search_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchScreen2 extends StatefulWidget {
  @override
  _SearchScreen2State createState() => _SearchScreen2State();
}

class _SearchScreen2State extends State<SearchScreen2>
    with AutomaticKeepAliveClientMixin<SearchScreen2> {
  static TextStyle kStyle =
      TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w500);

  int _selectedCountry = 0;
  int _selectedDistrict = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
        },
        label: const Text('İleri fasdad'),
        icon: const Icon(Icons.navigate_next),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
            SizedBox(
              height: MediaQuery.of(context).size.height / 15,
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
