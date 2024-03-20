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

  void loadHashtags() {
    listWidget.clear(); // Önceki widget listesini temizle
    if (widget.hashtagList.isNotEmpty) {
      for (int i = 0; i < widget.hashtagList.length; i++) {
        listWidget.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0), // Widget'lar arası boşluk
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.1), // Temaya göre arka plan rengi
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                widget.hashtagList[i],
                style: TextStyle(
                  fontSize: 13,
                  color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black, // Temaya göre metin rengi
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
        );
      }
    } else {
      listWidget.add(
        Text(
          " ",
          style: normalTextStyle,
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    loadHashtags();
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