import 'package:cn1_d_wallet/common/constant/app-colors.dart';
import 'package:cn1_d_wallet/models/transactions/recent-user-transaction.dart';
import 'package:cn1_d_wallet/pages/transfers/views/transfer-form.dart';
import 'package:cn1_d_wallet/pages/transfers/views/transfer-recent-user.dart';
import 'package:cn1_d_wallet/pages/transfers/views/transfer-search-user.dart';
import 'package:cn1_d_wallet/services/transactions-service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/constant/app_styles.dart';
import '../../models/users/account.model.dart';

class TransferMainScreen extends StatefulWidget {
  const TransferMainScreen({super.key});

  @override
  State<TransferMainScreen> createState() => _TransferMainScreenState();
}

class _TransferMainScreenState extends State<TransferMainScreen> {
  late final _prefs;
  // late PageController _pageController;
  List<AccountModel> recentUsersData = [];

  @override
  void initState() {
    // _pageController = PageController(viewportFraction: 0.75, initialPage: 0);
    super.initState();
    _initDefault();
  }

  _initDefault() async {
    _prefs = await SharedPreferences.getInstance();
    PaginationAccountModel? recentUser =
        await TransactionService(context: context, prefs: _prefs)
            .getRecentUserTransaction();

    setState(() {
      recentUsersData = recentUser == null ? [] : recentUser.data;
    });
  }

  _handleTransfer() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Transfer",
          style: AppStyles.h4.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: [
          TransferSearchUser(),
          const SizedBox(height: 20),
          TransferRecentUser(recentUsers: recentUsersData),
          TransferForm()
        ],
      ),
    );
  }
}
