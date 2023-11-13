import 'package:cn1_d_wallet/common/constant/app-colors.dart';
import 'package:cn1_d_wallet/common/constant/app-images.dart';
import 'package:flutter/material.dart';

class HomeScreenHeader extends StatelessWidget {
  const HomeScreenHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      margin: const EdgeInsets.only(top: 50, left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Image(
            image: AssetImage(AppImages.logo),
            height: 38,
            width: 64,
            fit: BoxFit.scaleDown,
          ),
          Container(
            alignment: Alignment.center,
            height: 40,
            width: 40,
            child: Icon(Icons.settings),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(12)),
              border: Border.all(
                color: AppColors.greyText.withOpacity(0.5),
                width: 2,
              ),
            ),
          )
        ],
      ),
    );
  }
}
