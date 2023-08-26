import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../shared/environments/const.dart';
import '../../../widgets/app_bar/app_bar_view.dart';
import 'manage_corporation_photos_view_model.dart';

class ManageCorporationPhotosAddView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<ManageCorporationPhotosAddView> {
  TextEditingController codeIdController = TextEditingController();
  TextEditingController codeNameController = TextEditingController();
  bool checkedValue = false;
  String _photoUrl;
  File image;
  final picker = ImagePicker();

  Future updateCodeFromCamera() async {
    final pickedFile =
    await picker.getImage(source: ImageSource.camera, imageQuality: 50);
    addTFileToSystem(pickedFile);
  }

  Future updateCodeFromGalery() async {
    final pickedFile =
    await picker.getImage(source: ImageSource.gallery, imageQuality: 50);
    addTFileToSystem(pickedFile);
  }

  void addTFileToSystem(PickedFile pickedFile) async {
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      }
    });

    if (pickedFile != null) {
      ManageCorporationPhotosAddViewModel manageCorporationPhotosAddViewModel = ManageCorporationPhotosAddViewModel();
      await manageCorporationPhotosAddViewModel.uploadImage(context, image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarMenu(isPopUpMenuActive: true, isNotificationsIconVisible: true, isHomnePageIconVisible: true, pageName: "Fotoğraf Ekle"),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    // ignore: deprecated_member_use
                    child: MaterialButton(
                      textColor: Colors.white,
                      color: Constants.darkAccent,
                      child: Text('Galeriden Ekle'),
                      onPressed: () {
                        updateCodeFromGalery();
                      },
                    )),
                SizedBox(height: 20.0),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    // ignore: deprecated_member_use
                    child: MaterialButton(
                      textColor: Colors.white,
                      color: Constants.darkAccent,
                      child: Text('Kameradan Ekle'),
                      onPressed: () {
                        updateCodeFromCamera();
                      },
                    )),
              ],
            )));
  }
}
