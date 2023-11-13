import 'package:cn1_d_wallet/models/users/account.model.dart';
import 'package:flutter/material.dart';

class SignupProvider extends ChangeNotifier {
  AccountModel _account = AccountModel(email: "", name: "", password: "");

  AccountModel get accountModel => _account;

  set email(String value) {
    _account.email = value;
    notifyListeners();
  }

  set name(String value) {
    _account.name = value;
    notifyListeners();
  }

  set password(String value) {
    _account.password = value;
    notifyListeners();
  }
}
