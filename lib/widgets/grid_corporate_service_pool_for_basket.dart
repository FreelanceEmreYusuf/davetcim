import 'package:davetcim/shared/sessions/user_basket_session.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../shared/dto/basket_user_model.dart';
import '../shared/models/service_corporate_pool_model.dart';
import '../shared/models/service_pool_model.dart';
import '../shared/utils/dialogs.dart';
import '../shared/utils/language.dart';
import '../shared/utils/utils.dart';
import '../src/admin_corporate_panel/service/service-corporate_view_model.dart';
import '../src/admin_corporate_panel/service/service_corporate_add_view.dart';
import '../src/admin_corporate_panel/service/service_corporate_update_view.dart';
import '../src/admin_corporate_panel/service/service_corporate_view.dart';

class GridCorporateServicePoolForBasket extends StatefulWidget {
  final ServicePoolModel servicePoolModel;
  BasketUserModel basketModel;

  GridCorporateServicePoolForBasket({
    Key key,
    @required this.servicePoolModel,
    @required this.basketModel,
  }) : super(key: key);

  @override
  _GridCorporateServicePoolForBasketState createState() =>
      _GridCorporateServicePoolForBasketState();
}

class _GridCorporateServicePoolForBasketState
    extends State<GridCorporateServicePoolForBasket> {

  bool buffer = true;
  int totalPrice = 0;
  String buttonText = "Ekle";
  String priceChangeForCount = "Evet";
  Color buttonColor = Colors.green;
  Color textColor = Colors.red;
  IconData buttonIcon = Icons.add;
  @override
  Widget build(BuildContext context) {
    if (!widget.servicePoolModel.hasChild) {
      for(int i = 0; i < UserBasketSession.servicePoolModel.length; i++) {
        if (widget.servicePoolModel.id == UserBasketSession.servicePoolModel[i].id) {
          buffer = false;
          buttonText= "Çıkar";
          buttonColor = Colors.red;
          buttonIcon = Icons.delete_rounded;
          textColor = Colors.green;
          break;
        }
      }
    }

    double _paddingLeftValue = 0;
    if(widget.servicePoolModel.serviceName.substring(0,1) == "-"){
      _paddingLeftValue = MediaQuery.of(context).size.height / 70;
    }
    if(widget.servicePoolModel.serviceName.substring(0,2) == "--"){
      _paddingLeftValue = MediaQuery.of(context).size.height / 45;
    }
    if(widget.servicePoolModel.serviceName.substring(0,3) == "---"){
      _paddingLeftValue = MediaQuery.of(context).size.height / 30;
    }
    if(widget.servicePoolModel.serviceName.substring(0,4) == "----"){
      _paddingLeftValue = MediaQuery.of(context).size.height / 20;
    }

    Row row;
    if(!widget.servicePoolModel.hasChild){
      if (widget.servicePoolModel.companyHasService) {

        totalPrice = widget.servicePoolModel.corporateDetail.price * widget.basketModel.orderBasketModel.count;
        if (!widget.servicePoolModel.corporateDetail.priceChangedForCount) {
          totalPrice = widget.servicePoolModel.corporateDetail.price;
          priceChangeForCount = "Hayır";
        }

        row = Row(
          children: [
            Text(
                widget.servicePoolModel.serviceName, style: TextStyle(fontSize: 18, color: textColor, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),
            Spacer(),
            SizedBox.fromSize(
              size: Size(MediaQuery.of(context).size.height / 10, MediaQuery.of(context).size.height / 10), // button width and height
              child: ClipPath(
                child: Material(
                  color: Colors.grey, // button color
                  child: InkWell(
                    splashColor: Colors.deepOrangeAccent, // splash color
                    onTap: () async {
                      Dialogs.showAlertMessageWithAction(
                          context,
                          widget.servicePoolModel.serviceName,
                          //TODO: hizmet için fiyat bilgileri girilecek
                          "Belirtmiş olduğunuz davetli sayısı : "+widget.basketModel.orderBasketModel.count.toString()
                              +"\n\nÜcret kişi sayısına bağlı değişir mi? : "+ priceChangeForCount
                              +"\n\nHizmetin birim ücreti : "+ widget.servicePoolModel.corporateDetail.price.toString()+ "TL"
                              "\n\nKişi sayısına göre toplam ücret : "+
                              totalPrice.toString() + "TL",
                          null);
                    }, // button pressed
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.info_outline, color: Colors.white), // icon
                        Text("Bilgi", style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox.fromSize(
              size: Size(MediaQuery.of(context).size.height / 10, MediaQuery.of(context).size.height / 10), // button width and height
              child: ClipPath(
                child: Material(
                  color: buttonColor, // button color
                  child: InkWell(
                    splashColor: Colors.deepOrangeAccent, // splash color
                    onTap: () async {
                      //TODO: ekle çıkar butonlarının onclik işlemleri burada yapılacak
                      setState(() {
                        if(buffer==true){
                          //hizmet sepete eklenmiş, hizmeti sepetten çıkardığımız if durumu
                          buttonText= "Çıkar";
                          buttonColor = Colors.red;
                          buttonIcon = Icons.delete_rounded;
                          textColor = Colors.green;
                          UserBasketSession.servicePoolModel.add(widget.servicePoolModel);
                        }else{
                          //hizmet sepete eklenmemiş, hizmeti sepete eklediğimiz if durumu
                          buttonText= "Ekle";
                          buttonColor = Colors.green;
                          buttonIcon = Icons.add;
                          textColor = Colors.red;
                          UserBasketSession.servicePoolModel.remove(widget.servicePoolModel);
                        }
                        buffer = !buffer;
                      });

                    }, // button pressed
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(buttonIcon, color: Colors.white), // icon
                        Text(buttonText, style: TextStyle(color: Colors.white)),
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
          Text(
              widget.servicePoolModel.serviceName, style: TextStyle(fontSize: 20, color: Colors.black, fontStyle: FontStyle.italic,fontWeight: FontWeight.bold)),
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
