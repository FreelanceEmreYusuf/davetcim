import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../shared/models/service_pool_model.dart';
import '../shared/utils/utils.dart';
import '../src/admin_panel/service/service_add_view.dart';
import '../src/admin_panel/service/service_view.dart';
import '../src/admin_panel/service/service_view_model.dart';

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
    if(widget.servicePoolModel.serviceName.substring(0,2) == "--"){
      _paddingLeftValue = MediaQuery.of(context).size.height / 50;
    }
    if(widget.servicePoolModel.serviceName.substring(0,3) == "---"){
      _paddingLeftValue = MediaQuery.of(context).size.height / 25;
    }
    if(widget.servicePoolModel.serviceName.substring(0,4) == "---"){
      _paddingLeftValue = MediaQuery.of(context).size.height / 20;
    }

    Row row;
    if(!widget.servicePoolModel.hasChild){
      if (widget.servicePoolModel.companyHasService) {
        row = Row(
          children: [
            Text(
                widget.servicePoolModel.serviceName, style: TextStyle(fontSize: 18, color: Colors.green, fontStyle: FontStyle.italic)),
            Spacer(flex: 25,),
            SizedBox.fromSize(
              size: Size(MediaQuery.of(context).size.height / 25, MediaQuery.of(context).size.height / 25), // button width and height
              child: ClipOval(
                child: Material(
                  color: Colors.red, // button color
                  child: InkWell(
                    splashColor: Colors.green, // splash color
                    onTap: () {
                      Utils.navigateToPage(context, ServiceAddView(servicePoolModel : widget.servicePoolModel));
                    }, // button pressed
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.update, color: Colors.white), // icon
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Spacer(flex: 1),
            SizedBox.fromSize(
              size: Size(MediaQuery.of(context).size.height / 25, MediaQuery.of(context).size.height / 25), // button width and height
              child: ClipOval(
                child: Material(
                  color: Colors.red, // button color
                  child: InkWell(
                    splashColor: Colors.lightBlue, // splash color
                    onTap: () async{
                      ServicePoolViewModel service = ServicePoolViewModel();
                      await service.deleteService(widget.servicePoolModel);
                      Utils.navigateToPage(context, AdminServicePoolManager());
                    }, // button pressed
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.delete, color: Colors.white), // icon
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      } else {
        row = Row(
          children: [
            Text(
                widget.servicePoolModel.serviceName, style: TextStyle(fontSize: 18, color: Colors.red, fontStyle: FontStyle.italic)),
            Spacer(),
            SizedBox.fromSize(
              size: Size(MediaQuery.of(context).size.height / 25, MediaQuery.of(context).size.height / 25), // button width and height
              child: ClipOval(
                child: Material(
                  color: Colors.red, // button color
                  child: InkWell(
                    splashColor: Colors.lightBlue, // splash color
                    onTap: () {}, // button pressed
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.add, color: Colors.white), // icon
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
              widget.servicePoolModel.serviceName, style: TextStyle(fontSize: 20, color: Colors.red, fontStyle: FontStyle.italic,fontWeight: FontWeight.bold)),
        ],
      );
    }

    return Container(
      padding: EdgeInsets.only(left: _paddingLeftValue),
      decoration: BoxDecoration(
          color: Colors.white12,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              alignment: Alignment.centerLeft,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            child: row,
          ),
        ],
      ),
    );
  }


}
