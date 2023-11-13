import 'package:cn1_d_wallet/common/constant/app-colors.dart';
import 'package:cn1_d_wallet/common/constant/app_styles.dart';
import 'package:flutter/material.dart';

class ConformInforTransfer extends StatelessWidget {
  final String notes;
  final int amount;
  final String nameReceiver;

  const ConformInforTransfer(
      {super.key,
      required this.notes,
      required this.amount,
      required this.nameReceiver});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
          color: AppColors.backgroudSecondColor,
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Column(
        children: [
          ShowRowInfor(title: "Amount", content: "\$$amount"),
          ShowRowInfor(title: "Notes", content: notes),
          ShowRowInfor(title: "Fee", content: "Free"),
          ShowRowInfor(title: "To", content: nameReceiver),
        ],
      ),
    );
  }
}

class ShowRowInfor extends StatelessWidget {
  final String title;
  final String content;
  const ShowRowInfor({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: AppStyles.h5.copyWith(
                fontSize: 16,
                color: AppColors.greyText,
                fontWeight: FontWeight.bold),
          ),
          Text(
            content,
            style: AppStyles.h5
                .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
