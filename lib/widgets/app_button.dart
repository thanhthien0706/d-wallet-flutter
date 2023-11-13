import 'package:cn1_d_wallet/common/constant/app_styles.dart';
import 'package:flutter/material.dart';

import '../common/constant/app-colors.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const AppButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 58,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        child: Text(
          text,
          style: AppStyles.h4.copyWith(fontWeight: FontWeight.bold),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateColor.resolveWith(
              (states) => AppColors.primaryColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }
}
