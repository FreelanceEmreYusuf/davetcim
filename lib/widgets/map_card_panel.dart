import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'map_page.dart';

class MapCardPanel extends StatefulWidget {
  final double latitude;
  final double longitude;
  const MapCardPanel(this.latitude, this.longitude);
  @override
  _MapCardPanelState createState() => _MapCardPanelState();
}

class _MapCardPanelState extends State<MapCardPanel> {

  void _launchMapsUrl(double latitude, double longitude) async {
    String url = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      child: Column(
        children: [
          Expanded(
            child: SelectLocationPage(widget.latitude, widget.longitude),
          ),
          SizedBox(height: 3), // İstenilen boşluk miktarına göre ayarlayın
          Container(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                double latitude = widget.latitude;
                double longitude = widget.longitude;

                // Google Haritalar'a belirli bir latitude ve longitude ile bir yönlendirme yapmak için
                _launchMapsUrl(latitude, longitude);
              },
              icon: Icon(Icons.navigation), // Navigasyon ikonu ekleyin
              label: Text('Haritada Görüntüle'), // Düğme metni
              style: ElevatedButton.styleFrom(
                primary: Colors.blue, // Düğme arka plan rengi
                onPrimary: Colors.white, // Düğme metin rengi
                shape: RoundedRectangleBorder( // Düğme şekli
                  borderRadius: BorderRadius.circular(8.0),
                ),
                elevation: 4, // Yükseltme
              ),
            ),
          ),

        ],
      ),
    );
  }
}
