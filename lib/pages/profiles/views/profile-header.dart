import 'package:cn1_d_wallet/common/constant/app-colors.dart';
import 'package:cn1_d_wallet/common/constant/app_styles.dart';
import 'package:flutter/material.dart';

class ProfileHeaderScreen extends StatelessWidget {
  const ProfileHeaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      margin: const EdgeInsets.only(
        top: 50,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "My Profile",
            style: AppStyles.h4.copyWith(fontWeight: FontWeight.bold),
          ),
          Container(
            alignment: Alignment.center,
            height: 40,
            width: 40,
            child: Icon(
              Icons.qr_code,
            ),
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
