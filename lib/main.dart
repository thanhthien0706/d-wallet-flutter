import 'dart:convert';

import 'package:cn1_d_wallet/models/users/account.model.dart';
import 'package:cn1_d_wallet/pages/main-page.dart';
import 'package:cn1_d_wallet/pages/onboarding/landing-page.dart';
import 'package:cn1_d_wallet/providers/account-provider.dart';
import 'package:cn1_d_wallet/providers/balance-provider.dart';
import 'package:cn1_d_wallet/providers/card-provider.dart';
import 'package:cn1_d_wallet/providers/deposit-provider.dart';
import 'package:cn1_d_wallet/providers/local-bank-provider.dart';
import 'package:cn1_d_wallet/providers/statistic-provider.dart';
import 'package:cn1_d_wallet/providers/transfer-provider.dart';
import 'package:cn1_d_wallet/providers/user-profile-provider.dart';
import 'package:cn1_d_wallet/providers/withdraw-provider.dart';
import 'package:cn1_d_wallet/services/user_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/constant/app-colors.dart';
import 'common/values/share-key.dart';
import 'providers/signup-provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> _checkLoginStatus(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString(ShareKey.ACCESS_TOKEN);
    if (accessToken != null) {
      final userData = prefs.getString(ShareKey.INFOR_USER);
      if (userData == null) {
        AccountModel? accountModel =
            await UserService(prefs: prefs, context: context)
                .getInformationUser();

        await prefs.setString(
            ShareKey.INFOR_USER, jsonEncode(accountModel!.toJson()));
      }

      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SignupProvider()),
        ChangeNotifierProvider(create: (_) => AccountProvider()),
        ChangeNotifierProvider(create: (_) => TransferProvider()),
        ChangeNotifierProvider(create: (_) => UserProfileProvider()),
        ChangeNotifierProvider(create: (_) => CardProvider()),
        ChangeNotifierProvider(create: (_) => BalanceProvider()),
        ChangeNotifierProvider(create: (_) => DepositProvider()),
        ChangeNotifierProvider(create: (_) => LocalBankProvider()),
        ChangeNotifierProvider(create: (_) => WithdrawProvider()),
        ChangeNotifierProvider(create: (_) => StatisticProvider()),
      ],
      child: FutureBuilder(
        future: _checkLoginStatus(context),
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return GoToWelcome();
          } else if (snapshot.hasError) {
            return GoToWelcome();
          } else {
            if (snapshot.data == true) {
              return GoToHome();
            } else {
              return GoToWelcome();
            }
          }
        },
      ),
    );
  }
}

class GoToWelcome extends StatelessWidget {
  const GoToWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primaryBackground,
        ),
        colorScheme:
            const ColorScheme.light(background: AppColors.primaryBackground),
      ),
      darkTheme: ThemeData(
          primaryColor: AppColors.primaryColor,
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.primaryBackground,
          ),
          colorScheme:
              const ColorScheme.dark(background: AppColors.primaryBackground)),
      home: const LandingPage(),
    );
  }
}

class GoToHome extends StatelessWidget {
  const GoToHome({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primaryBackground,
        ),
        colorScheme:
            const ColorScheme.light(background: AppColors.primaryBackground),
      ),
      darkTheme: ThemeData(
          primaryColor: AppColors.primaryColor,
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.primaryBackground,
          ),
          colorScheme:
              const ColorScheme.dark(background: AppColors.primaryBackground)),
      home: MainPage(),
    );
  }
}
