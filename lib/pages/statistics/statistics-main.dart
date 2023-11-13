import 'package:cn1_d_wallet/common/constant/app-colors.dart';
import 'package:cn1_d_wallet/common/constant/app_styles.dart';
import 'package:cn1_d_wallet/pages/statistics/views/BoxShowStatisticDefault.dart';
import 'package:cn1_d_wallet/pages/statistics/views/ChartCategory.dart';
import 'package:cn1_d_wallet/pages/statistics/views/ChartIncomeExpense.dart';
import 'package:cn1_d_wallet/providers/statistic-provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatisticMainScreen extends StatefulWidget {
  const StatisticMainScreen({super.key});

  @override
  State<StatisticMainScreen> createState() => _StatisticMainScreenState();
}

class _StatisticMainScreenState extends State<StatisticMainScreen> {
  late final SharedPreferences prefs;
  late final StatisticProvider statisticProvider;

  @override
  void initState() {
    super.initState();
    initDefaultValue();
  }

  initDefaultValue() async {
    prefs = await SharedPreferences.getInstance();
    // ignore: use_build_context_synchronously
    statisticProvider = Provider.of<StatisticProvider>(context, listen: false);
    // ignore: use_build_context_synchronously
    await statisticProvider.fetchDate(context, prefs);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Statistic",
          style: AppStyles.h4.copyWith(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primaryBackground,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: AppColors.primaryBackground,
      body: Consumer<StatisticProvider>(
          builder: (context, statisticProvider, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: ListView(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.all(0),
            children: [

              // cum 1
              BoxShowStatisticDefaultView(
                statisticDefault: statisticProvider.statisticDefault,
                income:
                    statisticProvider.listStatisticIncomeExpense?.totalIncome,
                expense:
                    statisticProvider.listStatisticIncomeExpense?.totalExpense,
              ),

              // cum 2
              ChartCategoryView(
                  listStatisticCategory:
                      statisticProvider.listStatisticCategory),
              
              // cum 3
              ChartIncomeExpenseView(
                data: statisticProvider.listStatisticIncomeExpense?.data,
              )
            ],
          ),
        );
      }),
    );
  }
}
