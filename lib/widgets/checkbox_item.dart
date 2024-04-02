import 'package:flutter/material.dart';

class CheckBoxItem extends StatefulWidget {
  final String title;
  final String subTitle;
  final Icon icon;
  const CheckBoxItem(this.title, this.subTitle, this.icon);
  @override
  _CheckBoxItemState createState() => _CheckBoxItemState();
}

class _CheckBoxItemState extends State<CheckBoxItem> {

// value set to false
  bool _value = false;

// App widget tree
  @override
  Widget build(BuildContext context) {
    return SizedBox(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.greenAccent),
                  borderRadius: BorderRadius.circular(20),
                ), //BoxDecoration

                /** CheckboxListTile Widget **/
                child: CheckboxListTile(
                  title: Text(widget.title),
                  subtitle: Text(widget.subTitle),
                  secondary: widget.icon,
                  autofocus: false,
                  activeColor: Colors.green,
                  checkColor: Colors.white,
                  selected: _value,
                  value: _value,
                  onChanged: (bool value) {
                    setState(() {
                      _value = value;
                    });
                  },
                ), //CheckboxListTile
              ), //Container
            ), //Padding
          ), //Center
    );
  }
}
