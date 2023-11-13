import 'package:flutter/material.dart';

class DepositProvider extends ChangeNotifier {
  int? _amount;
  int? _cardId;

  int? get amount => _amount;
  int? get cardId => _cardId;

  set amount(int? amount) {
    _amount = amount;
  }

  set cardId(int? cardId) {
    _cardId = cardId;
  }
}
