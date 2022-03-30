import 'package:davetcim/src/search/cupertino.dart';
import 'package:davetcim/src/search/cupertino_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:davetcim/environments/const.dart';
import 'package:davetcim/util/foods.dart';
import 'package:davetcim/widgets/smooth_star_rating.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with AutomaticKeepAliveClientMixin<SearchScreen> {
  final TextEditingController _searchControl = new TextEditingController();

  static TextStyle kStyle =
      TextStyle(color: Colors.blue, fontWeight: FontWeight.w500);

  List<String> sehirlist = [
    "İSTANBUL",
    "ANKARA",
    "İZMİR",
    "ORDU",
  ];

  List<String> ilcelist = [
    "ESENLER",
    "TUZLA",
    "KAĞITHANE",
  ];

  List<Text> addlist(List<String> lists) {
    List<Text> manufacturers = [];
    lists.forEach((element) {
      manufacturers.add(Text(
        element,
        style: kStyle,
      ));
    });
    return manufacturers;
  }

  int _selectedValue = 0;
  int _selectedIndex = 0;
  int _selectedHour = 0, _selectedMinute = 0;
  int _changedNumber = 0, _selectedNumber = 1;
  void _showPicker(BuildContext ctx, List<String> list) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.7,
              child: CupertinoPicker(
                backgroundColor: Colors.white,
                itemExtent: 25,
                scrollController: FixedExtentScrollController(initialItem: 1),
                children: addlist(list),
                onSelectedItemChanged: (value) {
                  setState(() {
                    _selectedValue = value;
                  });
                },
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
      child: ListView(
        children: <Widget>[
          Container(
            child: Card(
              child: Column(
                children: [
                  Text(
                    "Normal Cupertino Picker",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      CupertinoButton(
                          child: Text("Select Color :"),
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
                                            _selectedIndex = index;
                                          });
                                        },
                                        children: new List<Widget>.generate(
                                            colors.length, (int index) {
                                          return new Center(
                                            child: new Text(colors[index]),
                                          );
                                        })),
                                  );
                                });
                          }),
                      Text(
                        colors[_selectedIndex],
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                  Text(
                    "MutiSelect Cupertino Picker",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      CupertinoButton(
                          child: Text("Select Time:"),
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
                                                  child:
                                                      new Text('${index + 1}'),
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
                                                  child:
                                                      new Text('${index + 1}'),
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
                  Text(
                    "Cupertino Picker with Actions",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      CupertinoButton(
                          child: Text("Select Number :"),
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
                                          child: Text("Cancel"),
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
                                                  child:
                                                      new Text('${index + 1}'),
                                                );
                                              })),
                                        ),
                                        CupertinoButton(
                                          child: Text("Ok"),
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
                  CupertinoButton(
                    child: Text('Şehir'),
                    onPressed: () => _showPicker(context, sehirlist),
                  ),
                  Text(sehirlist[_selectedValue]),
                  CupertinoButton(
                    child: Text('İlçe'),
                    onPressed: () => _showPicker(context, ilcelist),
                  ),
                  Text(ilcelist[_selectedValue]),
                ],
              ),
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
