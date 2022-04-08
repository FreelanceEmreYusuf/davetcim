/*import 'dart:async';
import 'package:davetcim/shared/models/CustomerDetailModel.dart';
import 'package:flutter/material.dart';

class ProductDetailsForSearch extends StatefulWidget {
  final int id;
  final String name;
  final String surname;
  final String gsm;
  final String email;
  final Widget childPage;
  const ProductDetailsForSearch(
      this.id, this.name, this.surname, this.gsm, this.email, this.childPage);

  @override
  _ProductDetailsForSearchState createState() =>
      _ProductDetailsForSearchState();
}

class _ProductDetailsForSearchState extends State<ProductDetailsForSearch> {
  List<CustomerDetailModel> customers = [];

  Future addList() async {
    CustomerDetailModel customerDetailModel = new CustomerDetailModel(
        widget.id,
        widget.name,
        widget.surname,
        widget.gsm,
        widget.email,
        widget.childPage);
    customers.add(customerDetailModel);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, projectSnap) {
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: ListView(
              children: <Widget>[
                SizedBox(height: 10.0),
                Card(
                  child: Text(widget.name),
                )
              ],
            ),
          ),
        );
      },
      future: addList(),
    );
  }
}
*/
