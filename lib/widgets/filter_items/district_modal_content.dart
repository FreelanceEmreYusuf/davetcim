import 'package:davetcim/shared/models/district_model.dart';
import 'package:flutter/material.dart';
import '../../shared/models/region_model.dart';
import '../../shared/sessions/organization_items_state.dart';
import '../../shared/sessions/organization_type_state.dart';
import '../../src/search/search_view_model.dart';

class DistrictModalContent extends StatefulWidget {
  @override
  _DistrictModalContentState createState() => _DistrictModalContentState();
}

class _DistrictModalContentState extends State<DistrictModalContent> {
  List<DistrictModel> districtList = [];

  void firstInitialDistrict() async {
    List<RegionModel> regionList = OrganizationItemsState.regionModelList;
    if (regionList != null && regionList.length > 0) {
      SearchViewModel rm = SearchViewModel();
      districtList = await rm.fillDistrictlist(regionList[0].id);
      OrganizationTypeState.setDistrict(districtList);

      setState(() {
        districtList = districtList;
      });
    } else {
      firstInitialDistrict();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (OrganizationTypeState.isDistrictPresent()) {
      districtList = OrganizationTypeState.districtList;
    } else {
      firstInitialDistrict();
    }

    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Text(
              "İlçeler",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.5),
            ),
          ),
          SizedBox(height: 10),
          Expanded( // ListView.builder'ı Expanded ile sarmalama
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: districtList.length,
              itemBuilder: (BuildContext context, int index) {
                return CheckboxListTile(
                  title: Text(districtList[index].name),
                  value: districtList[index].isChecked ?? false,
                  onChanged: (bool value) {
                    if (districtList[index].id.toString().endsWith("00")) {
                      for (int i = 0; i < districtList.length; i++) {
                        districtList[i].isChecked = value;
                      }
                      OrganizationTypeState.setDistrict(districtList);
                      setState(() {
                        districtList = districtList;
                      });
                    } else {
                      OrganizationTypeState.setDistrict(districtList);
                      setState(() {
                        districtList[index].isChecked = value;
                        if (!value) {
                          districtList[0].isChecked = value;
                        }
                      });
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

