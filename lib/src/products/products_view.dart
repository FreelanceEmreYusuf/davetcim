import 'package:davetcim/shared/models/corporation_model.dart';
import 'package:davetcim/src/products/products_view_model.dart';
import 'package:flutter/material.dart';
import 'package:davetcim/widgets/grid_product.dart';

import '../../shared/helpers/parameters_helper.dart';
import '../../shared/models/paramters_model.dart';
import '../../shared/sessions/prooduct_view_state.dart';
import '../../shared/sessions/user_state.dart';
import '../../widgets/app_bar/app_bar_view.dart';
import '../../widgets/indicator.dart';
import '../../widgets/no_found_notification_screen.dart';

class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
  final List<CorporationModel> corporationInputList;
  const ProductsScreen(this.corporationInputList);
}

class _ProductsScreenState extends State<ProductsScreen>  {
  ScrollController _scrollController = ScrollController();

  List<CorporationModel> corporationList = [];
  List<CorporationModel> corporationViewList = [];
  bool hasDataTaken = false;

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    getCorporationList();
    super.initState();
  }

  Future getCorporationList() async {
    if (widget.corporationInputList != null) {
      corporationList = widget.corporationInputList;
    } else {
      ProductsViewModel mdl = new ProductsViewModel();
      corporationList = await mdl.getCorporationList();
    }

    int pagingSize = 20;
    ParametersHelper parametersHelper = ParametersHelper();
    ParametersModel parametersModel = await parametersHelper.getParametersData();
    if (parametersHelper != null) {
      pagingSize = parametersModel.pagingSize;
    }

    ProductsViewState.set(corporationList, pagingSize);
    corporationViewList = ProductsViewState.getNextList();

    setState(() {
      corporationViewList = corporationViewList;
      hasDataTaken = true;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      // Eğer ListView'in sonuna ulaşıldıysa
      _loadMoreData();
    }
  }

  Future<void> _loadMoreData() async {
    // Daha fazla veri yükleme işlemini burada gerçekleştirin
    corporationViewList.addAll(ProductsViewState.getNextList());
    setState(() {
      corporationViewList = corporationViewList;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!hasDataTaken) {
      return Scaffold(
        appBar: AppBarMenu(
          pageName: "Mekanlar",
          isHomnePageIconVisible: true,
          isNotificationsIconVisible: true,
          isPopUpMenuActive: true,
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
          child: Center(
            child: Indicator(),
          ),
        ),
      );
    }

    Widget body = null;
    if(corporationViewList.isEmpty || corporationViewList.length == 0){
      body = Scaffold(
        appBar: AppBarMenu(
          pageName: "Mekanlar",
          isHomnePageIconVisible: true,
          isNotificationsIconVisible: true,
          isPopUpMenuActive: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: Center(
            child: NoFoundDataScreen(keyText: "Aradığınız kireterlere uygun mekan bulunamadı."),
          )
        ),
      );
    }
    else{
      body = Scaffold(
        appBar: AppBarMenu(
          pageName: "Mekanlar",
          isHomnePageIconVisible: true,
          isNotificationsIconVisible: true,
          isPopUpMenuActive: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: ListView(
            controller: _scrollController, // ScrollController'ı ListView'e atama
            children: <Widget>[
              GridView.builder(
                shrinkWrap: true,
                primary: false,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 1.15),
                ),
                itemCount: corporationViewList == null
                    ? 0
                    : corporationViewList.length,
                itemBuilder: (BuildContext context, int index) {
                  CorporationModel item = corporationViewList[index];
                  return GridProduct(
                    img: item.imageUrl,
                    isFav: UserState.isCorporationFavorite(item.corporationId),
                    name: item.corporationName,
                    rating: item.averageRating,
                    raters: item.ratingCount,
                    description: item.description,
                    corporationId: item.corporationId,
                    maxPopulation: item.maxPopulation,
                  );
                },
              ),
            ],
          ),
        ),
      );
    }

    return body;
  }
}