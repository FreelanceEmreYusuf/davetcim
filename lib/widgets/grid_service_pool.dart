import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../shared/environments/const.dart';
import '../shared/models/service_pool_model.dart';

class GridServicePool extends StatefulWidget {
  final ServicePoolModel servicePoolModel;

  GridServicePool({
    Key key,
    @required this.servicePoolModel,
  }) : super(key: key);

  @override
  _GridServicePoolState createState() =>
      _GridServicePoolState();
}

class _GridServicePoolState
    extends State<GridServicePool> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ListView(
        shrinkWrap: true,
        primary: false,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height / 12,
            child: Text(widget.servicePoolModel.serviceName, style: TextStyle(fontSize: 20)),
          ),
          SizedBox(height: 10.0),
          Container(
              height: 20,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: RaisedButton(
                textColor: Colors.white,
                color: Constants.darkAccent,
                child: Text('Ekle'),
                onPressed: () async {
                },
              )),
          SizedBox(height: 10.0),
          Container(
              height: 20,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: RaisedButton(
                textColor: Colors.white,
                color: Constants.darkAccent,
                child: Text('Sil'),
                onPressed: () async {
                },
              )),
          Padding(
            padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
          ),
        ],
      ),
      onTap: () {

      },
    );
  }


}
