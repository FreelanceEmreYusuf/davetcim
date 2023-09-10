import 'package:davetcim/widgets/app_bar/app_bar_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../shared/utils/utils.dart';
import '../manage_corporation_photos_add/manage_corporation_photos_add_view.dart';
import 'manage_corporation_photos_view.dart';


class PickPageView extends StatefulWidget {
  @override
  _PickPageViewState createState() => _PickPageViewState();
}

class _PickPageViewState extends State<PickPageView> {
  @override
  Widget build(BuildContext contex){
    return Scaffold(
      appBar: AppBarMenu(isPopUpMenuActive: true, isNotificationsIconVisible: true, isHomnePageIconVisible: true, pageName: "Fotoğraf Yönetimi"),
      body:Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40)),
                color: Colors.redAccent),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 1,
                    child: Card(
                      elevation: 30,
                      shadowColor: Colors.redAccent,
                      child: Container(
                        child: MaterialButton(
                          onPressed: (){
                              Utils.navigateToPage(context, ManageCorporationPhotosView());
                          },
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.redAccent,
                              child: Icon(
                                Icons.photo,
                                color: Colors.white,
                                size: 30.0,
                              ),
                            ),
                            title: Text("Resimleri Düzenle", style: TextStyle(color: Colors.redAccent, fontSize: 30.0, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Card(
                      elevation: 30,
                      shadowColor: Colors.redAccent,
                      child: Container(
                        child: MaterialButton(
                          onPressed: (){
                            Utils.navigateToPage(context, ManageCorporationPhotosAddView());
                          },
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.redAccent,
                              child: Icon(
                                Icons.photo_camera,
                                color: Colors.white,
                                size: 30.0,
                              ),
                            ),
                            title: Text("Resim Ekle", style: TextStyle(color: Colors.redAccent, fontSize: 30.0, fontWeight: FontWeight.bold)),

                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
