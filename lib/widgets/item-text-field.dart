import 'package:flutter/material.dart';

import '../common/constant/app-colors.dart';

class ItemTextFieldWidget extends StatelessWidget {
  final TextEditingController textcontroller;
  final String hindText;
  ItemTextFieldWidget(
      {super.key, required this.textcontroller, required this.hindText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textcontroller,
      decoration: InputDecoration(
        filled: true,
        contentPadding: const EdgeInsets.all(20),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.textColor.withOpacity(0.2)),
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        hintText: hindText,
        hintStyle: const TextStyle(
          color: AppColors.greyText,
        ),
        fillColor: AppColors.backgroudSecondColor,
      ),
    );
  }
}
