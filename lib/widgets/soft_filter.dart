import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SoftFilterWidget extends StatelessWidget {

  static TextStyle kStyle =
  TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w500);
  int _cardDivisionSize = 40;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 3.0),
      child: ClipPath(
        clipper: BottomClipper(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 2.6,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/soft_filter_background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.1), // Filtre yoğunluğu
              ],
            ),
          ),
          child: Container(
            color: Colors.transparent,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.fromLTRB(8.0, 0, 8, 0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0), // Card'ı oval yapar
                  ),
                  color: Colors.white60,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          child: Card(
                            elevation: 3.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                CupertinoButton(
                                  child: Text(
                                    "Mekan Türü",
                                    style: kStyle,
                                    textAlign: TextAlign.center,
                                  ),
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      MediaQuery.of(context).size.height /
                                          _cardDivisionSize,
                                      MediaQuery.of(context).size.height /
                                          _cardDivisionSize,
                                      MediaQuery.of(context).size.height /
                                          _cardDivisionSize,
                                      MediaQuery.of(context).size.height /
                                          _cardDivisionSize),
                                ),
                                Text(
                                  "Tümü",
                                  style: TextStyle(fontSize: 18.0),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                              ],
                            ),
                          ),
                          onTap: () {

                          },
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height / 200,),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                child: Card(
                                  elevation: 3.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      CupertinoButton(
                                        child: Text(
                                          "İl",
                                          style: kStyle,
                                          textAlign: TextAlign.center,
                                        ),
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            MediaQuery.of(context).size.height /
                                                _cardDivisionSize,
                                            MediaQuery.of(context).size.height /
                                                _cardDivisionSize,
                                            MediaQuery.of(context).size.height /
                                                _cardDivisionSize,
                                            MediaQuery.of(context).size.height /
                                                _cardDivisionSize),
                                      ),
                                      Text(
                                        "Tümü",
                                        style: TextStyle(fontSize: 18.0),
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                    ],
                                  ),
                                ),
                               onTap: () {

                                },
                              ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height / 200,),
                            Expanded(
                              child: GestureDetector(
                                child: Card(
                                  elevation: 3.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      CupertinoButton(
                                        child: Text(
                                          "İlçe",
                                          style: kStyle,
                                        ),
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            MediaQuery.of(context).size.height /
                                                _cardDivisionSize,
                                            MediaQuery.of(context).size.height /
                                                _cardDivisionSize,
                                            MediaQuery.of(context).size.height /
                                                _cardDivisionSize,
                                            MediaQuery.of(context).size.height /
                                                _cardDivisionSize),
                                      ),
                                      Text(
                                        "Tümü",
                                        style: TextStyle(fontSize: 18.0),
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                    ],
                                  ),
                                ),
                                 onTap: () {

                                  },
                              ),
                            ), 
                          ],
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height / 25,),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.blue, // Butonun arka plan rengi
                                  onPrimary: Colors.white, // Buton metin rengi
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(25),
                                        topLeft: Radius.circular(25)),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                                  child: Text(
                                    'ARA', // Buton metni
                                    style: TextStyle(fontSize: MediaQuery.of(context).size.height / 35, letterSpacing: 1.0, fontFamily: 'RobotoMono', ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 50); // Sol alt köşe
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 50); // Alt kenar
    path.lineTo(size.width, 0); // Sağ alt köşe
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
