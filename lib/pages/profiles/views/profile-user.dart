import 'package:cn1_d_wallet/common/constant/app-colors.dart';
import 'package:cn1_d_wallet/common/constant/app_styles.dart';
import 'package:flutter/material.dart';

class ProfileUserScreen extends StatelessWidget {
  String avatar;
  String fullname;
  String email;
  String phone;

  ProfileUserScreen(
      {super.key,
      required this.avatar,
      required this.fullname,
      required this.email,
      required this.phone});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 96,
          margin: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 64,
                width: 64,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(avatar),
                ),
              ),
              const SizedBox(width: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    fullname,
                    style: AppStyles.h4.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    phone,
                    style: AppStyles.h5.copyWith(color: AppColors.greyText),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    email,
                    style: AppStyles.h5.copyWith(color: AppColors.greyText),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
