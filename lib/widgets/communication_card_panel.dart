import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;
import 'launch_button.dart';

class CommunicationCardPanel extends StatefulWidget {
  final String phoneNumber;
  final String eMail;
  const CommunicationCardPanel(this.phoneNumber, this.eMail);
  @override
  _CommunicationCardPanelState createState() => _CommunicationCardPanelState();
}

class _CommunicationCardPanelState extends State<CommunicationCardPanel> {

// value set to false
  bool _value = false;

// App widget tree
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
      child: Card(
        elevation: 10,
        shadowColor: Colors.redAccent,
        child: FittedBox(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                LaunchButton(
                  title: 'Telefon',
                  value: "+90"+widget.phoneNumber,
                  icon: Icons.phone,
                  color: Colors.green,
                  context: context,
                  onPressed: () async {
                    Uri uri = Uri.parse('tel:' + "+90"+widget.phoneNumber);
                    if (!await launcher.launchUrl(uri)) {
                      debugPrint(
                          "Could not launch the uri"); // because the simulator doesn't has the phone app
                    }
                  },
                ),
                SizedBox(width: 16.0), // İkinci düğme ile arasında boşluk bırakın
                LaunchButton(
                  title: 'Email',
                  value: widget.eMail,
                  icon: Icons.mail,
                  color: Colors.blueAccent,
                  context: context,
                  onPressed: () async {
                    Uri uri = Uri.parse(
                      'mailto:' + widget.eMail + '?subject=Davetcim Uygulamasından Ulaşıyorum HK.&body=Merhaba,',
                    );
                    if (!await launcher.launchUrl(uri)) {
                      debugPrint(
                          "Could not launch the uri"); // because the simulator doesn't has the email app
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
