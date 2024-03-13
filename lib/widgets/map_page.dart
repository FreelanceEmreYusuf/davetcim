import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class SelectLocationPage extends StatefulWidget {
  final double latitude;
  final double longitude;
  const SelectLocationPage(this.latitude, this.longitude);

  @override
  _SelectLocationPageState createState() => _SelectLocationPageState();
}

class _SelectLocationPageState extends State<SelectLocationPage> {
  LatLng selectedLocation;

  @override
  void initState() {
    super.initState();
    selectedLocation = LatLng(widget.latitude, widget.longitude);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(widget.latitude, widget.longitude),
          zoom: 15,
         // onTap: _handleTap,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          if (selectedLocation != null)
            MarkerLayerOptions(
              markers: [
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: selectedLocation,
                  builder: (ctx) => Container(
                    child: Icon(
                      Icons.location_pin,
                      color: Colors.red,
                      size: 50.0,
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
