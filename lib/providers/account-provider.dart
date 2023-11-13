import 'dart:convert';

import 'package:cn1_d_wallet/common/values/share-key.dart';
import 'package:cn1_d_wallet/models/users/account.model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountProvider extends ChangeNotifier {
  AccountModel _account = AccountModel();

  AccountModel get accountModel => _account;

  set allAccount(SharedPreferences prefs) {
    final accountDataJson = prefs.getString(ShareKey.INFOR_USER);
    _account = AccountModel.fromJson(jsonDecode(accountDataJson!));
  }
}
