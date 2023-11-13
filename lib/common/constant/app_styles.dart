import 'package:flutter/material.dart';

import 'app-colors.dart';

class FontFamily {
  static final roboto = 'roboto';
}

class AppStyles {
  static TextStyle h1 = TextStyle(
      fontFamily: FontFamily.roboto, fontSize: 48, color: AppColors.textColor);
  static TextStyle h2 = TextStyle(
      fontFamily: FontFamily.roboto, fontSize: 38, color: AppColors.textColor);
  static TextStyle h3 = TextStyle(
      fontFamily: FontFamily.roboto, fontSize: 28, color: AppColors.textColor);
  static TextStyle h4 = TextStyle(
      fontFamily: FontFamily.roboto, fontSize: 18, color: AppColors.textColor);
  static TextStyle h5 = TextStyle(
      fontFamily: FontFamily.roboto, fontSize: 14, color: AppColors.textColor);
  static TextStyle h6 = TextStyle(
      fontFamily: FontFamily.roboto, fontSize: 10, color: AppColors.textColor);
}
