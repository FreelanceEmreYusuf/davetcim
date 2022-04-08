import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CustomerDetailModel {
  const CustomerDetailModel(
      this.id, this.name, this.surname, this.gsm, this.email, this.childPage);

  final int id;
  final String name;
  final String surname;
  final String gsm;
  final String email;
  final Widget childPage;
}
