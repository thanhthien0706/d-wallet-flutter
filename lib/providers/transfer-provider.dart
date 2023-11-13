import 'package:cn1_d_wallet/models/users/account.model.dart';
import 'package:flutter/material.dart';

class TransferProvider extends ChangeNotifier {
  AccountModel? _accountModel;
  int _amount = 0;
  String _notes = "";

  AccountModel? get accountModel => _accountModel;

  int get getAmount => _amount;

  String get getNotes => _notes;

  set account(AccountModel account) {
    _accountModel = account;
    notifyListeners();
  }

  set amount(int amount) {
    _amount = amount;
  }

  set notes(String notes) {
    _notes = notes;
  }
}
