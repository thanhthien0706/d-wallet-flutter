import 'package:cn1_d_wallet/common/constant/app-colors.dart';
import 'package:cn1_d_wallet/common/constant/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ButtonAuthSocial extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final String icon;

  const ButtonAuthSocial(
      {super.key,
      required this.label,
      required this.icon,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62,
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: SvgPicture.asset(
          icon,
        ),
        label: Text(label, style: AppStyles.h4),
        style: ButtonStyle(
          elevation: const MaterialStatePropertyAll(0),
          backgroundColor:
              const MaterialStatePropertyAll(AppColors.primaryBackground),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              side: BorderSide(
                  color: AppColors.textColor.withOpacity(0.2), width: 2),
            ),
          ),
        ),
      ),
    );
  }
}
