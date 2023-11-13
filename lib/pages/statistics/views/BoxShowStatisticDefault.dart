import 'package:cn1_d_wallet/models/statistics/statistic-default.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../common/constant/app-colors.dart';
import '../../../common/constant/app_styles.dart';

class BoxShowStatisticDefaultView extends StatelessWidget {
  StatisticDefault? statisticDefault;
  int? income;
  int? expense;

  BoxShowStatisticDefaultView(
      {super.key,
      required this.statisticDefault,
      required this.income,
      required this.expense});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: BoxShowAmountTotal(
                amount: "${income ?? 0}",
                color: Colors.blue,
                name: "Income",
                icon: Icons.arrow_drop_down,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: BoxShowAmountTotal(
                amount: "${expense ?? 0}",
                color: Colors.red,
                icon: Icons.arrow_drop_up,
                name: "Expense",
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Divider(
            color: AppColors.greyText.withOpacity(0.5),
            thickness: 0.5,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 20),
          child: GridViewInforView(
            average: statisticDefault?.average,
            highestAmount: statisticDefault?.highestAmount,
            lowestAmount: statisticDefault?.lowestAmount,
            totalTransaction: statisticDefault?.totalTransaction,
          ),
        )
      ],
    );
  }
}

class GridViewInforView extends StatelessWidget {
  double? average;
  int? highestAmount;
  int? lowestAmount;
  String? totalTransaction;

  GridViewInforView(
      {super.key,
      required this.average,
      required this.totalTransaction,
      required this.highestAmount,
      required this.lowestAmount});

  @override
  Widget build(BuildContext context) {
    return StaggeredGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      children: <Widget>[
        RichText(
          text: TextSpan(
            text: 'Best Week\n',
            style: AppStyles.h5.copyWith(
              fontSize: 16,
              color: AppColors.greyText,
            ),
            children: <TextSpan>[
              TextSpan(
                text: "\$${highestAmount ?? 0}",
                style: AppStyles.h4.copyWith(
                  letterSpacing: 1,
                  height: 1.8,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            text: 'Average Value\n',
            style: AppStyles.h5.copyWith(
              fontSize: 16,
              color: AppColors.greyText,
            ),
            children: <TextSpan>[
              TextSpan(
                text: "\$${average ?? 0}",
                style: AppStyles.h4.copyWith(
                  letterSpacing: 1,
                  height: 1.8,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            text: 'Worst Week\n',
            style: AppStyles.h5.copyWith(
              fontSize: 16,
              color: AppColors.greyText,
            ),
            children: <TextSpan>[
              TextSpan(
                text: "\$${lowestAmount ?? 0}",
                style: AppStyles.h4.copyWith(
                  letterSpacing: 1,
                  height: 1.8,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            text: 'Transactions\n',
            style: AppStyles.h5.copyWith(
              fontSize: 16,
              color: AppColors.greyText,
            ),
            children: <TextSpan>[
              TextSpan(
                text: "\$${totalTransaction ?? 0}",
                style: AppStyles.h4.copyWith(
                  letterSpacing: 1,
                  height: 1.8,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        )
      ],
    );
    ;
  }
}

class ItemChildrenView extends StatelessWidget {
  const ItemChildrenView({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'chao ban\n',
        style: AppStyles.h5.copyWith(
          fontSize: 16,
          color: AppColors.greyText,
        ),
        children: <TextSpan>[
          TextSpan(
            text: "\$24234",
            style: AppStyles.h4.copyWith(
              letterSpacing: 1,
              height: 1.8,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class BoxShowAmountTotal extends StatelessWidget {
  Color color;
  String amount;
  String name;
  IconData icon;

  BoxShowAmountTotal(
      {super.key,
      required this.color,
      required this.amount,
      required this.name,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.backgroudSecondColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 40,
            width: 40,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(right: 10),
            child: Icon(
              icon,
              color: color,
            ),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          RichText(
            text: TextSpan(
              text: '\$$amount\n',
              style: AppStyles.h4.copyWith(fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                  text: name,
                  style: AppStyles.h5.copyWith(
                    letterSpacing: 1,
                    height: 1.8,
                    color: AppColors.greyText,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
