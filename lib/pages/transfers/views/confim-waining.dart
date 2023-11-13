import 'package:cn1_d_wallet/common/constant/app-colors.dart';
import 'package:cn1_d_wallet/common/constant/app_styles.dart';
import 'package:flutter/material.dart';

class ConfirmWaining extends StatelessWidget {
  const ConfirmWaining({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
          color: AppColors.backgroudSecondColor,
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(Icons.warning, color: AppColors.greyText),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            child: Text(
              "Transfer made with Wally are free without fee and instant.",
              style: AppStyles.h5.copyWith(
                color: AppColors.greyText,
              ),
            ),
          )
        ],
      ),
    );
  }
}
