import 'package:davetcim/screens/details_for_search.dart';
import 'package:flutter/material.dart';

class StorageGridProduct extends StatelessWidget {
  final int id;
  final String name;
  final String surname;
  final String gsm;
  final String email;
  final Widget childPage;

  StorageGridProduct({
    Key key,
    @required this.id,
    @required this.name,
    @required this.surname,
    @required this.gsm,
    @required this.email,
    this.childPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ListView(
        shrinkWrap: true,
        primary: false,
        children: <Widget>[
          Stack(
            children: <Widget>[],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 2.0, top: 8.0),
            child: Center(
              child: Text(
                "$surname",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w900,
                ),
                maxLines: 2,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
          ),
        ],
      ),
      onTap: () {
        /*Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return this.childPage == null
                  ? ProductDetailsForSearch(
                      id, name, surname, gsm, email, childPage)
                  : this.childPage;
            },
          ),
        );*/
      },
    );
  }
}
