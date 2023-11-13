import 'package:cn1_d_wallet/common/values/share-key.dart';
import 'package:cn1_d_wallet/models/auth/auth.model.dart';
import 'package:cn1_d_wallet/models/users/account.model.dart';
import 'package:cn1_d_wallet/providers/signup-provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/constant/app-colors.dart';
import '../../../common/constant/app_styles.dart';
import '../../../services/auth-service.dart';
import '../../../widgets/app_button.dart';
import '../../main-page.dart';

class SignupPasswordPage extends StatefulWidget {
  const SignupPasswordPage({super.key});

  @override
  State<SignupPasswordPage> createState() => _SignupPasswordPageState();
}

class _SignupPasswordPageState extends State<SignupPasswordPage> {
  final _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  bool _passwordVisible = false;

  late final prefs;

  @override
  void initState() {
    super.initState();
    initDefaultValue();
  }

  initDefaultValue() async {
    prefs = await SharedPreferences.getInstance();
  }

  _handleTap() async {
    try {
      Provider.of<SignupProvider>(context, listen: false).password =
          _controller.text;

      AuthModel? authModel = (await AuthService().signup(
          context,
          Provider.of<SignupProvider>(context, listen: false).accountModel
              as AccountModel));

      if (authModel == null) {
        return;
      }

      prefs.setString(ShareKey.ACCESS_TOKEN, authModel.accessToken);
      prefs.setString(ShareKey.REFRESH_TOKEN, authModel.refreshToken);
      prefs.setString(ShareKey.EXPIRED_TIME,
          DateTime.now().add(const Duration(minutes: 15)).toString());

      Navigator.push(context, MaterialPageRoute(builder: (_) => MainPage()));
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Setup Password",
          style: AppStyles.h4.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 24),
              child: Text(
                "Please create a  secure password including the following criteria below",
                style: AppStyles.h4.copyWith(color: AppColors.greyText),
              ),
            ),
            TextField(
              obscureText: !_passwordVisible,
              focusNode: _focusNode,
              controller: _controller,
              decoration: InputDecoration(
                filled: true,
                contentPadding: const EdgeInsets.all(20),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.textColor.withOpacity(0.2)),
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primaryColor),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                hintText: 'Password',
                hintStyle: TextStyle(
                  color:
                      _isFocused ? AppColors.primaryColor : AppColors.greyText,
                ),
                fillColor: AppColors.backgroudSecondColor,
                prefixIcon: const Icon(
                  Icons.lock,
                ),
                prefixIconColor:
                    _isFocused ? AppColors.primaryColor : AppColors.greyText,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                  icon: Icon(_passwordVisible
                      ? Icons.visibility
                      : Icons.visibility_off),
                ),
                suffixIconColor:
                    _isFocused ? AppColors.primaryColor : AppColors.greyText,
              ),
            ),
            const Spacer(),
            AppButton(
              text: "Continue",
              onTap: () {
                _handleTap();
              },
            )
          ],
        ),
      ),
    );
  }
}
