import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WithdrawProvider extends ChangeNotifier {
  int? _amount;
  int? _localBankId;

  int? get amount => _amount;
  int? get localBankId => _localBankId;

  set amount(int? amount) {
    _amount = amount;
  }

  set localBankId(int? localBankId) {
    _localBankId = localBankId;
  }
}
