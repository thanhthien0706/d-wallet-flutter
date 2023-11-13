import 'package:cn1_d_wallet/common/constant/app_styles.dart';
import 'package:cn1_d_wallet/models/statistics/statistic-income-expense.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartIncomeExpenseView extends StatelessWidget {
  List<StatisticIncomeExpense>? data;

  ChartIncomeExpenseView({super.key, required this.data});

  // List<SalesData> data = [
  //   SalesData('2016', 100, 200),
  //   SalesData('2017', 200, 300),
  //   SalesData('2018', 150, 250),
  //   SalesData('2019', 300, 400),
  //   SalesData('2020', 400, 500),
  // ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      child: SfCartesianChart(
        title: ChartTitle(
            text: "Income & Expense",
            textStyle: AppStyles.h5.copyWith(fontWeight: FontWeight.bold),
            alignment: ChartAlignment.near),
        primaryXAxis: CategoryAxis(),
        series: <ChartSeries>[
          LineSeries<StatisticIncomeExpense, String>(
            dataSource: data ?? [],
            xValueMapper: (StatisticIncomeExpense sales, _) =>
                sales.label.toString(),
            yValueMapper: (StatisticIncomeExpense sales, _) => sales.income,
            name: 'Sales 1',
          ),
          LineSeries<StatisticIncomeExpense, String>(
            dataSource: data ?? [],
            xValueMapper: (StatisticIncomeExpense sales, _) =>
                sales.label.toString(),
            yValueMapper: (StatisticIncomeExpense sales, _) => sales.expense,
            name: 'Sales 2',
          ),
        ],
      ),
    );
  }
}

class SalesData {
  final String region;
  final double sales1;
  final double sales2;

  SalesData(this.region, this.sales1, this.sales2);
}
