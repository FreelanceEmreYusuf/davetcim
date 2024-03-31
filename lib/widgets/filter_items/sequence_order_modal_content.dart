import 'package:davetcim/shared/models/sequence_order_model.dart';
import 'package:flutter/material.dart';
import '../../shared/sessions/organization_items_state.dart';
import '../../shared/sessions/organization_type_state.dart';

class SequenceOrderModalContent extends StatefulWidget {
  @override
  _SequenceOrderModalContentState createState() => _SequenceOrderModalContentState();
}

class _SequenceOrderModalContentState extends State<SequenceOrderModalContent> {
  List<SequenceOrderModel> sequenceOrderList = OrganizationItemsState.sequenceOrderList;

  @override
  Widget build(BuildContext context) {
    if (OrganizationTypeState.isSequenceOrderPresent()) {
      sequenceOrderList = OrganizationTypeState.sequenceOrderList;
    }
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Oturma Düzeni",
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Expanded( // ListView.builder'ı Expanded ile sarmalama
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: sequenceOrderList.length,
              itemBuilder: (BuildContext context, int index) {
                return CheckboxListTile(
                  title: Text(sequenceOrderList[index].name),
                  value: sequenceOrderList[index].isChecked ?? false,
                  onChanged: (bool value) {
                    if (sequenceOrderList[index].id == 0) {
                      for (int i = 0; i < sequenceOrderList.length; i++) {
                        sequenceOrderList[i].isChecked = value;
                      }
                      OrganizationTypeState.setSequenceOrder(sequenceOrderList);
                      setState(() {
                        sequenceOrderList = sequenceOrderList;
                      });
                    } else {
                      OrganizationTypeState.setSequenceOrder(sequenceOrderList);
                      setState(() {
                        sequenceOrderList[index].isChecked = value;
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

