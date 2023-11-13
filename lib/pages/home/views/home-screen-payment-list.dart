import 'package:cn1_d_wallet/common/constant/app-colors.dart';
import 'package:cn1_d_wallet/common/constant/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/constant/app_icons.dart';

class HomeScreenPaymentList extends StatelessWidget {
  List<PaymentItem> itemPaymentList = [
    PaymentItem(AppIcons.iconElectricity, 'Electricity'),
    PaymentItem(AppIcons.iconInternet, 'Internet'),
    PaymentItem(AppIcons.iconVoucher, 'Voucher'),
    PaymentItem(AppIcons.iconAssurance, 'Assurance'),
    PaymentItem(AppIcons.iconMerchant, 'Merchant'),
    PaymentItem(AppIcons.iconMobileCredit, 'Credit'),
    PaymentItem(AppIcons.iconBill, 'Bill'),
    PaymentItem(AppIcons.iconMore, 'More'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, left: 16, right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Payment List",
            style: AppStyles.h4.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 16,
          ),
          StaggeredGrid.count(
            crossAxisCount: 4,
            mainAxisSpacing: 16,
            children: List.generate(itemPaymentList.length, (index) {
              return Column(
                children: [
                  Container(
                    height: 56,
                    width: 56,
                    decoration: const BoxDecoration(
                        color: AppColors.backgroudSecondColor,
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                    child: Center(
                      child: SvgPicture.asset(
                        itemPaymentList[index].img,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Center(
                    child: Text(
                      itemPaymentList[index].text,
                      style: TextStyle(color: AppColors.greyText),
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}

class PaymentItem {
  final String img;
  final String text;
  const PaymentItem(this.img, this.text);
}
