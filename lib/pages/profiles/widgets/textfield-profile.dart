import 'package:flutter/material.dart';

import '../../../common/constant/app-colors.dart';

class TextfieldProfileWidget extends StatefulWidget {
  String? textDefault;
  bool? isUseIcon;
  String hindText;
  Function(String)? onChanged;
  Icon? iconDefault;
  bool? isDate;
  bool? isEnabled = true;

  TextfieldProfileWidget(
      {super.key,
      this.textDefault,
      this.isUseIcon,
      this.iconDefault,
      this.isDate,
      this.isEnabled,
      required this.hindText,
      required this.onChanged});

  @override
  State<TextfieldProfileWidget> createState() => _TextfieldProfileWidgetState();
}

class _TextfieldProfileWidgetState extends State<TextfieldProfileWidget> {
  final _btnController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _btnController.text = widget.textDefault ?? "";

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        enabled: widget.isEnabled,
        onChanged: widget.onChanged,
        controller: _btnController,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.backgroudSecondColor,
          contentPadding: const EdgeInsets.all(20),
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryColor),
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          hintText: widget.hindText,
          hintStyle: const TextStyle(
            color: AppColors.greyText,
          ),
          prefixIcon: widget.iconDefault,
        ),
      ),
    );
  }
}
