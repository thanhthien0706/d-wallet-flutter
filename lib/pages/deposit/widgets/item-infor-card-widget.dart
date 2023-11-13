import 'package:cn1_d_wallet/common/constant/app-colors.dart';
import 'package:cn1_d_wallet/common/constant/app_icons.dart';
import 'package:cn1_d_wallet/common/constant/app_styles.dart';
import 'package:cn1_d_wallet/models/transactions/card-model.dart';
import 'package:cn1_d_wallet/providers/deposit-provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../deposit-amount-screen.dart';

class ItemInforCardWidget extends StatelessWidget {
  CardModel cardModel;
  ItemInforCardWidget({super.key, required this.cardModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        onDoubleTap: () async {
          Provider.of<DepositProvider>(context, listen: false).cardId =
              cardModel.id;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => DepositAmountScreen()),
          );
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
                AppIcons.iconVisa,
                height: 64,
                width: 64,
              ),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    // ${cardModel.brand!.toUpperCase()}
                    "Visa Card",
                    style: AppStyles.h4.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Checking **** ${cardModel.codeLast4} - ${cardModel.expMonth}/${cardModel.expYear}",
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
