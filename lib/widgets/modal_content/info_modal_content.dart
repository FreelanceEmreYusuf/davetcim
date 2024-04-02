import 'package:flutter/material.dart';

class InfoModalContent {
  static void showInfoModalContent(
      BuildContext context, String header, String text, Function method) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      builder: (BuildContext context) {
        return Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  header,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.5),
                ),
                SizedBox(height: 20),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 10,),
              ],),
            Positioned(
              bottom: MediaQuery.of(context).size.height / 150,
              right: MediaQuery.of(context).size.width / 150,
              left: MediaQuery.of(context).size.width / 150,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: ()  {
                    Navigator.pop(context);
                    if (method != null) {
                      method(context);
                    }
                  },
                  child: Text(
                    "Tamam",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),),
          ],
        );
      },
    );
  }
}