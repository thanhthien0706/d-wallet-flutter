import 'dart:convert';

import 'package:cn1_d_wallet/common/constant/app_endpoint.dart';
import 'package:cn1_d_wallet/models/local-bank.dart';
import 'package:cn1_d_wallet/models/pagination.dart';
import 'package:cn1_d_wallet/services/bases/header-endpoint.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'auth-service.dart';

class LocalBankService {
  final BuildContext? context;
  final SharedPreferences? prefs;

  LocalBankService({this.context, this.prefs});

  Future<PaginationModel<LocalBankModel>?> getAllLocalBank() async {
    try {
      Uri url = Uri.parse(AppEndpoint.localBankEndpoint + "findallLocalbank");

      var response = await http.get(
        url,
        headers: HeaderEndpointService.getStaticAccessTokenBaseEndpoint(prefs!),
      );

      var dataReponse = jsonDecode(response.body) as Map;

      if (dataReponse["statusCode"] == 401) {
        bool? refreshToken = await AuthService(context: context!, prefs: prefs!)
            .getRefreshToken();
        refreshToken! ? getAllLocalBank() : null;

        return null;
      }

      final banks = List<LocalBankModel>.from(
          dataReponse["data"].map((card) => LocalBankModel.fromJson(card)));
      return PaginationModel<LocalBankModel>(
          data: banks, total: dataReponse["total"]);
    } catch (e) {
      print("Error : $e");
    }
  }

  Future<LocalBankModel?> createLocalBank(LocalBankModel localBankModel) async {
    try {
      Uri url = Uri.parse(AppEndpoint.localBankDefaultEndpoint);

      var response = await http.post(url,
          headers:
              HeaderEndpointService.getStaticAccessTokenBaseEndpoint(prefs!),
          body: jsonEncode(localBankModel.toJson()));

      var dataReponse = jsonDecode(response.body) as Map;

      if (dataReponse["statusCode"] == 401) {
        bool? refreshToken = await AuthService(context: context!, prefs: prefs!)
            .getRefreshToken();
        refreshToken! ? createLocalBank(localBankModel) : null;

        return null;
      }

      return LocalBankModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      print("Error : $e");
    }
  }
}
