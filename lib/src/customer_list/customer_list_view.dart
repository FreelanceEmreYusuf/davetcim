import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davetcim/shared/environments/const.dart';
import 'package:davetcim/shared/utils/utils.dart';
import 'package:flutter/material.dart';

void main() => runApp(CustomerListScreen());

class CustomerListScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MyHomePage(title: 'Davetcim');
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController editingController = TextEditingController();
  List<dynamic> filteredCategoryItem;

  List<dynamic> listCustomers = [];
  // ignore: deprecated_member_use
  var items = List();

  @override
  void initState() {
    getCustomers();
    super.initState();
  }

  getCustomers() async {
    CollectionReference collRef = Utils.getCollectionRef(Constants.customerDB);
    var obj = await collRef.get();
    listCustomers = obj.docs;
  }

  static List<dynamic> filterDynamicLists(
      List<dynamic> codeCategory, String propertyType, String propertyValue) {
    List<dynamic> response = [];

    codeCategory.forEach((obj) {
      if (obj["$propertyType"].toString() == propertyValue) {
        response.add(obj);
      }
    });

    return response;
  }

  void filterSearchResults(String query) {
    // ignore: deprecated_member_use
    List<String> dummySearchList = List<String>();
    listCustomers.forEach((element) {
      dummySearchList.add(element['username']);
    });

    if (query.isNotEmpty) {
      // ignore: deprecated_member_use
      List<String> dummyListData = List<String>();
      dummySearchList.forEach((item) {
        if (item.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextField(
                onChanged: (value) {
                  filterSearchResults(value);
                },
                controller: editingController,
                decoration: InputDecoration(
                    labelText: "Üye Ara",
                    hintText: "Üyenin kullanıcı adı",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)))),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  //    Map cat = items[index];
                  return Card(
                    shadowColor: Colors.blueGrey,
                    elevation: 5,
                    child: ListTile(
                      onTap: () {
                        /*
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              filteredCategoryItem = filterDynamicLists(
                                  listCustomers, "username", '${items[index]}');
                              return FilteredCustomersScreenState(
                                  filteredCategoryItem[0]["id"]);
                            },
                          ),
                        );*/
                      },
                      title: Text('${items[index]}'),
                      subtitle: Text('Admin'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
