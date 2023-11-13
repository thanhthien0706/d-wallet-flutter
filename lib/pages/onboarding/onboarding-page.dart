import 'dart:async';

import 'package:cn1_d_wallet/common/constant/app-images.dart';
import 'package:cn1_d_wallet/common/constant/app-colors.dart';
import 'package:cn1_d_wallet/common/constant/app_styles.dart';
import 'package:cn1_d_wallet/common/constant/app_texts.dart';
import 'package:cn1_d_wallet/pages/auth/option-auth-page.dart';
import 'package:cn1_d_wallet/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../models/OnBoarding.model.dart';

class OnBoardingPage extends StatefulWidget {
  OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  late final PageController _pageController;

  final List<OnBoarding> onBoardData = [
    OnBoarding(
        title: AppTexts.titleOnboardingFastestPayment,
        desc: AppTexts.descOnboardingFastestPayment,
        image: AppImages.imageQRScan),
    OnBoarding(
        title: AppTexts.titleOnboardingSafestPlatform,
        desc: AppTexts.descOnboardingSafestPlatform,
        image: AppImages.imageFaceID),
    OnBoarding(
        title: AppTexts.titleOnboardingPayAnything,
        desc: AppTexts.descOnboardingPayAnything,
        image: AppImages.imageShoppingItems),
  ];

  int _currentPageIndex = 0;

  final _numPages = 3;
  Timer? _timer;
  int _currentPage = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _stopTimer();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 5), (_) {
      if (_currentPage < _numPages - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (int index) {
                      setState(() {
                        _currentPageIndex = index;
                      });
                    },
                    children: [
                      for (int i = 0; i < onBoardData.length; i++)
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 300,
                                width: double.infinity,
                                child: Image.asset(onBoardData[i].image),
                              ),
                              const Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                              ),
                              Text(
                                onBoardData[i].title,
                                style: AppStyles.h3
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              const Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                              ),
                              Text(
                                textAlign: TextAlign.center,
                                onBoardData[i].desc,
                                style: AppStyles.h4.copyWith(
                                  color: AppColors.greyText,
                                ),
                              )
                            ],
                          ),
                        )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < onBoardData.length; i++)
                      Container(
                        width: 22,
                        height: 22,
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: _currentPageIndex == i
                                  ? Colors.white
                                  : Colors.transparent,
                              width: 2),
                          // border color
                          shape: BoxShape.circle,
                        ),
                        child: Container(
                          margin: const EdgeInsets.all(
                              4), // or ClipRRect if you need to clip the content
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentPageIndex == i
                                ? Colors.white
                                : AppColors.greyText
                                    .withOpacity(0.4), // inner circle color
                          ), // inner content
                        ),
                      ),
                  ],
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 18, right: 18, bottom: 20),
            margin: const EdgeInsets.only(top: 50),
            child: AppButton(
              text: "Get Started",
              onTap: () async {
                await Future.delayed(Duration(seconds: 1));
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => OptionAuthPage()));
              },
            ),
          )
        ],
      ),
    );
  }
}
