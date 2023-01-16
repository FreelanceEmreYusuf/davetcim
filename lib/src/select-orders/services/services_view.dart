import 'package:davetcim/shared/models/combo_generic_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../shared/dto/basket_user_model.dart';
import '../../../widgets/app_bar/app_bar_view.dart';
import '../properties/order_view_model.dart';

class ServicesScreen extends StatefulWidget {
  @override
  _ServicesScreenState createState() => _ServicesScreenState();
  final BasketUserModel basketModel;

  ServicesScreen(
      {Key key,
        @required this.basketModel,
      })
      : super(key: key);

}

class _ServicesScreenState extends State<ServicesScreen>
    with AutomaticKeepAliveClientMixin<ServicesScreen> {

  @override
  void initState() {
    // TODO: implement initState
    print("count :" + widget.basketModel.orderBasketModel.count.toString());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);


    return Scaffold(
      appBar: AppBarMenu(pageName: "Hizmetler", isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
      body: Container()
    );
  }

  @override
  bool get wantKeepAlive => true;
}
