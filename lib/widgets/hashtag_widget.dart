import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HashtagWidget extends StatefulWidget {

  @override
  _HashtagWidgetState createState() => _HashtagWidgetState();

  final List<String> hashtagList;
  HashtagWidget(
      {Key key,
        @required this.hashtagList})
      : super(key: key);
}

class _HashtagWidgetState extends State<HashtagWidget> {

  TextStyle hashTagTextStyle = TextStyle(
    fontSize: 13,
    color: Colors.redAccent,
    backgroundColor: Colors.black12,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.italic,
    locale: Locale('tr', 'en'),
  );

  TextStyle normalTextStyle = TextStyle(
    fontSize: 12,
    color: Colors.black,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
    locale: Locale('tr', 'en'),
  );

  List<Widget> listWidget = [];

  @override
  void initState() {
    if(widget.hashtagList.length>0){
      for(int i=0; i<widget.hashtagList.length; i++){
        listWidget.add(
            Card(elevation: 8.0,  child: Text(widget.hashtagList[i], style: hashTagTextStyle,))
        );
        listWidget.add(
            Text(" ", style: normalTextStyle,)
        );
      }
    }
    else
      listWidget.add(
          Text(" ", style: normalTextStyle,)
      );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return   SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
          children: <Widget>[
            for(int i=0; i<listWidget.length; i++)
              Padding(child: listWidget[i], padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height / 60),),
          ]
      ),
    );
  }
}