import 'dart:convert';

import 'package:cn1_d_wallet/models/balance-history.dart';
import 'package:cn1_d_wallet/services/auth-service.dart';
import 'package:cn1_d_wallet/services/bases/header-endpoint.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../common/constant/app_endpoint.dart';

class BalanceService {
  final BuildContext? context;
  final SharedPreferences? prefs;

  BalanceService({this.context, this.prefs});

  Future<BalanceHistoryModel?> getBalanceHistory() async {
    try {
      Uri url = Uri.parse(AppEndpoint.balanceEndpoint);

      var response = await http.get(url,
          headers:
              HeaderEndpointService.getStaticAccessTokenBaseEndpoint(prefs!));

      var dataReponse = jsonDecode(response.body) as Map;

      if (dataReponse["statusCode"] == 401) {
        bool? refreshToken = await AuthService(context: context!, prefs: prefs!)
            .getRefreshToken();
        refreshToken! ? getBalanceHistory() : null;

        return null;
      }

      return BalanceHistoryModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      print("Error : $e");
    }
  }
}
