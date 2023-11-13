import 'package:cn1_d_wallet/models/statistics/statistic-category.dart';
import 'package:cn1_d_wallet/models/statistics/statistic-default.model.dart';
import 'package:cn1_d_wallet/models/statistics/statistic-income-expense.dart';
import 'package:cn1_d_wallet/services/statistic-service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/statistics/statistic-default.model.dart';
import '../models/statistics/statistic-income-expense-main.dart';

class StatisticProvider extends ChangeNotifier {
  StatisticDefault? _statisticDefault;
  StatisticIncomeExpenseMain? _listStatisticIncomeExpense;
  List<StatisticCategory>? _listStatisticCategory;

  StatisticDefault? get statisticDefault => _statisticDefault;
  StatisticIncomeExpenseMain? get listStatisticIncomeExpense =>
      _listStatisticIncomeExpense;
  List<StatisticCategory>? get listStatisticCategory => _listStatisticCategory;

  Future<void> fetchDate(BuildContext context, SharedPreferences prefs) async {
    try {
      _statisticDefault =
          await StatisticsService(context: context, prefs: prefs)
              .fetchStatisticDefault(DateTime.now().year.toString());
      _listStatisticIncomeExpense =
          await StatisticsService(context: context, prefs: prefs)
              .fetchIncomeExpense();
      _listStatisticCategory =
          await StatisticsService(context: context, prefs: prefs)
              .fetchCategory();
      notifyListeners();
    } catch (e) {
      print("Error: $e");
    }
  }
}
