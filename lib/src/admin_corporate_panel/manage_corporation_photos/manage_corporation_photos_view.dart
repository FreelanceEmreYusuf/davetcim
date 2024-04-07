import 'package:davetcim/widgets/app_bar/app_bar_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../shared/models/image_model.dart';
import '../../../shared/sessions/user_state.dart';
import '../../../widgets/indicator.dart';
import 'manage_corporation_photos_view_model.dart.dart';


class ManageCorporationPhotosView extends StatefulWidget {
  @override
  _ManageCorporationPhotosViewState createState() => _ManageCorporationPhotosViewState();
}

class _ManageCorporationPhotosViewState extends State<ManageCorporationPhotosView> {
  List<ImageModel> list = [];
  final registerFormKey = GlobalKey <FormState> ();
  bool validationVisibility = false;
  String validationMessage = '';

  bool hasDataTaken = false;

  @override
  void initState() {
    getCorporationImages();
  }

  Future<void> getCorporationImages() async {
    ManageCorporationPhotosViewModel corporationPhotosViewModel =
    ManageCorporationPhotosViewModel();
    list = await corporationPhotosViewModel.getCorporatePhotos(UserState.corporationId);

    // isMainPhoto değeri true olan elemanı bulma
    int mainPhotoIndex = list.indexWhere((element) => element.isMainPhoto);

    // isMainPhoto değeri true olan elemanı listenin başına eklemek
    if (mainPhotoIndex != -1) {
      var mainPhoto = list.removeAt(mainPhotoIndex);
      list.insert(0, mainPhoto);
    }

    // Geri kalan elemanları id'ye göre sıralamak
    list.sort((a, b) => a.id.compareTo(b.id));

    setState(() {
      list = list;
      hasDataTaken = true;
    });
  }



  @override
  Widget build(BuildContext contex) {
    if (!hasDataTaken) {
      return Scaffold(appBar:
      AppBarMenu(isPopUpMenuActive: true, isNotificationsIconVisible: true, isHomnePageIconVisible: true, pageName: "Fotoğraf Yönetimi2"),
          body: Padding(
              padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
              child: Center(child: Indicator())));
    }

    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FloatingActionButton.extended(
          onPressed: () {
            bool isMainPhotoCheckedOnce = false;
            bool mainPhotoCheckedAsInactive = false;
            int countForMainPhoto = 0;
            for (int i = 0; i < list.length; i++) {
              ImageModel imageModel = list[i];
              if (imageModel.isMainPhoto) {
                if (!imageModel.isActivePhoto) {
                  mainPhotoCheckedAsInactive = true;
                  break;
                }
                countForMainPhoto++;
              }
            }
            if (mainPhotoCheckedAsInactive) {
              setState(() {
                validationVisibility = true;
                validationMessage = 'Ana Resim Inaktif Olarak Seçilemez';
              });
            } else if (countForMainPhoto == 0) {
              setState(() {
                validationVisibility = true;
                validationMessage = 'Ana Resim Seçilmedi';
              });
            } else if (countForMainPhoto > 1) {
              setState(() {
                validationVisibility = true;
                validationMessage = 'Birden Fazla Ana Resim Seçilemez';
              });
            } else {
              ManageCorporationPhotosViewModel manageCorporationPhotosViewModel = ManageCorporationPhotosViewModel();
              manageCorporationPhotosViewModel.editImages(contex, list);
            }
          },
          label: const Text('Güncelle'),
          icon: const Icon(Icons.update),
          elevation: 20,
          backgroundColor: Colors.redAccent,
        ),
      ),
      appBar: AppBarMenu(isPopUpMenuActive: true, isNotificationsIconVisible: true, isHomnePageIconVisible: true, pageName: "Fotoğraf Yönetimi"),
      body:Column(
        children: [
          Expanded(
            flex: 1,
            child: Form(
              key: registerFormKey,
              child: ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: list == null ? 0 : list.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      margin: const EdgeInsets.all(10.0),
                      elevation: 30,
                      shadowColor: Colors.redAccent,
                      child: Column(
                        children: [
                          Stack(
                            children: <Widget>[
                              Image.network(
                                list[index].imageUrl,
                                fit: BoxFit.fill,
                              ),
                            ],
                          ),
                          CheckboxListTile(
                            value: list[index].isMainPhoto,
                            title: Text("Salon ana resmi olarak belirle"),
                            onChanged: (bool value) {
                              setState(() {
                                // Durumu değişen CheckboxListTile'ın index değerini saklayın
                                int changedIndex = index;

                                // Tüm diğer CheckboxListTile'ların durumunu sıfırlayın
                                for (int i = 0; i < list.length; i++) {
                                  if (i != changedIndex) {
                                    list[i].isMainPhoto = false;
                                  }
                                }

                                // Belirtilen index'e sahip CheckboxListTile'ın durumunu güncelleyin
                                list[changedIndex].isMainPhoto = value;
                              });
                            },
                          ),
                          CheckboxListTile(
                            value: list[index].isActivePhoto,
                            title: Text("Resmi ekle/kaldır"),
                            onChanged: (bool value) {
                              list[index].isActivePhoto = value;
                              setState(() {
                                list = list;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Visibility(
            visible: validationVisibility,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Lütfen sadece 1 tane salon ana resmi seçiniz!"),
              ),
            ),
          ),
        ],
      ),


    );
  }
}
