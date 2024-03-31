import 'package:flutter/material.dart';
import '../../shared/models/organization_type_model.dart';
import '../../shared/sessions/organization_items_state.dart';
import '../../shared/sessions/organization_type_state.dart';

class OrganizationModalContent extends StatefulWidget {
  @override
  _OrganizationModalContentState createState() => _OrganizationModalContentState();
}

class _OrganizationModalContentState extends State<OrganizationModalContent> {
  List<OrganizationTypeModel> organizationTypeList = OrganizationItemsState.organizationTypeList;

  @override
  Widget build(BuildContext context) {
    if (OrganizationTypeState.isOrganizationPresent()) {
      organizationTypeList = OrganizationTypeState.organizationTypeList;
    }
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Mekan Türü",
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Expanded( // ListView.builder'ı Expanded ile sarmalama
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: organizationTypeList.length,
              itemBuilder: (BuildContext context, int index) {
                return CheckboxListTile(
                  title: Text(organizationTypeList[index].name),
                  value: organizationTypeList[index].isChecked ?? false,
                  onChanged: (bool value) {
                    if (organizationTypeList[index].id == 0) {
                      for (int i = 0; i < organizationTypeList.length; i++) {
                        organizationTypeList[i].isChecked = value;
                      }
                      OrganizationTypeState.setOrganization(organizationTypeList);
                      setState(() {
                        organizationTypeList = organizationTypeList;
                      });
                    } else {
                      OrganizationTypeState.setOrganization(organizationTypeList);
                      setState(() {
                        organizationTypeList[index].isChecked = value;
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

