import 'package:cn1_d_wallet/common/constant/app-colors.dart';
import 'package:cn1_d_wallet/common/constant/app_icons.dart';
import 'package:cn1_d_wallet/common/constant/app_styles.dart';
import 'package:cn1_d_wallet/pages/deposit/item-method-pay-screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SelectMethodScreen extends StatelessWidget {
  const SelectMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primaryBackground,
        centerTitle: true,
        title: Text(
          "Select Method",
          style: AppStyles.h4.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: AppColors.primaryBackground,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select deposit methods",
              style: AppStyles.h5
                  .copyWith(color: AppColors.greyText, fontSize: 16),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ItemMethodPayScreen(idMethod: 0),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                margin: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: AppColors.backgroudSecondColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(right: 20),
                          child: SvgPicture.asset(
                            AppIcons.iconCreditCard,
                          ),
                          decoration: BoxDecoration(
                            // color: item.color.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        Text(
                          "Credit Card",
                          style: AppStyles.h5.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 14,
                      ),
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ItemMethodPayScreen(idMethod: 1),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                margin: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: AppColors.backgroudSecondColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(right: 20),
                          child: SvgPicture.asset(
                            AppIcons.iconBank,
                          ),
                          decoration: BoxDecoration(
                            // color: item.color.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        Text(
                          "Bank Account",
                          style: AppStyles.h5.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 14,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
