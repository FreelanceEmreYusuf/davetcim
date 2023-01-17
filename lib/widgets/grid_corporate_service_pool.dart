import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../shared/models/service_corporate_pool_model.dart';
import '../shared/models/service_pool_model.dart';
import '../shared/utils/dialogs.dart';
import '../shared/utils/language.dart';
import '../shared/utils/utils.dart';
import '../src/admin_corporate_panel/service/service-corporate_view_model.dart';
import '../src/admin_corporate_panel/service/service_corporate_add_view.dart';
import '../src/admin_corporate_panel/service/service_corporate_update_view.dart';
import '../src/admin_corporate_panel/service/service_corporate_view.dart';

class GridCorporateServicePool extends StatefulWidget {
  final ServicePoolModel servicePoolModel;

  GridCorporateServicePool({
    Key key,
    @required this.servicePoolModel,
  }) : super(key: key);

  @override
  _GridCorporateServicePoolState createState() =>
      _GridCorporateServicePoolState();
}

class _GridCorporateServicePoolState
    extends State<GridCorporateServicePool> {
  @override
  Widget build(BuildContext context) {
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
        row = Row(
          children: [
            Text(
                widget.servicePoolModel.serviceName, style: TextStyle(fontSize: 18, color: Colors.green, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),
            Spacer(),
            SizedBox.fromSize(
              size: Size(MediaQuery.of(context).size.height / 10, MediaQuery.of(context).size.height / 10), // button width and height
              child: ClipPath(
                child: Material(
                  color: Colors.blue, // button color
                  child: InkWell(
                    splashColor: Colors.deepOrangeAccent, // splash color
                    onTap: () async{
                      //getServiceCorporateObject
                      ServiceCorporatePoolViewModel service = ServiceCorporatePoolViewModel();
                      ServiceCorporatePoolModel model = await service.getServiceCorporateObject(widget.servicePoolModel.id);
                      Utils.navigateToPage(context, ServiceCorporateUpdateView(serviceCorporatePoolModel : model));
                    }, // button pressed
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.update, color: Colors.white), // icon
                        Text("Güncelle", style: TextStyle(color: Colors.white)),
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
                  color: Colors.red, // button color
                  child: InkWell(
                    splashColor: Colors.deepOrangeAccent, // splash color
                    onTap: () async{
                      await Dialogs.showDialogMessage(
                          context,
                          LanguageConstants
                              .processApproveHeader[LanguageConstants.languageFlag],
                          LanguageConstants.processApproveDeleteMessage[
                          LanguageConstants.languageFlag],
                          deleteService, '');

                    }, // button pressed
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.delete, color: Colors.white), // icon
                        Text("Sil", style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      } else {
        row = Row(
          children: [
            Text(
                widget.servicePoolModel.serviceName, style: TextStyle(fontSize: 18, color: Colors.red, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),
            Spacer(),
            SizedBox.fromSize(
              size: Size(MediaQuery.of(context).size.height / 10, MediaQuery.of(context).size.height / 10), // button width and height
              child: ClipPath(
                child: Material(
                  color: Colors.green, // button color
                  child: InkWell(
                    splashColor: Colors.deepOrangeAccent, // splash color
                    onTap: () async {
                     Utils.navigateToPage(context, ServiceCorporateAddView(servicePoolModel: widget.servicePoolModel));
                    }, // button pressed
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.add, color: Colors.white), // icon
                        Text("Ekle", style: TextStyle(color: Colors.white)),
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
