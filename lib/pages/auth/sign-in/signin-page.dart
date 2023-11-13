import 'package:cn1_d_wallet/models/auth/auth.model.dart';
import 'package:cn1_d_wallet/models/users/account.model.dart';
import 'package:cn1_d_wallet/pages/auth/sign-up/signup-email-page.dart';
import 'package:cn1_d_wallet/services/auth-service.dart';
import 'package:cn1_d_wallet/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/constant/app-colors.dart';
import '../../../common/constant/app-images.dart';
import '../../../common/constant/app_icons.dart';
import '../../../common/constant/app_styles.dart';
import '../../../common/values/share-key.dart';
import '../../../widgets/button_auth_social.dart';
import '../../main-page.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final _emailController = TextEditingController();
  final FocusNode _focusNodeEmail = FocusNode();
  bool _isFocusedEmail = false;
  final _emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  bool validEmail = true;
  String textErrorEmail = "Enter a valid email address";

  final _passwordController = TextEditingController();
  final FocusNode _focusNodePassword = FocusNode();
  bool _isFocusedPassword = false;
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

  _handleTapSignin() async {
    AccountModel account = AccountModel(
        email: _emailController.text, password: _passwordController.text);

    AuthModel? authModel = (await AuthService().signin(context, account));

    if (authModel == null) {
      return;
    }

    prefs.setString(ShareKey.ACCESS_TOKEN, authModel.accessToken);
    prefs.setString(ShareKey.REFRESH_TOKEN, authModel.refreshToken);
    prefs.setString(ShareKey.EXPIRED_TIME,
        DateTime.now().add(const Duration(minutes: 15)).toString());

    Navigator.push(context, MaterialPageRoute(builder: (_) => MainPage()));
  }

  bool _validateEmail(String val) {
    if (val.isEmpty) {
      return false;
    }
    return _emailRegExp.hasMatch(val);
  }

  @override
  void dispose() {
    _focusNodeEmail.dispose();
    _focusNodePassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _focusNodeEmail.addListener(() {
      setState(() {
        _isFocusedEmail = _focusNodeEmail.hasFocus;
      });
    });

    _focusNodePassword.addListener(() {
      setState(() {
        _isFocusedPassword = _focusNodePassword.hasFocus;
      });
    });

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _LogoHeaderWidget(),
              TextField(
                onChanged: (value) {
                  setState(() {
                    validEmail = _validateEmail(value);
                  });
                },
                focusNode: _focusNodeEmail,
                controller: _emailController,
                decoration: InputDecoration(
                  filled: true,
                  contentPadding: const EdgeInsets.all(20),
                  errorText: validEmail ? null : textErrorEmail,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: validEmail
                            ? AppColors.textColor.withOpacity(0.2)
                            : Colors.red),
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primaryColor),
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  hintText: 'Your Email',
                  hintStyle: TextStyle(
                    color: _isFocusedEmail
                        ? validEmail
                            ? AppColors.primaryColor
                            : Colors.red
                        : AppColors.greyText,
                  ),
                  fillColor: AppColors.backgroudSecondColor,
                  prefixIcon: const Icon(
                    Icons.email,
                  ),
                  prefixIconColor: _isFocusedEmail
                      ? validEmail
                          ? AppColors.primaryColor
                          : Colors.red
                      : AppColors.greyText,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              TextField(
                obscureText: !_passwordVisible,
                focusNode: _focusNodePassword,
                controller: _passwordController,
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
                    color: _isFocusedPassword
                        ? AppColors.primaryColor
                        : AppColors.greyText,
                  ),
                  fillColor: AppColors.backgroudSecondColor,
                  prefixIcon: const Icon(
                    Icons.lock,
                  ),
                  prefixIconColor: _isFocusedPassword
                      ? AppColors.primaryColor
                      : AppColors.greyText,
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
                  suffixIconColor: _isFocusedPassword
                      ? AppColors.primaryColor
                      : AppColors.greyText,
                ),
              ),
              Container(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Forgot Password",
                    style: AppStyles.h5,
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              AppButton(
                text: "Sign In",
                onTap: () {
                  _handleTapSignin();
                },
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "New to DWallet?",
                      style: AppStyles.h5.copyWith(color: AppColors.greyText),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => SignupEmailPage(),
                            ),
                          );
                        },
                        child: Text(
                          "Sign up",
                          style: AppStyles.h4.copyWith(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
              ),
              const Spacer(),
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      "or login with",
                      style: AppStyles.h5.copyWith(color: AppColors.greyText),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ButtonAuthSocial(
                          label: "Facebook",
                          icon: AppIcons.iconFacebook,
                          onTap: () {},
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                      Expanded(
                        child: ButtonAuthSocial(
                          label: "Google",
                          icon: AppIcons.iconGoogle,
                          onTap: () {},
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _LogoHeaderWidget extends StatelessWidget {
  const _LogoHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 120,
      margin: const EdgeInsets.only(bottom: 40.0),
      child: Image.asset(AppImages.logo),
    );
  }
}
