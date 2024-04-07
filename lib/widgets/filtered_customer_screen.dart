import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davetcim/shared/environments/const.dart';
import 'package:davetcim/widgets/storage_grid_product.dart';
import 'package:flutter/material.dart';

import 'package:davetcim/shared/utils/utils.dart';

import 'indicator.dart';
import 'on_error/somethingWentWrong.dart';

class FilteredCustomersScreenState extends StatefulWidget {
  final int customerId;
  const FilteredCustomersScreenState(this.customerId);

  @override
  _FilteredProductsScreenState createState() => _FilteredProductsScreenState();
}

class _FilteredProductsScreenState extends State<FilteredCustomersScreenState> {
  List<dynamic> filteredProducts;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference customerRef =
        Utils.getCollectionRef(Constants.customerDB);
    List<DocumentSnapshot> filteredCustomers = [];
    return StreamBuilder<QuerySnapshot>(
        stream:
            customerRef.where('id', isEqualTo: widget.customerId).snapshots(),
        builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
          if (asyncSnapshot.hasError) {
            return SomethingWentWrongScreen();
          } else if (asyncSnapshot.hasData) {
            filteredCustomers = asyncSnapshot.data.docs;
            return Scaffold(
              body: Padding(
                padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                child: ListView(
                  children: <Widget>[
                    Divider(),
                    SizedBox(height: 10.0),
                    GridView.builder(
                      shrinkWrap: true,
                      primary: false,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.height / 1.25),
                      ),
                      itemCount: filteredCustomers == null
                          ? 0
                          : filteredCustomers.length,
                      itemBuilder: (BuildContext context, int index) {
                        Map customerItems = filteredCustomers[index].data();
                        return StorageGridProduct(
                            id: widget.customerId,
                            name: customerItems['name'],
                            surname: customerItems['surname'],
                            gsm: customerItems['gsm'],
                            email: customerItems['email']);
                      },
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: Indicator(),
            );
          }
        });
  }
}
