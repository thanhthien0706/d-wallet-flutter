import 'package:cn1_d_wallet/models/statistics/statistic-income-expense.dart';

class StatisticIncomeExpenseMain {
  List<StatisticIncomeExpense>? data;
  int? totalIncome;
  int? totalExpense;

  StatisticIncomeExpenseMain(
      {required this.data,
      required this.totalIncome,
      required this.totalExpense});
}
