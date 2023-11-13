import 'dart:convert';

import 'package:cn1_d_wallet/common/constant/app_endpoint.dart';
import 'package:cn1_d_wallet/models/statistics/statistic-category.dart';
import 'package:cn1_d_wallet/models/statistics/statistic-default.model.dart';
import 'package:cn1_d_wallet/models/statistics/statistic-income-expense.dart';
import 'package:cn1_d_wallet/services/auth-service.dart';
import 'package:cn1_d_wallet/services/bases/header-endpoint.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../models/statistics/statistic-income-expense-main.dart';

class StatisticsService {
  final BuildContext? context;
  final SharedPreferences? prefs;

  StatisticsService({this.context, this.prefs});

  Future<StatisticDefault?> fetchStatisticDefault(String? year) async {
    try {
      Uri url = Uri.parse(AppEndpoint.mainEndpoint + "statistics");

      var response = await http.get(url,
          headers:
              HeaderEndpointService.getStaticAccessTokenBaseEndpoint(prefs!));

      var dataReponse = jsonDecode(response.body) as Map;
      if (dataReponse["statusCode"] == 401) {
        bool? refreshToken = await AuthService(context: context!, prefs: prefs!)
            .getRefreshToken();
        refreshToken! ? fetchStatisticDefault(year) : null;

        return null;
      }

      print(jsonDecode(response.body));
      return StatisticDefault.fromJson(jsonDecode(response.body));
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<StatisticIncomeExpenseMain?> fetchIncomeExpense() async {
    try {
      Uri url = Uri.parse(
          AppEndpoint.mainEndpoint + "statistics/income-expense?type=monthly");

      var response = await http.get(url,
          headers:
              HeaderEndpointService.getStaticAccessTokenBaseEndpoint(prefs!));

      var dataReponse = jsonDecode(response.body) as Map;
      if (dataReponse["statusCode"] == 401) {
        bool? refreshToken = await AuthService(context: context!, prefs: prefs!)
            .getRefreshToken();
        refreshToken! ? fetchIncomeExpense() : null;

        return null;
      }

      List<StatisticIncomeExpense>? dataResults = List.from(
          dataReponse["data"].map((ie) => StatisticIncomeExpense.fromJson(ie)));

      return StatisticIncomeExpenseMain(
          data: dataResults,
          totalIncome: dataReponse["totalIncomes"] as int?,
          totalExpense: dataReponse["totalExpenses"] as int?);
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<List<StatisticCategory>?> fetchCategory() async {
    try {
      Uri url = Uri.parse(
          "${AppEndpoint.mainEndpoint}statistics/type-transaction?type=monthly");

      var response = await http.get(url,
          headers:
              HeaderEndpointService.getStaticAccessTokenBaseEndpoint(prefs!));

      var dataReponse = jsonDecode(response.body) as Map;
      if (dataReponse["statusCode"] == 401) {
        bool? refreshToken = await AuthService(context: context!, prefs: prefs!)
            .getRefreshToken();
        refreshToken! ? fetchCategory() : null;

        return null;
      }

      List<StatisticCategory>? dataResults = List.from(
          dataReponse["data"].map((ie) => StatisticCategory.fromJson(ie)));

      return dataResults;
    } catch (e) {
      print("Error: $e");
    }
  }
}
