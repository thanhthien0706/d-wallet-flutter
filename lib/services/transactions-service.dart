import 'dart:convert';

import 'package:cn1_d_wallet/models/transactions/recent-user-transaction.dart';
import 'package:cn1_d_wallet/models/users/account.model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../common/constant/app_endpoint.dart';
import 'auth-service.dart';
import 'bases/header-endpoint.dart';

class TransactionService {
  final BuildContext? context;
  final SharedPreferences? prefs;

  TransactionService({this.context, this.prefs});

  Future<PaginationAccountModel?> getRecentUserTransaction() async {
    try {
      Uri url = Uri.parse(
          AppEndpoint.transactionEndpoint + "recent-users?limit=10&page=1");

      var response = await http.get(url,
          headers:
              HeaderEndpointService.getStaticAccessTokenBaseEndpoint(prefs!));
      var dataReponse = jsonDecode(response.body) as Map;

      if (dataReponse["statusCode"] == 401) {
        bool? refreshToken = await AuthService(context: context!, prefs: prefs!)
            .getRefreshToken();
        refreshToken! ? getRecentUserTransaction() : null;

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

  Future<bool?> transfer(int idReceiver, int amount, String notes) async {
    try {
      Uri url = Uri.parse(AppEndpoint.transactionEndpoint + "transfer");
      var body =
          jsonEncode({"to": idReceiver, "amount": amount, "notes": notes});
      var response = await http.post(url,
          headers:
              HeaderEndpointService.getStaticAccessTokenBaseEndpoint(prefs!),
          body: body);

      var dataReponse = jsonDecode(response.body) as Map;

      if (dataReponse["statusCode"] == 401) {
        bool? refreshToken = await AuthService(context: context!, prefs: prefs!)
            .getRefreshToken();
        refreshToken! ? transfer(idReceiver, amount, notes) : null;

        return null;
      }

      return dataReponse['status'] == "COMPLETED" ? true : false;
    } catch (e) {
      print("Error : $e");
    }
  }

  Future<bool?> deposit(int cardId, int amount) async {
    try {
      Uri url = Uri.parse(AppEndpoint.transactionEndpoint + "deposit");

      var body = jsonEncode({"amount": amount * 100, "cardId": cardId});
      var response = await http.post(url,
          headers:
              HeaderEndpointService.getStaticAccessTokenBaseEndpoint(prefs!),
          body: body);

      var dataReponse = jsonDecode(response.body) as Map;

      if (dataReponse["statusCode"] == 401) {
        bool? refreshToken = await AuthService(context: context!, prefs: prefs!)
            .getRefreshToken();
        refreshToken! ? deposit(cardId, amount) : null;

        return null;
      }

      return dataReponse['status'] == "COMPLETED" ? true : false;
    } catch (e) {
      print("Error : $e");
    }
  }

  Future<bool?> withdraw(int localBankId, int amount) async {
    try {
      Uri url = Uri.parse(AppEndpoint.transactionEndpoint + "withdraw");
      var body = jsonEncode({
        "localBankId": localBankId,
        "amount": amount.toString(),
        "notes": ""
      });
      var response = await http.post(url,
          headers:
              HeaderEndpointService.getStaticAccessTokenBaseEndpoint(prefs!),
          body: body);

      var dataReponse = jsonDecode(response.body) as Map;

      if (dataReponse["statusCode"] == 401) {
        bool? refreshToken = await AuthService(context: context!, prefs: prefs!)
            .getRefreshToken();
        refreshToken! ? withdraw(localBankId, amount) : null;

        return null;
      }

      return dataReponse['status'] == "COMPLETED" ? true : false;
    } catch (e) {
      print("Error : $e");
    }
  }
}
