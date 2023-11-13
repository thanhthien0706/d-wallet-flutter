import 'package:cn1_d_wallet/common/constant/app-colors.dart';
import 'package:cn1_d_wallet/common/constant/app_icons.dart';
import 'package:cn1_d_wallet/models/local-bank.dart';
import 'package:cn1_d_wallet/providers/withdraw-provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../common/constant/app_styles.dart';
import '../withdraw-amount-screen.dart';

class ItemShowBankWidget extends StatelessWidget {
  LocalBankModel localBank;
  ItemShowBankWidget({super.key, required this.localBank});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        onDoubleTap: () async {
          Provider.of<WithdrawProvider>(context, listen: false).localBankId =
              localBank.id;

          Navigator.push(context,
              MaterialPageRoute(builder: (_) => WithdrawAmountScreen()));
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: AppColors.greyText.withOpacity(0.5), width: 0.5)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppIcons.iconBank,
                height: 56,
                width: 56,
              ),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${localBank.bankUserName}",
                    style: AppStyles.h4.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "${localBank.bankName} - ${localBank.accountNumber}",
                    style: AppStyles.h5.copyWith(color: AppColors.greyText),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
