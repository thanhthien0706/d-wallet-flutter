import 'package:cn1_d_wallet/common/constant/app-colors.dart';
import 'package:cn1_d_wallet/common/constant/app-images.dart';
import 'package:cn1_d_wallet/common/constant/app_icons.dart';
import 'package:cn1_d_wallet/common/constant/app_styles.dart';
import 'package:cn1_d_wallet/pages/auth/sign-in/signin-page.dart';
import 'package:cn1_d_wallet/pages/auth/sign-up/signup-email-page.dart';
import 'package:cn1_d_wallet/widgets/app_button.dart';
import 'package:cn1_d_wallet/widgets/button_auth_social.dart';
import 'package:flutter/material.dart';

class OptionAuthPage extends StatefulWidget {
  const OptionAuthPage({super.key});

  @override
  State<OptionAuthPage> createState() => _OptionAuthPageState();
}

class _OptionAuthPageState extends State<OptionAuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(AppImages.imageFirstAuth),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 28),
                child: Text(
                  "Let's you in",
                  style: AppStyles.h2.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              const Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ButtonAuthSocial(
                      label: "Continoue with Facebook",
                      icon: AppIcons.iconFacebook,
                      onTap: () {}),
                  Padding(padding: const EdgeInsets.symmetric(vertical: 8)),
                  ButtonAuthSocial(
                      label: "Continoue with Google",
                      icon: AppIcons.iconGoogle,
                      onTap: () {})
                ],
              ),
              const Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Divider(
                      color: AppColors.textColor.withOpacity(0.2),
                      height: 50,
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text('or', style: AppStyles.h4),
                  ),
                  Expanded(
                    child: Divider(
                      color: AppColors.textColor.withOpacity(0.2),
                      height: 50,
                      thickness: 1,
                    ),
                  ),
                ],
              ),
              const Spacer(),

              AppButton(
                  text: "Sign in with email",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SigninPage(),
                      ),
                    );
                  }),
              // const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: AppStyles.h5,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
