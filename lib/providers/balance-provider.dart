import 'package:cn1_d_wallet/models/balance-history.dart';
import 'package:cn1_d_wallet/services/balance-service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BalanceProvider extends ChangeNotifier {
  BalanceHistoryModel? _balanceHistoryModel;

  BalanceHistoryModel? get balanceHistoryModel => _balanceHistoryModel;

  set setBalanceHistory(BalanceHistoryModel balanceHistoryModel) {
    _balanceHistoryModel = balanceHistoryModel;
    notifyListeners();
  }

  Future<void> fetchBalanceHistory(
      BuildContext context, SharedPreferences prefs) async {
    BalanceHistoryModel? dataBalance =
        await BalanceService(context: context, prefs: prefs)
            .getBalanceHistory();
    if (dataBalance != null) {
      _balanceHistoryModel = dataBalance;
      notifyListeners();
    } else {
      fetchBalanceHistory(context, prefs);
    }
  }
}
