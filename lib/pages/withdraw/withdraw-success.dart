import 'package:cn1_d_wallet/common/constant/app-images.dart';
import 'package:cn1_d_wallet/pages/main-page.dart';
import 'package:cn1_d_wallet/widgets/app_button.dart';
import 'package:flutter/material.dart';

import '../../common/constant/app-colors.dart';
import '../../common/constant/app_styles.dart';
import 'item-bank-screen.dart';

class WithdrawSuccessScreen extends StatelessWidget {
  final int amount;

  const WithdrawSuccessScreen({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppImages.imageSuccess),
                  const SizedBox(height: 24),
                  Text(
                    "Withdraw Success",
                    style: AppStyles.h3.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Your \$$amount is on its way",
                    textAlign: TextAlign.center,
                    style: AppStyles.h5.copyWith(
                      color: AppColors.greyText,
                      fontSize: 16,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                AppButton(
                    text: "Continue Withdraw",
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ItemMLocaBankodPayScreen(),
                        ),
                        (_) => false,
                      );
                    }),
                const SizedBox(height: 10),
                SizedBox(
                  height: 58,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MainPage(),
                        ),
                        (_) => false,
                      );
                    },
                    child: Text(
                      "Go home",
                      style: AppStyles.h4.copyWith(fontWeight: FontWeight.bold),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => AppColors.primaryBackground),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
