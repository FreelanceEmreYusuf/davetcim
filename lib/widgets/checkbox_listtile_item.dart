import 'package:flutter/material.dart';

import 'app_bar/app_bar_view.dart';

class CheckBoxListItem extends StatefulWidget {
  @override
  CheckBoxListItemState createState() => new CheckBoxListItemState();
}

class CheckBoxListItemState extends State<CheckBoxListItem> {
  Map<String, bool> values = {
    'Düğün Salonu': false,
    'Balo Salonu': false,
    'Otel': false,
    'Konser Salonu': false,
  };

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBarMenu(pageName: "Salon Özellikleri", isHomnePageIconVisible: false, isNotificationsIconVisible: false, isPopUpMenuActive: true),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          //Utils.navigateToPage(context, SeansCorporateAddView());
        },
        label: const Text('Devam Et'),
        icon: const Icon(Icons.navigate_next),
        backgroundColor: Colors.redAccent,
      ),
      body: new ListView(
        children: values.keys.map((String key) {
          return new CheckboxListTile(
            title: new Text(key),
            value: values[key],
            onChanged: (bool value) {
              setState(() {
                values[key] = value;
              });
            },
          );
        }).toList(),
      ),
    );
  }
}