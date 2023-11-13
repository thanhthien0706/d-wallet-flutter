import 'package:cn1_d_wallet/common/constant/app-images.dart';
import 'package:cn1_d_wallet/common/constant/app_styles.dart';
import 'package:cn1_d_wallet/pages/onboarding/onboarding-page.dart';
import 'package:cn1_d_wallet/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../common/constant/app-colors.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppImages.logo),
                RichText(
                  text: TextSpan(
                    text: 'Chào mừng bạn đến ',
                    style: AppStyles.h4,
                    children: <TextSpan>[
                      TextSpan(
                        text: 'DWallet',
                        style: AppStyles.h4.copyWith(
                          letterSpacing: 1,
                          fontSize: 32,
                          height: 1.4,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18, right: 18, bottom: 20),
            child: AppButton(
                text: "Go",
                onTap: () async {
                  await Future.delayed(Duration(seconds: 1));
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => OnBoardingPage()),
                    (route) => false,
                  );
                }),
          )
        ],
      ),
    );
  }
}
