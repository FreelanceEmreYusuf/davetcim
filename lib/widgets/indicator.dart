import 'package:flutter/material.dart';

class Indicator extends StatefulWidget {
  @override
  State<Indicator> createState() => _IndicatorState();
}

class _IndicatorState extends State<Indicator> {
  @override
  Widget build(BuildContext context) {
    Brightness brightness = Theme.of(context).brightness;
    String assetPath = brightness == Brightness.dark
        ? 'assets/indicatorDark.gif'
        : 'assets/indicator.gif';

    return Center(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Image.asset(
          assetPath,
          width: MediaQuery.of(context).size.width * 0.6,
          height: MediaQuery.of(context).size.height * 0.2,
        ),
      ),
    );
  }
}
