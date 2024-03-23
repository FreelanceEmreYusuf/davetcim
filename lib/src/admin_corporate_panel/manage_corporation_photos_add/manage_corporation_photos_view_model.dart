import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davetcim/shared/environments/db_constants.dart';
import 'package:davetcim/shared/models/image_model.dart';
import 'package:davetcim/shared/sessions/application_context.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import '../../../shared/services/database.dart';
import '../../../shared/utils/dialogs.dart';

class ManageCorporationPhotosAddViewModel extends ChangeNotifier {
  Database db = Database();

  Future<void> uploadImage(BuildContext context, File imageFile) async {
    /// Storage üzerindeki dosya adını oluştur
    String path = '${DateTime.now().millisecondsSinceEpoch}.jpg';

    /// Dosyayı gönder
    TaskSnapshot uploadTask = await FirebaseStorage.instance
        .ref()
        .child('images')
        .child('1')
        .child(path)
        .putFile(imageFile);

    String uploadedImageUrl = await uploadTask.ref.getDownloadURL();

    ImageModel imageModel = ImageModel(
        id : new DateTime.now().millisecondsSinceEpoch,
        corporationId: ApplicationContext.userCache.corporationId,
        imageUrl: uploadedImageUrl
    );

    db.editCollectionRef(DBConstants.imagesDb, imageModel.toMap());

    Dialogs.showAlertMessage(
      context,
      'Yükleme Bilgisi',
      'Resminiz Başarıyla Yüklendi',
    );
  }

}