import 'package:davetcim/shared/sessions/reservation_edit_state.dart';
import 'package:davetcim/widgets/user_reservation_update_grid_corporate_service_pool_for_basket_summary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../shared/dto/reservation_detail_view_dto.dart';
import '../shared/enums/corporation_service_selection_enum.dart';
import '../shared/helpers/general_helper.dart';
import '../shared/models/corporation_package_services_model.dart';
import '../shared/utils/dialogs.dart';
import '../shared/utils/utils.dart';
import '../src/user_reservations/update/user_reservation_update_services_view.dart';
import 'modal_content/info_modal_content.dart';

class UserReservationUpdateGridServicePackageItem extends StatefulWidget {
  final CorporationPackageServicesModel packageModel;

  UserReservationUpdateGridServicePackageItem({
    Key key,
    @required this.packageModel,
  }) : super(key: key);

  @override
  _UserReservationUpdateGridServicePackageItemState createState() =>
      _UserReservationUpdateGridServicePackageItemState();
}

class _UserReservationUpdateGridServicePackageItemState
    extends State<UserReservationUpdateGridServicePackageItem> {
  @override
  Widget build(BuildContext context) {
    Row row;

    row = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FittedBox(
          child: Text(
              widget.packageModel.title, style: TextStyle(
              fontSize: 18,
              color: Colors.green,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold)),
        ),
        Spacer(),
        Expanded(
            child: ClipPath(
              child: Material(
                borderRadius: BorderRadius.horizontal(left: Radius.circular(30.0)),
                color: Colors.grey, // button color
                child: InkWell(
                  splashColor: Colors.deepOrangeAccent, // splash color
                  onTap: () async {
                    InfoModalContent.showInfoModalContent(
                        context,
                        widget.packageModel.title,
                        "Paket İçeriği: "+widget.packageModel.body+""
                        "\n\nKişi başı ücret: "+GeneralHelper.formatMoney(widget.packageModel.price.toString())+" TL"
                            "\n\nDavetli Sayısına Göre Toplam Tutar: "
                            "\nDavetli Sayısı("+
                            ReservationEditState.reservationDetail.orderBasketModel.count.toString()+") "
                            "\nKişi Başı Paket Ücreti("+GeneralHelper.formatMoney(widget.packageModel.price.toString())+"TL)"
                            "\nToplam Ücret: "+GeneralHelper.formatMoney((widget.packageModel.price *
                            ReservationEditState.reservationDetail.orderBasketModel.count).toString())+" TL",
                        null);
                  }, // button pressed
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FittedBox(child: Icon(Icons.info, color: Colors.white)), // icon
                      FittedBox(child: Text("Bilgi", style: TextStyle(color: Colors.white))),
                    ],
                  ),
                ),
              ),
            ),
          ),
        Expanded(
          child: ClipPath(
            child: Material(
              color: Colors.green, // button color
              borderRadius: BorderRadius.horizontal(right: Radius.circular(30.0)),
              child: InkWell(
                splashColor: Colors.deepOrangeAccent, // splash color
                onTap: () {
                  ReservationEditState.reservationDetail.packageModel = widget.packageModel;
                  if (ReservationEditState.reservationDetail.corporateModel.serviceSelection ==
                      CorporationServiceSelectionEnum.customerSelectsExtraProduct
                  || ReservationEditState.reservationDetail.corporateModel.serviceSelection ==
                      CorporationServiceSelectionEnum.customerSelectsBoth) {
                    Utils.navigateToPage(context, UserReservationUpdateServicesScreen());
                  } else {
                    Utils.navigateToPage(context, UserReservationUpdateGridCorporateServicePoolForBasketSummary());
                  }
                }, // button pressed
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.select_all, color: Colors.white), // icon
                    Text("Seç", style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 13,
            child: Card(
              color: Colors.white54,
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
              ),
              child: row, // Burada row widgetını kullanmalısınız.
              elevation: 10,
            ),
          ),
        ],
      ),
    );
  }
}
