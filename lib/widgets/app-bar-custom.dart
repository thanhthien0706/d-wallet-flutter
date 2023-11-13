import 'package:cn1_d_wallet/common/constant/app_styles.dart';
import 'package:flutter/material.dart';

class AppBarCustom extends StatelessWidget {
  final String title;
  AppBarCustom({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      elevation: 0,
      title: Text(
        title,
        style: AppStyles.h4.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
