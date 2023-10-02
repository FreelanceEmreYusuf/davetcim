import 'package:davetcim/src/admin_panel/manage_lookups/manage_lookups_add_view.dart';
import 'package:flutter/material.dart';
import '../../../shared/models/combo_generic_identifier_model.dart';
import '../../../shared/models/generic_lookup_item_model.dart';
import '../../../shared/utils/utils.dart';
import '../../../widgets/app_bar/app_bar_view.dart';
import '../../../widgets/grid_lookup_item.dart';
import 'manage_lookups_view_model.dart';


class ManageLookupsView extends StatefulWidget {

  @override
  _ManageLookupsViewState createState() =>
      _ManageLookupsViewState();
}

class _ManageLookupsViewState extends State<ManageLookupsView> {
  List<ComboGenericIdentifierModel> lookupList = [];
  List<GenericLookupItemModel> itemList = [];
  ComboGenericIdentifierModel selectedLookup;

  @override
  void initState() {
    super.initState();
    fillLookupList();
  }

  void fillLookupList()  {
    ManageLookupsViewModel manageLookupsViewModel = ManageLookupsViewModel();
    lookupList = manageLookupsViewModel.getLookupList();

    setState(() {
      lookupList = lookupList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Utils.navigateToPage(context, LookupAddView(dbTable: selectedLookup.id));
        },
        label: Text('Yeni Ekle', style: TextStyle(fontSize: 15), maxLines: 2),
        icon: Icon(Icons.add_circle),
        backgroundColor: Colors.redAccent,
      ),
      appBar: AppBarMenu(pageName: "Salon Özellik Yönet", isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: ListView(
          children: <Widget>[
            Divider(),
            SizedBox(height: 10.0),
            DropdownButtonFormField(
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                labelText: "Özellik Seçiniz",
                filled: true,
                fillColor: Colors.white,
                focusColor: Colors.blue,
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
              isExpanded: true,
              value: selectedLookup,
              onChanged: (ComboGenericIdentifierModel newValue) async {
                ManageLookupsViewModel lookupHelper = ManageLookupsViewModel();
                itemList = await lookupHelper.getLookupTableList(newValue.id);
                setState(() {
                  selectedLookup = newValue;
                  itemList = itemList;
                });
              },
              items: lookupList.map((ComboGenericIdentifierModel item) {
                return new DropdownMenuItem<ComboGenericIdentifierModel>(
                  value: item,
                  child: new Text(
                    item.text,
                    style: new TextStyle(color: Colors.black),
                  ),
                );
              }).toList(),
            ),
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
              itemCount: itemList == null
                  ? 0
                  : itemList.length,
              itemBuilder: (BuildContext context, int index) {
                GenericLookupItemModel item = itemList[index];

                return GridLookupItem(lookupModel: item, dbTable: selectedLookup.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
