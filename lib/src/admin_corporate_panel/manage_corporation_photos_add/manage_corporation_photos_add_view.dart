import 'dart:io';

import 'package:davetcim/shared/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../shared/environments/const.dart';
import '../../../shared/models/image_model.dart';
import '../../../shared/sessions/user_state.dart';
import '../../../widgets/app_bar/app_bar_view.dart';
import '../manage_corporation_photos/manage_corporation_photos_view_model.dart.dart';
import 'manage_corporation_photos_view_model.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

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
  File _imageFile;


  Future<void> _getImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      final image = File(pickedFile.path);
      final resizedImage = await _resizeImage(image, targetSize: 2);
      setState(() {
        _imageFile = resizedImage;
      });
      addTFileToSystem(_imageFile);
    }
  }

  Future<void> _getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final image = File(pickedFile.path);
      final resizedImage = await _resizeImage(image, targetSize: 2);
      setState(() {
        _imageFile = resizedImage;
      });
      addTFileToSystem(_imageFile);
    }
  }

  Future<File> _resizeImage(File image, {int targetSize = 3}) async {
    // Dosyanın boyutunu kontrol et
    final imageSize = await image.length();

    // Dosya boyutunu MB cinsine çevir
    final double fileSizeInMB = imageSize / (1024 * 1024);

    // Dosya boyutu hedef boyuttan büyükse yeniden boyutlandır
    if (fileSizeInMB > targetSize) {
      // Resmi oku
      final img.Image originalImage = img.decodeImage(await image.readAsBytes());

      // Hedef boyuta göre genişliği yeniden hesapla
      final double targetWidth = originalImage.width * (targetSize / fileSizeInMB);
      final double targetHeight = originalImage.height * (targetSize / fileSizeInMB);

      // Yeniden boyutlandırma işlemi
      final resizedImage = img.copyResize(originalImage, width: targetWidth.toInt(), height: targetHeight.toInt());

      // Yeniden boyutlandırılmış resmi dosyaya yaz
      final tempDir = await getTemporaryDirectory();
      final tempPath = tempDir.path;
      final resizedImagePath = '$tempPath/resized_image.jpg';
      File resizedImageFile = File(resizedImagePath)
        ..writeAsBytesSync(img.encodeJpg(resizedImage, quality: 85));

      return resizedImageFile;
    } else {
      // Dosya boyutu hedef boyuttan küçükse, dosyayı değiştirmeden geri döndür
      return image;
    }
  }

  void addTFileToSystem(File imageFile) async {
    if (imageFile != null) {
      ManageCorporationPhotosAddViewModel manageCorporationPhotosAddViewModel = ManageCorporationPhotosAddViewModel();
      await manageCorporationPhotosAddViewModel.uploadImage(context, imageFile);
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
                        if(UserState.isCorporationFavorite(UserState.corporationId)){
                          if(imageListLenght<=20)
                          {
                            await _getImageFromGallery();
                          }
                          else
                            Dialogs.showAlertMessage(context, "Uyarı", "Maximum resim yükleme sınırına ulaştınız yeni resim yüklemek için lütfen mevcut resimlerinizden birini silin.");
                        }
                        else{
                          if(imageListLenght<=10)
                          {
                            await _getImageFromGallery();
                          }
                          else
                            Dialogs.showAlertMessage(context, "Uyarı", "Maximum resim yükleme sınırına ulaştınız yeni resim yüklemek için lütfen mevcut resimlerinizden birini silin veya vip üyelik paketinizi"
                                " VIP pakete yükseltin.");
                        }
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
                          if(imageListLenght<=20)
                          {
                            await _getImageFromCamera();
                          }
                          else
                            Dialogs.showAlertMessage(context, "Uyarı", "Maximum resim yükleme sınırına ulaştınız yeni resim yüklemek için lütfen mevcut resimlerinizden birini silin.");
                        }
                        else{
                          if(imageListLenght<=10)
                          {
                            await _getImageFromCamera();
                          }
                          else
                            Dialogs.showAlertMessage(context, "Uyarı", "Maximum resim yükleme sınırına ulaştınız yeni resim yüklemek için lütfen mevcut resimlerinizden birini silin veya vip üyelik paketinizi"
                                " VIP pakete yükseltin.");
                        }
                      },
                    )),
              ],
            )));
  }
}
