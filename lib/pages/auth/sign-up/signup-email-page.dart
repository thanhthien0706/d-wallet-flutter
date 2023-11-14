import 'package:cn1_d_wallet/common/constant/app-colors.dart';
import 'package:cn1_d_wallet/common/constant/app-images.dart';
import 'package:cn1_d_wallet/common/constant/app_icons.dart';
import 'package:cn1_d_wallet/common/constant/app_styles.dart';
import 'package:cn1_d_wallet/pages/auth/sign-in/signin-page.dart';
import 'package:cn1_d_wallet/pages/auth/sign-up/signup-username-page.dart';
import 'package:cn1_d_wallet/providers/signup-provider.dart';
import 'package:cn1_d_wallet/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../services/user_services.dart';
import '../../../widgets/button_auth_social.dart';

class SignupEmailPage extends StatefulWidget {
  const SignupEmailPage({super.key});

  @override
  State<SignupEmailPage> createState() => _SignupEmailPageState();
}

class _SignupEmailPageState extends State<SignupEmailPage> {
  final _emailController = TextEditingController();
  final FocusNode _focusNodeEmail = FocusNode();
  bool _isFocusedEmail = false;
  final _emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  bool validEmail = true;
  String textErrorEmail = "Enter a valid email address";

  @override
  void initState() {
    super.initState();
  }

  void _handleTapEmail() async {
    try {
      if (!_validateEmail(_emailController.text)) {
        setState(() {
          validEmail = false;
          textErrorEmail = "Enter a valid email address";
        });

        return;
      }

      // bool? checkEmail = (await UserService(context: context)
      //     .checkEmailExist(_emailController.text));

      // if (checkEmail == null) {
      //   setState(() {
      //     validEmail = false;
      //     textErrorEmail = "Email already exists";
      //   });

      //   return;
      // }

      // ignore: use_build_context_synchronously
      Provider.of<SignupProvider>(context, listen: false).email =
          _emailController.text;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => SignupUsernamePage(),
        ),
      );
    } catch (e) {
      print("Error: $e");
    }
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _focusNodeEmail.addListener(() {
      setState(() {
        _isFocusedEmail = _focusNodeEmail.hasFocus;
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
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 24),
                child: Text(
                  textAlign: TextAlign.left,
                  "By creating an account, you accept our Terms",
                  style: AppStyles.h5.copyWith(color: AppColors.greyText),
                ),
              ),
              AppButton(
                  text: "Continue",
                  onTap: () {
                    _handleTapEmail();
                  }),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: AppStyles.h5.copyWith(color: AppColors.greyText),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => SigninPage(),
                            ),
                          );
                        },
                        child: Text(
                          "Sign in",
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
                  Text(
                    "or continue with",
                    style: AppStyles.h5.copyWith(color: AppColors.greyText),
                  ),
                  Padding(padding: const EdgeInsets.symmetric(vertical: 8)),
                  ButtonAuthSocial(
                    label: "Continoue with Facebook",
                    icon: AppIcons.iconFacebook,
                    onTap: () {},
                  ),
                  Padding(padding: const EdgeInsets.symmetric(vertical: 8)),
                  ButtonAuthSocial(
                    label: "Continoue with Google",
                    icon: AppIcons.iconGoogle,
                    onTap: () {},
                  ),
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
