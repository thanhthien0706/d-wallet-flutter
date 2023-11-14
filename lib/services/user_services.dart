import 'dart:convert';

import 'package:cn1_d_wallet/common/constant/app_endpoint.dart';
import 'package:cn1_d_wallet/models/transactions/recent-user-transaction.dart';
import 'package:cn1_d_wallet/models/users/account.model.dart';
import 'package:cn1_d_wallet/services/auth-service.dart';
import 'package:cn1_d_wallet/services/bases/header-endpoint.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  final BuildContext? context;
  final SharedPreferences? prefs;

  UserService({this.context, this.prefs}) {}

  Future<bool?> checkEmailExist(String email) async {
    try {
      Uri url = Uri.parse(AppEndpoint.userEndpoint + "check-email");
      final finalUrl = url.replace(queryParameters: {
        "email": email,
      });

      var response = await http.get(
        finalUrl,
      );

      return jsonDecode(response.body);
    } catch (e) {
      print("Error : $e");
    }
  }

  Future<AccountModel?> getInformationUser() async {
    try {
      Uri url = Uri.parse(AppEndpoint.userEndpoint + "profile");

      var response = await http.get(url,
          headers:
              HeaderEndpointService.getStaticAccessTokenBaseEndpoint(prefs!));

      var dataReponse = jsonDecode(response.body) as Map;

      if (dataReponse["statusCode"] == 401) {
        bool? refreshToken = await AuthService(context: context!, prefs: prefs!)
            .getRefreshToken();
        refreshToken! ? getInformationUser() : null;

        return null;
      }

      return AccountModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      print("Error : $e");
    }
  }

  Future<AccountModel?> updateInformationUser(AccountModel accountModel) async {
    try {
      Uri url = Uri.parse(AppEndpoint.userEndpoint + "user_profile");

      var response = await http.patch(
        url,
        headers: HeaderEndpointService.getStaticAccessTokenBaseEndpoint(prefs!),
        body: json.encode(accountModel.toJson()),
      );

      var dataReponse = jsonDecode(response.body) as Map;
      if (dataReponse["statusCode"] == 401) {
        bool? refreshToken = await AuthService(context: context!, prefs: prefs!)
            .getRefreshToken();
        refreshToken! ? updateInformationUser(accountModel) : null;

        return null;
      }

      return AccountModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      print("Error : $e");
    }
  }

  Future<PaginationAccountModel?> searchUsers(String text) async {
    try {
      Uri url = Uri.parse(AppEndpoint.userEndpoint + "search?text=$text");

      var response = await http.get(url,
          headers:
              HeaderEndpointService.getStaticAccessTokenBaseEndpoint(prefs!));
      var dataReponse = jsonDecode(response.body) as Map;

      if (dataReponse["statusCode"] == 401) {
        print(response);
        bool? refreshToken = await AuthService(context: context!, prefs: prefs!)
            .getRefreshToken();
        refreshToken! ? searchUsers(text) : null;

        return null;
      }

      final accounts = List<AccountModel>.from(
          dataReponse["data"].map((account) => AccountModel.fromJson(account)));

      return PaginationAccountModel(
          data: accounts, total: dataReponse["total"]);
    } catch (e) {
      print("Error : $e");
    }
  }
}
