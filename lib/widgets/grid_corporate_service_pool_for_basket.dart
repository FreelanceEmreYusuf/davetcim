import 'package:davetcim/shared/sessions/user_basket_state.dart';
import 'package:flutter/material.dart';
import '../shared/helpers/general_helper.dart';
import '../shared/models/service_pool_model.dart';
import '../shared/utils/dialogs.dart';
import '../shared/utils/utils.dart';
import '../src/admin_corporate_panel/service/service_corporate_user_choose/service-corporate_view_model.dart';
import '../src/admin_corporate_panel/service/service_corporate_user_choose/service_corporate_view.dart';

class GridCorporateServicePoolForBasket extends StatefulWidget {
  final ServicePoolModel servicePoolModel;

  GridCorporateServicePoolForBasket({
    Key key,
    @required this.servicePoolModel,
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
      for(int i = 0; i < UserBasketState.servicePoolModel.length; i++) {
        if (widget.servicePoolModel.id == UserBasketState.servicePoolModel[i].id) {
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

    Widget row;
    if(!widget.servicePoolModel.hasChild){
      if (widget.servicePoolModel.companyHasService) {

        totalPrice = widget.servicePoolModel.corporateDetail.price *
            UserBasketState.userBasket.orderBasketModel.count;
        if (!widget.servicePoolModel.corporateDetail.priceChangedForCount) {
          totalPrice = widget.servicePoolModel.corporateDetail.price;
          priceChangeForCount = "Hayır";
        }

        row = InkWell(
          onTap: () async {
            Dialogs.showInfoModalContent(
                context,
                widget.servicePoolModel.serviceName,
                //TODO: hizmet için fiyat bilgileri girilecek
                "Belirtmiş olduğunuz davetli sayısı : "+ UserBasketState.userBasket.orderBasketModel.count.toString()
                    +"\n\nÜcret kişi sayısına bağlı değişir mi? : "+ priceChangeForCount
                    +"\n\nHizmetin birim ücreti : "+ GeneralHelper.formatMoney(widget.servicePoolModel.corporateDetail.price.toString())+ "TL"
                    "\n\nToplam ücret : "+
                    GeneralHelper.formatMoney(totalPrice.toString()) + "TL",
                null);
          },
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Container(
              color: Colors.white24,
              child: Row(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.info, color: Colors.orange),
                      ),
                      Text(
                        GeneralHelper.removeLeadingHyphens(widget.servicePoolModel.serviceName), style: TextStyle(fontSize: 18, color: textColor, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Spacer(),
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
                                UserBasketState.servicePoolModel.add(widget.servicePoolModel);
                              }else{
                                //hizmet sepete eklenmemiş, hizmeti sepete eklediğimiz if durumu
                                buttonText= "Ekle";
                                buttonColor = Colors.green;
                                buttonIcon = Icons.add;
                                textColor = Colors.red;
                                //UserBasketSession.servicePoolModel.remove(widget.servicePoolModel);
                                List<ServicePoolModel> listTemp = [];
                                for (int i = 0; i < UserBasketState.servicePoolModel.length; i++) {
                                  if (UserBasketState.servicePoolModel[i].id != widget.servicePoolModel.id) {
                                    listTemp.add(UserBasketState.servicePoolModel[i]);
                                  }
                                }
                                UserBasketState.servicePoolModel = listTemp;
                              }
                              buffer = !buffer;
                            });

                          }, // button pressed
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(child: Icon(buttonIcon, color: Colors.white)), // icon
                              Expanded(child: Text(buttonText, style: TextStyle(color: Colors.white))),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    } else {
      row = Row(
        children: [
          FittedBox(
            child: Text(
                widget.servicePoolModel.serviceName, style: TextStyle(fontSize: 20, color: Colors.black, fontStyle: FontStyle.italic,fontWeight: FontWeight.bold)),
          ),
        ],
      );
    }

    return row;
  }
  Future<void> deleteService() async {
    ServiceCorporatePoolViewModel service = ServiceCorporatePoolViewModel();
    await service.deleteService(widget.servicePoolModel);
    Utils.navigateToPage(context, AdminCorporateServicePoolManager());
  }

}
