import 'package:davetcim/widgets/app_bar/app_bar_view.dart';
import 'package:flutter/material.dart';
import '../../../shared/utils/utils.dart';
import '../manage_corporation_photos_add/manage_corporation_photos_add_view.dart';
import 'manage_corporation_photos_view.dart';

class PickPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMenu(
        isPopUpMenuActive: true,
        isNotificationsIconVisible: true,
        isHomnePageIconVisible: true,
        pageName: "Fotoğraf Yönetimi",
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              color: Colors.redAccent,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 1,
                  child: buildCard(
                    context,
                    "Resimleri Düzenle",
                    Icons.photo,
                    ManageCorporationPhotosView(),
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  flex: 1,
                  child: buildCard(
                    context,
                    "Resim Ekle",
                    Icons.photo_camera,
                    ManageCorporationPhotosAddView(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCard(
      BuildContext context, String title, IconData icon, Widget destination) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: () {
          Utils.navigateToPage(context, destination);
        },
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.redAccent,
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 30.0,
                ),
              ),
              SizedBox(width: 20),
              Text(
                title,
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
