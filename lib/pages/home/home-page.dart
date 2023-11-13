import 'package:cn1_d_wallet/common/constant/app-colors.dart';
import 'package:cn1_d_wallet/models/balance-history.dart';
import 'package:cn1_d_wallet/pages/home/views/home-screen-header.dart';
import 'package:cn1_d_wallet/pages/home/views/home-screen-main-action.dart';
import 'package:cn1_d_wallet/pages/home/views/home-screen-payment-list.dart';
import 'package:cn1_d_wallet/pages/home/views/home-screen-user.dart';
import 'package:cn1_d_wallet/pages/home/views/home_screen_promo_discount.dart';
import 'package:cn1_d_wallet/providers/balance-provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../providers/user-profile-provider.dart';
import '../../services/balance-service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final prefs;
  BalanceHistoryModel? balanceModel;
  late UserProfileProvider _userProfileProvider;
  late BalanceProvider _balanceProvider;

  @override
  void initState() {
    super.initState();
    initDefaultValue();
  }

  initDefaultValue() async {
    prefs = await SharedPreferences.getInstance();

    _userProfileProvider =
        // ignore: use_build_context_synchronously
        Provider.of<UserProfileProvider>(context, listen: false);
    _balanceProvider =
        // ignore: use_build_context_synchronously
        Provider.of<BalanceProvider>(context, listen: false);

    // ignore: use_build_context_synchronously
    await _userProfileProvider.fetchUserProfile(context, prefs);
    // ignore: use_build_context_synchronously
    await _balanceProvider.fetchBalanceHistory(context, prefs);

    BalanceHistoryModel? dataBalance =
        await BalanceService(context: context, prefs: prefs)
            .getBalanceHistory();

    setState(() {
      balanceModel = dataBalance;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: Consumer<UserProfileProvider>(
        builder: (context, userProfileProvider, child) {
          return Consumer<BalanceProvider>(
              builder: (context, balanceProvider, child) {
            return ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: const EdgeInsets.all(0),
              children: [
                HomeScreenHeader(),
                HomeScreenUser(
                  name: userProfileProvider.userProfile != null
                      ? userProfileProvider.userProfile!.name
                      : "User",
                  amount: balanceProvider.balanceHistoryModel != null
                      ? balanceProvider.balanceHistoryModel!.value
                      : 100,
                ),
                HomeScreenMainAction(),
                HomeScreenPaymentList(),
                HomeScreenPromoDiscount()
              ],
            );
          });
        },
      ),
    );
  }
}
