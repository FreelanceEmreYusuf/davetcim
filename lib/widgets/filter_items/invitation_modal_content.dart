import 'package:davetcim/shared/models/invitation_type_model.dart';
import 'package:flutter/material.dart';
import '../../shared/sessions/organization_items_state.dart';
import '../../shared/sessions/organization_type_state.dart';

class InvitationModalContent extends StatefulWidget {
  @override
  _InvitationModalContentState createState() => _InvitationModalContentState();
}

class _InvitationModalContentState extends State<InvitationModalContent> {
  List<InvitationTypeModel> invitationTypeList = OrganizationItemsState.invitationTypeList;

  @override
  Widget build(BuildContext context) {
    if (OrganizationTypeState.isInvitationPresent()) {
      invitationTypeList = OrganizationTypeState.invitationTypeList;
    }
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Text(
              "Davet Türü",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.5),
            ),
          ),
          SizedBox(height: 10),
          Expanded( // ListView.builder'ı Expanded ile sarmalama
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: invitationTypeList.length,
              itemBuilder: (BuildContext context, int index) {
                return CheckboxListTile(
                  title: Text(invitationTypeList[index].name),
                  value: invitationTypeList[index].isChecked ?? false,
                  onChanged: (bool value) {
                    if (invitationTypeList[index].id == 0) {
                      for (int i = 0; i < invitationTypeList.length; i++) {
                        invitationTypeList[i].isChecked = value;
                      }
                      OrganizationTypeState.setInvitation(invitationTypeList);
                      setState(() {
                        invitationTypeList = invitationTypeList;
                      });
                    } else {
                      OrganizationTypeState.setInvitation(invitationTypeList);
                      setState(() {
                        invitationTypeList[index].isChecked = value;
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

