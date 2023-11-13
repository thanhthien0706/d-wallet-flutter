import 'package:cn1_d_wallet/common/constant/app-colors.dart';
import 'package:cn1_d_wallet/common/constant/app_styles.dart';
import 'package:cn1_d_wallet/pages/auth/sign-up/signup-password-page.dart';
import 'package:cn1_d_wallet/providers/signup-provider.dart';
import 'package:cn1_d_wallet/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupUsernamePage extends StatefulWidget {
  const SignupUsernamePage({super.key});

  @override
  State<SignupUsernamePage> createState() => _SignupUsernamePageState();
}

class _SignupUsernamePageState extends State<SignupUsernamePage> {
  final _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  _handleTap() {
    try {
      Provider.of<SignupProvider>(context, listen: false).name =
          _controller.text;

      Navigator.push(
          context, MaterialPageRoute(builder: (_) => SignupPasswordPage()));
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
          "Enter your name",
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
                "Please enter your first name and last name",
                style: AppStyles.h4.copyWith(color: AppColors.greyText),
              ),
            ),
            TextField(
              // obscureText: true,
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
                hintText: 'Your Name',
                hintStyle: TextStyle(
                  color:
                      _isFocused ? AppColors.primaryColor : AppColors.greyText,
                ),
                fillColor: AppColors.backgroudSecondColor,
                prefixIcon: const Icon(
                  Icons.person,
                ),
                prefixIconColor:
                    _isFocused ? AppColors.primaryColor : AppColors.greyText,
              ),
            ),
            const Spacer(),
            AppButton(
                text: "Continue",
                onTap: () {
                  _handleTap();
                })
          ],
        ),
      ),
    );
  }
}
