import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../shared/environments/const.dart';
import '../../../shared/models/image_model.dart';
import '../../../shared/sessions/user_state.dart';
import '../../../shared/utils/dialogs.dart';
import '../../../widgets/app_bar/app_bar_view.dart';
import '../manage_corporation_photos/manage_corporation_photos_view_model.dart.dart';
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
  List<ImageModel> imageList = [];
  int imageListLenght = 0;

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

  void getCorporationImageList() async {
    ManageCorporationPhotosViewModel manageCorporationPhotosObject = new ManageCorporationPhotosViewModel();
    imageList = await manageCorporationPhotosObject.getCorporatePhotos(UserState.corporationId);

    setState(() {
      imageList = imageList;
      imageListLenght = imageList.length;
    });
  }
/*
  @override
  void initState() {
    super.initState();
    getCorporationImageList();
  }*/

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
                      onPressed: () async {
                        getCorporationImageList();
                        if(imageListLenght<9)
                          {
                            await updateCodeFromGalery();
                          }
                        else
                          Dialogs.showInfoModalContent(
                              context, "Uyarı", "Maximum resim yükleme sınırına ulaştınız yeni resim yüklemek için lütfen mevcut resimlerinizden birini silin.", null);
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
                      onPressed: () async {
                        getCorporationImageList();
                        if(UserState.isCorporationFavorite(UserState.corporationId)){
                          if(imageListLenght<25)
                          {
                            await updateCodeFromCamera();
                          }
                          else
                            Dialogs.showInfoModalContent(context, "Uyarı", "Maximum resim yükleme sınırına ulaştınız yeni resim yüklemek için lütfen mevcut resimlerinizden birini silin.", null);
                        }
                        else{
                          if(imageListLenght<10)
                          {
                            await updateCodeFromCamera();
                          }
                          else
                            Dialogs.showInfoModalContent(context, "Uyarı", "Maximum resim yükleme sınırına ulaştınız yeni resim yüklemek için lütfen mevcut resimlerinizden birini silin.", null);
                        }
                      },
                    )),
              ],
            )));
  }
}
