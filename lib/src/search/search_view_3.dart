import 'package:davetcim/src/search/search_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:davetcim/environments/const.dart';
import 'package:davetcim/util/foods.dart';
import 'package:davetcim/widgets/smooth_star_rating.dart';
/*
class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with AutomaticKeepAliveClientMixin<SearchScreen> {
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
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: Card(
                    elevation: 5,
                    margin: EdgeInsets.all(5),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(8), // if you need this
                      side: BorderSide(
                        color: Colors.red.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Organizasyon Filtrele",
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.w600,
                            fontSize: 22,
                            wordSpacing: 2),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Card(
                  child: Row(
                    children: <Widget>[
                      CupertinoButton(
                          child: Text(
                            "Şehir Seçiniz:",
                            style: kStyle,
                            textAlign: TextAlign.center,
                          ),
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
                Card(
                  child: Row(
                    children: <Widget>[
                      CupertinoButton(
                          child: Text(
                            "Select Time:",
                            style: kStyle,
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    height: 200.0,
                                    color: Colors.white,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                          child: CupertinoPicker(
                                              scrollController:
                                                  new FixedExtentScrollController(
                                                initialItem: _selectedHour,
                                              ),
                                              itemExtent: 32.0,
                                              backgroundColor: Colors.white,
                                              onSelectedItemChanged:
                                                  (int index) {
                                                setState(() {
                                                  _selectedHour = index;
                                                });
                                              },
                                              children:
                                                  new List<Widget>.generate(24,
                                                      (int index) {
                                                return new Center(
                                                  child: new Text(
                                                    '${index + 1}',
                                                    style: kStyle,
                                                  ),
                                                );
                                              })),
                                        ),
                                        Expanded(
                                          child: CupertinoPicker(
                                              scrollController:
                                                  new FixedExtentScrollController(
                                                initialItem: _selectedMinute,
                                              ),
                                              itemExtent: 32.0,
                                              backgroundColor: Colors.white,
                                              onSelectedItemChanged:
                                                  (int index) {
                                                setState(() {
                                                  _selectedMinute = index;
                                                });
                                              },
                                              children:
                                                  new List<Widget>.generate(60,
                                                      (int index) {
                                                return new Center(
                                                  child: new Text(
                                                      '${index + 1}',
                                                      style: kStyle),
                                                );
                                              })),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          }),
                      Text(
                        '${_selectedHour + 1}:${_selectedMinute + 1}',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ],
                  ),
                ),
                Card(
                  child: Row(
                    children: <Widget>[
                      CupertinoButton(
                          child: Text(
                            "Select Number :",
                            style: kStyle,
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    height: 200.0,
                                    color: Colors.white,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        CupertinoButton(
                                          child: Text("Cancel", style: kStyle),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                        Expanded(
                                          child: CupertinoPicker(
                                              scrollController:
                                                  new FixedExtentScrollController(
                                                initialItem: _selectedNumber,
                                              ),
                                              itemExtent: 32.0,
                                              backgroundColor: Colors.white,
                                              onSelectedItemChanged:
                                                  (int index) {
                                                _changedNumber = index;
                                              },
                                              children:
                                                  new List<Widget>.generate(100,
                                                      (int index) {
                                                return new Center(
                                                  child: new Text(
                                                      '${index + 1}',
                                                      style: kStyle),
                                                );
                                              })),
                                        ),
                                        CupertinoButton(
                                          child: Text("Ok", style: kStyle),
                                          onPressed: () {
                                            setState(() {
                                              _selectedNumber = _changedNumber;
                                            });
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          }),
                      Text(
                        '${_selectedNumber + 1}',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.0),
          Card(
            elevation: 6.0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              child: TextField(
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
                  hintText: "Search..",
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  hintStyle: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                ),
                maxLines: 1,
                controller: _searchControl,
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            primary: false,
            physics: NeverScrollableScrollPhysics(),
            itemCount: foods == null ? 0 : foods.length,
            itemBuilder: (BuildContext context, int index) {
              Map food = foods[index];
              return ListTile(
                title: Text(
                  "${food['name']}",
                  style: TextStyle(
//                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                leading: CircleAvatar(
                  radius: 25.0,
                  backgroundImage: AssetImage(
                    "${food['img']}",
                  ),
                ),
                trailing: Text(r"$10"),
                subtitle: Row(
                  children: <Widget>[
                    SmoothStarRating(
                      starCount: 1,
                      color: Constants.ratingBG,
                      allowHalfRating: true,
                      rating: 5.0,
                      size: 12.0,
                    ),
                    SizedBox(width: 6.0),
                    Text(
                      "5.0 (23 Reviews)",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                onTap: () {},
              );
            },
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
*/