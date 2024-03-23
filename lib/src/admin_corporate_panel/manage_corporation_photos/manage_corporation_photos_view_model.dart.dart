import 'package:davetcim/shared/helpers/corporate_helper.dart';
import 'package:davetcim/shared/models/corporation_model.dart';
import 'package:davetcim/shared/models/image_model.dart';
import 'package:davetcim/shared/sessions/application_context.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import '../../../shared/environments/db_constants.dart';
import '../../../shared/services/database.dart';
import '../../../shared/utils/utils.dart';
import '../AdminCorporatePanel.dart';

class ManageCorporationPhotosViewModel extends ChangeNotifier {
  Database db = Database();

  Future<List<ImageModel>> getCorporatePhotos(int corporateId) async {
    CorporateHelper corporateHelper = CorporateHelper();
    CorporationModel corporationModel = await corporateHelper.getCorporate(ApplicationContext.userCache.corporationId);

    var response = await db
        .getCollectionRef(DBConstants.imagesDb)
        .where('corporationId', isEqualTo: corporateId)
        //.orderBy('id', descending: true)
        .get();

    List<ImageModel> imageList = [];
    if (response.docs != null && response.docs.length > 0) {
      var list = response.docs;
      for (int i = 0; i < list.length; i++) {
        Map item = list[i].data();
        ImageModel imageModel = ImageModel.fromMap(item);
        imageModel.isMainPhoto = false;
        imageModel.isActivePhoto = true;
        if (imageModel.imageUrl == corporationModel.imageUrl) {
          imageModel.isMainPhoto = true;
        }
        imageList.add(imageModel);
      }
    }
    return imageList;
  }

  Future<void> editImages(BuildContext context, List<ImageModel> imageList) async {
    for (int i = 0; i < imageList.length; i++) {
      if (!imageList[i].isActivePhoto) {
        deleteImage(imageList[i]);
        deleteImageFromStorage(imageList[i]);
      }
      if (imageList[i].isMainPhoto) {
        makeMainImage(imageList[i]);
      }
    }
    Utils.navigateToPage(context, AdminCorporatePanelPage());
  }

  Future<void> deleteImage(ImageModel imageModel) async {
    db.deleteDocument(DBConstants.imagesDb, imageModel.id.toString());
  }

  Future<void> deleteImageFromStorage(ImageModel imageModel) async {
      await FirebaseStorage.instance.refFromURL(imageModel.imageUrl).delete();
  }


  Future<void> makeMainImage(ImageModel imageModel) async {
    CorporateHelper corporateHelper = CorporateHelper();
    CorporationModel corporationModel = await corporateHelper.getCorporate(imageModel.corporationId);
    Map corporationMap = corporationModel.toMap();
    corporationMap['imageUrl'] = imageModel.imageUrl;
    db.editCollectionRef(DBConstants.corporationDb, corporationMap);
  }
}