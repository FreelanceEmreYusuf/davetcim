import 'package:flutter/material.dart';

class ExpandableCard extends StatefulWidget {
  final Widget expandedContent;
  final Widget collapsedContent;
  final Color expandedColor;
  final Color collapsedColor;

  ExpandableCard({
    @required this.expandedContent,
    @required this.collapsedContent,
    this.expandedColor = Colors.redAccent,
    this.collapsedColor = Colors.white,
  });

  @override
  _ExpandableCardState createState() => _ExpandableCardState();
}

class _ExpandableCardState extends State<ExpandableCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Container(
              padding: EdgeInsets.all(10),
              color: _isExpanded ? widget.expandedColor : widget.collapsedColor,
              child: Row(
                children: [
                  Expanded(
                    child: widget.collapsedContent,
                  ),
                  Icon(
                    _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    size: 30,
                  ),
                ],
              ),
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            height: _isExpanded ? null : 0,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: widget.expandedContent,
            ),
          ),
        ],
      ),
    );
  }
}
//örnek kullanım
/*class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Expandable Card Example'),
        ),
        body: Center(
          child: ExpandableCard(
            collapsedContent: Text(
              'Tap to Expand',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            expandedContent: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Expanded Content',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 10),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
*/