import 'package:davetcim/shared/sessions/application_context.dart';
import 'package:flutter/material.dart';
import '../shared/models/service_pool_model.dart';
import '../shared/utils/dialogs.dart';
import '../shared/utils/utils.dart';
import '../src/admin_corporate_panel/service/service_corporate_user_choose/service-corporate_view_model.dart';
import '../src/admin_corporate_panel/service/service_corporate_user_choose/service_corporate_view.dart';

class GridCorporateServicePoolForBasketSummary extends StatefulWidget {
  final ServicePoolModel servicePoolModel;

  GridCorporateServicePoolForBasketSummary({
    Key key,
    @required this.servicePoolModel
  }) : super(key: key);

  @override
  _GridCorporateServicePoolForBasketSummaryState createState() =>
      _GridCorporateServicePoolForBasketSummaryState();
}

class _GridCorporateServicePoolForBasketSummaryState
    extends State<GridCorporateServicePoolForBasketSummary> {

  bool buffer = true;
  int totalPrice = 0;
  String priceChangeForCount = "Evet";
  IconData buttonIcon = Icons.add;
  @override
  Widget build(BuildContext context) {
    double _paddingLeftValue = 0;

    Row row;
    if(!widget.servicePoolModel.hasChild){
      if (widget.servicePoolModel.companyHasService) {

        totalPrice = widget.servicePoolModel.corporateDetail.price *
            ApplicationContext.userBasket.orderBasketModel.count;
        if (!widget.servicePoolModel.corporateDetail.priceChangedForCount) {
          totalPrice = widget.servicePoolModel.corporateDetail.price;
          priceChangeForCount = "Hayır";
        }

        row = Row(
          children: [
            FittedBox(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    widget.servicePoolModel.serviceName.replaceAll("-", ""), style: TextStyle(fontSize: 18, color: Colors.black, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),
              ),
            ),
            Spacer(),
            SizedBox.fromSize(
              size: Size(MediaQuery.of(context).size.height / 10, MediaQuery.of(context).size.height / 10), // button width and height
              child: ClipPath(
                child: Material(
                  borderRadius: BorderRadius.horizontal(left: Radius.circular(30.0)),
                  color: Colors.grey, // button color
                  child: InkWell(
                    splashColor: Colors.deepOrangeAccent, // splash color
                    onTap: () async {
                      Dialogs.showAlertMessageWithAction(
                          context,
                          widget.servicePoolModel.serviceName,
                          //TODO: hizmet için fiyat bilgileri girilecek
                          "Belirtmiş olduğunuz davetli sayısı : "+ApplicationContext.userBasket.orderBasketModel.count.toString()
                              +"\n\nÜcret kişi sayısına bağlı değişir mi? : "+ priceChangeForCount
                              +"\n\nHizmetin birim ücreti : "+ widget.servicePoolModel.corporateDetail.price.toString()+ "TL"
                              "\n\nToplam ücret : "+
                              totalPrice.toString() + "TL",
                          null);
                    }, // button pressed
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FittedBox(child: Icon(Icons.info_outline, color: Colors.white)), // icon
                        FittedBox(child: Text("Bilgi", style: TextStyle(color: Colors.white))),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }
    } else {
      row = Row(
        children: [
          FittedBox(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  widget.servicePoolModel.serviceName, style: TextStyle(fontSize: 20, color: Colors.black, fontStyle: FontStyle.italic,fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      );
    }

    return Container(
      padding: EdgeInsets.only(left: _paddingLeftValue),
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
              ),
              color: Colors.white54,
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: row,
              elevation: 10,
            ),
          ),
        ],
      ),
    );
  }
  Future<void> deleteService() async {
    ServiceCorporatePoolViewModel service = ServiceCorporatePoolViewModel();
    await service.deleteService(widget.servicePoolModel);
    Utils.navigateToPage(context, AdminCorporateServicePoolManager());
  }
}
