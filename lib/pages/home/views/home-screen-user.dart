import 'package:cn1_d_wallet/common/constant/app-colors.dart';
import 'package:cn1_d_wallet/common/constant/app_styles.dart';
import 'package:cn1_d_wallet/common/values/share-key.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreenUser extends StatefulWidget {
  final String? name;
  final int? amount;
  const HomeScreenUser({super.key, required this.name, required this.amount});

  @override
  State<HomeScreenUser> createState() => _HomeScreenUserState();
}

class _HomeScreenUserState extends State<HomeScreenUser> {
  bool _isObscuredAmount = true;
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    initDefaultValue();
  }

  initDefaultValue() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _isObscuredAmount = _prefs.getBool(ShareKey.SHOW_AMOUNT) ?? true;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 24),
      height: 49,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello, ${widget.name!.length <= 10 ? widget.name : widget.name!.substring(0, 10) + '...'} ",
                style: AppStyles.h4.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "Your available balance",
                style: AppStyles.h5.copyWith(color: AppColors.greyText),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  _prefs.setBool(ShareKey.SHOW_AMOUNT, !_isObscuredAmount);
                  setState(() {
                    _isObscuredAmount = !_isObscuredAmount;
                  });
                },
                icon: Icon(
                    _isObscuredAmount ? Icons.visibility : Icons.visibility_off,
                    size: 20),
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
              ),
              Text(
                _isObscuredAmount ? "\$${widget.amount}" : "******",
                style: AppStyles.h3.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
