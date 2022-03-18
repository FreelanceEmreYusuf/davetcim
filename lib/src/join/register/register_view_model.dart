import 'package:davetcim/shared/models/customer_model.dart';
import 'package:davetcim/shared/services/database.dart';
import 'package:flutter/cupertino.dart';

class RegisterViewModel extends ChangeNotifier {
  Database db = Database();

  Future<void> createCustomer(
      String _usernameControl,
      String _emailControl,
      String _passwordControl,
      String _phoneControl,
      String _nameControl,
      String _surnameControl) async {
    Customer _customer = new Customer(
      username: _usernameControl,
      id: new DateTime.now().millisecondsSinceEpoch,
      corporationId: 1,
      gsmNo: _phoneControl,
      isActive: true,
      name: _nameControl,
      password: _passwordControl,
      roleId: 2,
      surname: _surnameControl,
      eMail: _emailControl,
    );

    db.addCollectionRef("Customer", _customer.toMap());
  }
}
