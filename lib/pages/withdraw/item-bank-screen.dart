import 'package:cn1_d_wallet/common/constant/app-colors.dart';
import 'package:cn1_d_wallet/common/constant/app_styles.dart';
import 'package:cn1_d_wallet/models/local-bank.dart';
import 'package:cn1_d_wallet/models/pagination.dart';
import 'package:cn1_d_wallet/pages/withdraw/widget/item-show-bank.dart';
import 'package:cn1_d_wallet/providers/local-bank-provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'add-bank-screen.dart';

class ItemMLocaBankodPayScreen extends StatefulWidget {
  const ItemMLocaBankodPayScreen({super.key});

  @override
  State<ItemMLocaBankodPayScreen> createState() => _ItemLocaBankScreenState();
}

class _ItemLocaBankScreenState extends State<ItemMLocaBankodPayScreen> {
  late final LocalBankProvider _localBankProvider;
  late final SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initDefaultValues();
  }

  initDefaultValues() async {
    prefs = await SharedPreferences.getInstance();
    // ignore: use_build_context_synchronously
    _localBankProvider = Provider.of<LocalBankProvider>(context, listen: false);
    await _localBankProvider.fetchLocalBank(context, prefs);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primaryBackground,
        centerTitle: true,
        title: Text(
          "List of Local Bank",
          style: AppStyles.h4.copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => AddBankScreen()));
              },
              icon: Icon(Icons.add))
        ],
      ),
      backgroundColor: AppColors.primaryBackground,
      body: Consumer<LocalBankProvider>(
          builder: (context, localBankProvider, child) {
        //  lấy danh sach item bank từ provider
        PaginationModel<LocalBankModel>? _localBanks =
            localBankProvider.localBankModel;

        return _localBanks != null && _localBanks.data.isNotEmpty
            ?
            //  Hiển Thị Danh sach ngân hàng
            ListView(
                children: _localBanks.data
                    .map(
                      (e) => ItemShowBankWidget(
                        localBank: e,
                      ),
                    )
                    .toList(),
              )
            : Center(
                child: Text(
                  "List local bank is empty",
                  style: AppStyles.h4.copyWith(color: AppColors.greyText),
                ),
              );
      }),
    );
  }
}
