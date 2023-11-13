import 'package:cn1_d_wallet/common/constant/app_styles.dart';
import 'package:cn1_d_wallet/models/statistics/statistic-category.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartCategoryView extends StatelessWidget {
  List<StatisticCategory>? listStatisticCategory;

  ChartCategoryView({super.key, required this.listStatisticCategory});

  List<SalesData> data = [
    SalesData('USA', 5000),
    SalesData('India', 4000),
    SalesData('China', 3000),
    SalesData('Japan', 2000),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      child: SfCircularChart(
        title: ChartTitle(
            text: "Category Chart",
            textStyle: AppStyles.h5.copyWith(fontWeight: FontWeight.bold),
            alignment: ChartAlignment.near),
        legend: Legend(isVisible: true),
        series: <CircularSeries>[
          DoughnutSeries<StatisticCategory, String>(
            dataSource: listStatisticCategory ?? [],
            xValueMapper: (StatisticCategory sales, _) => sales.typeTransaction,
            yValueMapper: (StatisticCategory sales, _) => sales.totalAmount,
          ),
        ],
      ),
    );
  }
}

class SalesData {
  final String region;
  final double sales;

  SalesData(this.region, this.sales);
}
