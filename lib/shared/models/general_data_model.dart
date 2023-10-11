import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class GeneralDataModel {
  final int id;
  final String title;
  final String subtitle;
  final String title2;
  final String subtitle2;
  final String title3;
  final String subtitle3;
  final String title4;
  final String subtitle4;
  final String title5;
  final String subtitle5;

  GeneralDataModel({
    this.id,
    this.title,
    this.subtitle,
    this.title2,
    this.subtitle2,
    this.title3,
    this.subtitle3,
    this.title4,
    this.subtitle4,
    this.title5,
    this.subtitle5,
  });

  ///Object to map
  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'subtitle': subtitle,
    'title2': title2,
    'subtitle2': subtitle2,
    'title3': title3,
    'subtitle3': subtitle3,
    'title4': title4,
    'subtitle4': subtitle4,
    'title5': title5,
    'subtitle5': subtitle5,
  };

  ///Map to object
  factory GeneralDataModel.fromMap(Map map) => GeneralDataModel(
    id: map['id'],
    title: map['title'],
    subtitle: map['subtitle'],
    title2: map['title2'],
    subtitle2: map['subtitle2'],
    title3: map['title3'],
    subtitle3: map['subtitle3'],
    title4: map['title4'],
    subtitle4: map['subtitle4'],
    title5: map['title5'],
    subtitle5: map['subtitle5'],
  );
}
