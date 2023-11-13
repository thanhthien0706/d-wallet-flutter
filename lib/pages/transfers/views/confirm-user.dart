import 'package:cn1_d_wallet/common/constant/app-colors.dart';
import 'package:cn1_d_wallet/common/constant/app_styles.dart';
import 'package:flutter/material.dart';

class ConfirmUser extends StatelessWidget {
  const ConfirmUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 80,
          width: 80,
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSeeJ6oLaKkQiCeiH6DHrRu492XWtwaf44wJkt6hLBBUg&s"),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          "Thanh Thien",
          style: AppStyles.h4.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          "03732002",
          style: AppStyles.h4
              .copyWith(fontWeight: FontWeight.bold, color: AppColors.greyText),
        ),
        const SizedBox(height: 6),
        Text(
          "thanhthien@gmail.com",
          style: AppStyles.h4
              .copyWith(fontWeight: FontWeight.bold, color: AppColors.greyText),
        ),
      ],
    );
  }
}
