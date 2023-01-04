import 'package:davetcim/shared/utils/utils.dart';
import 'package:davetcim/src/admin_corporate_panel/seans/seans_corporate_add_view.dart';
import 'package:davetcim/src/admin_corporate_panel/service/service-corporate_view_model.dart';
import 'package:davetcim/src/admin_corporate_panel/service/service_corporate_view.dart';
import 'package:davetcim/src/admin_panel/service/service_view.dart';
import 'package:davetcim/src/admin_panel/service/service_view_model.dart';
import 'package:flutter/material.dart';

import '../../../shared/environments/const.dart';
import '../../../shared/models/service_pool_model.dart';
import '../../../shared/utils/form_control.dart';
import '../../../widgets/app_bar/app_bar_view.dart';
import '../../../widgets/seans_corporate_card_widget.dart';


class SeansCorporateView extends StatefulWidget {
  final ServicePoolModel servicePoolModel;

  SeansCorporateView({
    Key key,
    @required this.servicePoolModel,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<SeansCorporateView> {
  TextEditingController priceController = TextEditingController();
  bool checkedCountPriceValue = false;
  bool hasPrice = false;
  final registerFormKey = GlobalKey <FormState> ();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarMenu(pageName: "Seans Yönetimi", isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
        body:Scaffold(
          body: ListView(
            padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
            //reverse: true, //*tersten siralar elemanlari

            children: [
              Column(
                children: [
                  SeansCorporateCardWidget(seansName: "Sabah Seansı 10:00-14:00 arası"),
                  SeansCorporateCardWidget(seansName: "Öğlen Seansı 15:00-19:00 arası"),
                  SeansCorporateCardWidget(seansName: "Akşam Seansı 20:00-00:00 arası"),
                  SeansCorporateCardWidget(seansName: "Sabah Seansı 10:00-14:00 arası"),
                  SeansCorporateCardWidget(seansName: "Öğlen Seansı 15:00-19:00 arası"),
                  SeansCorporateCardWidget(seansName: "Akşam Seansı 20:00-00:00 arası"),
                  SeansCorporateCardWidget(seansName: "Sabah Seansı 10:00-14:00 arası"),
                  SeansCorporateCardWidget(seansName: "Öğlen Seansı 15:00-19:00 arası"),
                  SeansCorporateCardWidget(seansName: "Akşam Seansı 20:00-00:00 arası"),
                  SeansCorporateCardWidget(seansName: "Sabah Seansı 10:00-14:00 arası"),
                  SeansCorporateCardWidget(seansName: "Öğlen Seansı 15:00-19:00 arası"),
                  SeansCorporateCardWidget(seansName: "Akşam Seansı 20:00-00:00 arası"),
                  SeansCorporateCardWidget(seansName: "Sabah Seansı 10:00-14:00 arası"),
                  SeansCorporateCardWidget(seansName: "Öğlen Seansı 15:00-19:00 arası"),
                  SeansCorporateCardWidget(seansName: "Akşam Seansı 20:00-00:00 arası"),
                  SeansCorporateCardWidget(seansName: "Sabah Seansı 10:00-14:00 arası"),
                  SeansCorporateCardWidget(seansName: "Öğlen Seansı 15:00-19:00 arası"),
                  SeansCorporateCardWidget(seansName: "Akşam Seansı 20:00-00:00 arası"),
                  SeansCorporateCardWidget(seansName: "Sabah Seansı 10:00-14:00 arası"),
                  SeansCorporateCardWidget(seansName: "Öğlen Seansı 15:00-19:00 arası"),
                  SeansCorporateCardWidget(seansName: "Akşam Seansı 20:00-00:00 arası"),
                ],
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Utils.navigateToPage(context, SeansCorporateAddView());
            },
            label: const Text('Seans Ekle'),
            icon: const Icon(Icons.add),
            backgroundColor: Colors.redAccent,
          ),
        ),
    );
  }


}

