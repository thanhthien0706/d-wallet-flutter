import 'package:cn1_d_wallet/models/local-bank.dart';
import 'package:cn1_d_wallet/models/pagination.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/local-bank-service.dart';

class LocalBankProvider extends ChangeNotifier {
  PaginationModel<LocalBankModel>? _localBankModel;

  PaginationModel<LocalBankModel>? get localBankModel => _localBankModel;

  set addBank(LocalBankModel newBank) {
    _localBankModel!.data.add(newBank);
    notifyListeners();
  }

// call api để lấy danh sách local bank
  Future<void> fetchLocalBank(
      BuildContext context, SharedPreferences prefs) async {
    try {
      PaginationModel<LocalBankModel>? localBankModels =
          await LocalBankService(context: context, prefs: prefs)
              .getAllLocalBank();
      if (localBankModels != null) {
        _localBankModel = localBankModels;
        notifyListeners();
      } else {
        fetchLocalBank(context, prefs);
        // throw Exception('Failed to load item card');
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
