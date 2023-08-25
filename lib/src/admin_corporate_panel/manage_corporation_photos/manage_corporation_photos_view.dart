import 'package:davetcim/shared/sessions/application_session.dart';
import 'package:davetcim/widgets/app_bar/app_bar_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../shared/models/image_model.dart';
import 'manage_corporation_photos_view_model.dart.dart';


class ManageCorporationPhotosView extends StatefulWidget {
  @override
  _ManageCorporationPhotosViewState createState() => _ManageCorporationPhotosViewState();
}

class _ManageCorporationPhotosViewState extends State<ManageCorporationPhotosView> {
  List<ImageModel> list = [];
  final registerFormKey = GlobalKey <FormState> ();
  bool isPhotoActive = true;
  @override
  void initState() {
    getCorporationImages();
  }

  Future<void>getCorporationImages() async{
    ManageCorporationPhotosViewModel corporationPhotosViewModel = ManageCorporationPhotosViewModel();
    list = await corporationPhotosViewModel.getCorporatePhotos(ApplicationSession.userSession.corporationId);
    setState(() {
      list = list;
    });
  }


  @override
  Widget build(BuildContext contex){
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FloatingActionButton.extended(
          onPressed: () {
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
//                Food food = Food.fromJson(foods[index]);
                  Map imageMap = list[index].toMap();
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              bottomRight: Radius.circular(40)),
                          color: Colors.redAccent),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Card(
                          margin: const EdgeInsets.all(10.0),
                          elevation: 30,
                          shadowColor: Colors.redAccent,
                          child: Column(
                            children: [
                              Container(
                                  margin: const EdgeInsets.all(10.0),
                                  child: Stack(children: <Widget>[
                                    Image.network(
                                      imageMap["imageUrl"],
                                      fit: BoxFit.fill,
                                    ),
                                  ])),
                              CheckboxListTile(
                                value: isPhotoActive,
                                title: Text("Salon ana resmi olarak belirle"),
                                onChanged: (bool value) {
                                  setState(() {
                                    isPhotoActive = value;
                                  });
                                },
                              ),
                              CheckboxListTile(
                                value: isPhotoActive,
                                title: Text("Resmi ekle/kaldır"),
                                onChanged: (bool value) {
                                  setState(() {
                                    isPhotoActive = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
