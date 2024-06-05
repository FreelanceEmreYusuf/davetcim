import 'package:davetcim/shared/helpers/corporate_helper.dart';
import 'package:davetcim/shared/models/corporation_model.dart';
import 'package:flutter/material.dart';
import '../../../shared/models/company_model.dart';
import '../../../widgets/app_bar/app_bar_view.dart';
import '../../../widgets/filter_items/search_company_box.dart';
import '../../../widgets/grid_corporate_active_passive.dart';
import '../corporation/corporation_generate_key_view_model.dart';


class CorporationActivePassiveView extends StatefulWidget {


  @override
  _CorporationActivePassiveViewState createState() =>
      _CorporationActivePassiveViewState();
}

class _CorporationActivePassiveViewState extends State<CorporationActivePassiveView> {
  List<CompanyModel> companyList = [];
  List<CorporationModel> corporationList = [];
  CompanyModel selectedCompany;
  CorporationModel selectedCorporation;

  @override
  void initState() {
    super.initState();
    callCompanyList();
  }

  void callCompanyList() async {
    CorporationGenerateKeyViewModel rm = CorporationGenerateKeyViewModel();
    companyList = await rm.fillCompanyList();

    setState(() {
      companyList = companyList;
    });
  }

  void onCompanyChanged(CompanyModel newValue) async {
    CorporateHelper corporateHelper = CorporateHelper();
    corporationList = await corporateHelper.getCorporateByCompany(newValue.id);
    setState(() {
      selectedCompany = newValue;
      corporationList = corporationList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMenu(pageName: "Firma Aktif/Pasif Yönet", isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.centerRight,
              colors:[Color.fromRGBO(233, 211, 98, 1.0),Color.fromARGB(203, 173, 109, 99),Color.fromARGB(51, 51, 51, 1),]
          ),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
          child: ListView(
            children: <Widget>[
              Divider(),
              SizedBox(height: 10.0),
              CompanySearchBox(companyList: companyList, method: onCompanyChanged),
              SizedBox(height: 20.0),
              GridView.builder(
                shrinkWrap: true,
                primary: false,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 12),
                ),
                itemCount: corporationList == null
                    ? 0
                    : corporationList.length,
                itemBuilder: (BuildContext context, int index) {
                  CorporationModel item = corporationList[index];

                  return GridCorporateActivePassive(corporationModel: item);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
