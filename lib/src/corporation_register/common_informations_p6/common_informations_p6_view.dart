import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../shared/dto/corporation_registration_dto.dart';
import '../../../widgets/app_bar/app_bar_view.dart';
import 'common_informations_p6_view_model.dart';

class CommonInformationsP6View extends StatefulWidget {
  @override
  _CommonInformationsP6ViewState createState() => _CommonInformationsP6ViewState();
  final CorporationReservationDto corpReg;

  CommonInformationsP6View(
      {Key key,
        @required this.corpReg,
       })
      : super(key: key);
}

class _CommonInformationsP6ViewState extends State<CommonInformationsP6View> {
  @override
  void initState() {
  }

  @override
  Widget build(BuildContext contex){
    TextStyle textStyleTitle = TextStyle(fontSize: 22, color: Colors.black, fontStyle: FontStyle.normal,fontWeight: FontWeight.w700,);
    TextStyle textStyleText = TextStyle(fontSize: 20, color: Colors.black87, fontStyle: FontStyle.normal,fontWeight: FontWeight.w500,);
    return Scaffold(
      floatingActionButton:
          FloatingActionButton.extended(
            onPressed: () {
              CommonInformationsP6ViewModel model = CommonInformationsP6ViewModel();
              model.corporationRegisterFlow(context, widget.corpReg);
            },
            label: const Text('Onayla'),
            icon: const Icon(Icons.done),
            elevation: 20,
            backgroundColor: Colors.redAccent,
          ),
      appBar: AppBarMenu(pageName: "Özet", isHomnePageIconVisible: false, isNotificationsIconVisible: false, isPopUpMenuActive: true),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          elevation: 30,
          color: Colors.white60,
          shadowColor: Colors.redAccent,
          child: ListView(
    children: <Widget>[
          Card(
            color: Colors.redAccent,
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shadowColor: Colors.black,
            elevation: 10,
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                    " SALON BİLGİLERİ", style: TextStyle(fontSize: 23, color: Colors.white, fontStyle: FontStyle.normal,fontWeight: FontWeight.bold,)),
              ],
            ),
          ),
      SizedBox(height: MediaQuery.of(context).size.height / 50,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Text("Firma Adı", style: textStyleTitle, maxLines: 2, textAlign: TextAlign.start,)),
          Expanded(child: Text(widget.corpReg.companyModel.name, style: textStyleText, maxLines: 2, textAlign: TextAlign.center,)),
        ],
      ),
      Divider(indent: 2, color: Colors.black,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Text("Salon Adı", style: textStyleTitle, maxLines: 2, textAlign: TextAlign.start,)),
              Expanded(child: Text(widget.corpReg.corporationModel.corporationName, style: textStyleText, maxLines: 2, textAlign: TextAlign.center,)),
            ],
          ),
          Divider(indent: 2, color: Colors.black,),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: Text("Salon Açıklaması", style: textStyleTitle, maxLines: 2, textAlign: TextAlign.start,)),
                Expanded(child: Text(widget.corpReg.corporationModel.description, style: textStyleText, maxLines: 10, textAlign: TextAlign.center,)),
              ],
            ),
          Divider(indent: 2, color: Colors.black,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Text("Adres", style: textStyleTitle, maxLines: 2, textAlign: TextAlign.start,)),
          Expanded(child: Text(widget.corpReg.corporationModel.address, style: textStyleText, maxLines: 10, textAlign: TextAlign.center,)),
        ],
      ),
      Divider(indent: 2, color: Colors.black,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Text("Maximum Kapasite", style: textStyleTitle, maxLines: 2, textAlign: TextAlign.start,)),
          Expanded(child: Text(widget.corpReg.corporationModel.maxPopulation.toString(), style: textStyleText, maxLines: 10, textAlign: TextAlign.center,)),
        ],
      ),
      Divider(indent: 2, color: Colors.black,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Text("Telefon numarası", style: textStyleTitle, maxLines: 2, textAlign: TextAlign.start,)),
          Expanded(child: Text(widget.corpReg.corporationModel.telephoneNo, style: textStyleText, maxLines: 10, textAlign: TextAlign.center,)),
        ],
      ),
      Divider(indent: 2, color: Colors.black,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Text("Email adresi", style: textStyleTitle, maxLines: 2, textAlign: TextAlign.start,)),
          Expanded(child: Text(widget.corpReg.corporationModel.email, style: textStyleText, maxLines: 10, textAlign: TextAlign.center,)),
        ],
      ),
      Divider(indent: 2, color: Colors.black,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Text("İl", style: textStyleTitle, maxLines: 2, textAlign: TextAlign.start,)),
          Expanded(child: Text(widget.corpReg.regionName, style: textStyleText, maxLines: 10, textAlign: TextAlign.center,)),
        ],
      ),
      Divider(indent: 2, color: Colors.black,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Text("İlçe", style: textStyleTitle, maxLines: 2, textAlign: TextAlign.start,)),
          Expanded(child: Text(widget.corpReg.districtName, style: textStyleText, maxLines: 10, textAlign: TextAlign.center,)),
        ],
      ),
      Divider(indent: 2, color: Colors.black,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Text("Sunduğu Davet Türü Hizmetleri", style: textStyleTitle, maxLines: 3, textAlign: TextAlign.start,)),
          Expanded(child: Text(widget.corpReg.invitationTypes, style: textStyleText, maxLines: 10, textAlign: TextAlign.center,)),
        ],
      ),
      Divider(indent: 2, color: Colors.black,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Text("Salon Özellikleri", style: textStyleTitle, maxLines: 2, textAlign: TextAlign.start,)),
          Expanded(child: Text(widget.corpReg.organizationTypes, style: textStyleText, maxLines: 10, textAlign: TextAlign.center,)),
        ],
      ),
      Divider(indent: 2, color: Colors.black,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Text("Sunulan Masa Düzenleri ve Tipleri", style: textStyleTitle, maxLines: 3, textAlign: TextAlign.start,)),
          Expanded(child: Text(widget.corpReg.sequenceOrderTypes, style: textStyleText, maxLines: 10,textAlign: TextAlign.center,)),
        ],
      ),
      SizedBox(height: MediaQuery.of(context).size.height / 25,),
      Card(
        color: Colors.redAccent,
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shadowColor: Colors.black,
        elevation: 10,
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                  " SALON ADMİN KULLANICISI BİLGİLERİ", maxLines: 3, textAlign: TextAlign.center, style: TextStyle(fontSize: 23, color: Colors.white, fontStyle: FontStyle.normal,fontWeight: FontWeight.bold,)),
            ),
          ],
        ),
      ),
      SizedBox(height: MediaQuery.of(context).size.height / 50,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Text("İsim", style: textStyleTitle, maxLines: 3, textAlign: TextAlign.start,)),
          Expanded(child: Text(widget.corpReg.customerModel.name, style: textStyleText, maxLines: 10, textAlign: TextAlign.center,)),
        ],
      ),
      Divider(indent: 2, color: Colors.black,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Text("Soy İsim", style: textStyleTitle, maxLines: 3, textAlign: TextAlign.start,)),
          Expanded(child: Text(widget.corpReg.customerModel.surname, style: textStyleText, maxLines: 10, textAlign: TextAlign.center,)),
        ],
      ),
      Divider(indent: 2, color: Colors.black,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Text("Telefon", style: textStyleTitle, maxLines: 3, textAlign: TextAlign.start,)),
          Expanded(child: Text(widget.corpReg.customerModel.gsmNo, style: textStyleText, maxLines: 10, textAlign: TextAlign.center,)),
        ],
      ),
      Divider(indent: 2, color: Colors.black,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Text("Kullanıcı Adı", style: textStyleTitle, maxLines: 3, textAlign: TextAlign.start,)),
          Expanded(child: Text(widget.corpReg.customerModel.username, style: textStyleText, maxLines: 10, textAlign: TextAlign.center,)),
        ],
      ),
      Divider(indent: 2, color: Colors.black,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Text("Şifre", style: textStyleTitle, maxLines: 3, textAlign: TextAlign.start,)),
          Expanded(child: Text(widget.corpReg.customerModel.password, style: textStyleText, maxLines: 10, textAlign: TextAlign.center,)),
        ],
      ),
      Divider(indent: 2, color: Colors.black,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Text("Email Adresi", style: textStyleTitle, maxLines: 3, textAlign: TextAlign.start,)),
          Expanded(child: Text(widget.corpReg.customerModel.eMail, style: textStyleText, maxLines: 10, textAlign: TextAlign.center,)),
        ],
      ),
      Divider(indent: 2, color: Colors.black,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Text("Hesap Kurtarma Gizli Sorusu", style: textStyleTitle, maxLines: 3, textAlign: TextAlign.start,)),
          Expanded(child: Text(widget.corpReg.secretQuestionName, style: textStyleText, maxLines: 10, textAlign: TextAlign.center,)),
        ],
      ),
      Divider(indent: 2, color: Colors.black,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Text("Cevap", style: textStyleTitle, maxLines: 3, textAlign: TextAlign.start,)),
          Expanded(child: Text(widget.corpReg.customerModel.secretQuestionAnswer, style: textStyleText, maxLines: 10, textAlign: TextAlign.center,)),
        ],
      ),
      SizedBox(height: MediaQuery.of(context).size.height / 10,),
    ],),
        ),
      ),
    );
  }
}
