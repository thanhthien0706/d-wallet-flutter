import 'package:cn1_d_wallet/pages/transfers/transfer-success.dart';
import 'package:cn1_d_wallet/pages/transfers/views/confim-waining.dart';
import 'package:cn1_d_wallet/pages/transfers/views/confirm-infor.dart';
import 'package:cn1_d_wallet/providers/balance-provider.dart';
import 'package:cn1_d_wallet/providers/transfer-provider.dart';
import 'package:cn1_d_wallet/services/transactions-service.dart';
import 'package:cn1_d_wallet/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/constant/app-colors.dart';
import '../../common/constant/app_styles.dart';
import '../../models/users/account.model.dart';

class WallyConfirmationScreen extends StatefulWidget {
  const WallyConfirmationScreen({super.key});

  @override
  State<WallyConfirmationScreen> createState() =>
      _WallyConfirmationScreenState();
}

class _WallyConfirmationScreenState extends State<WallyConfirmationScreen> {
  late final prefs;

  @override
  void initState() {
    super.initState();
    initDefaultValue();
  }

  initDefaultValue() async {
    prefs = await SharedPreferences.getInstance();
  }

  _handleTransfer(int idReceiver, int amount, String notes) async {
    return await TransactionService(context: context, prefs: prefs)
        .transfer(idReceiver, amount, notes);
  }

  @override
  Widget build(BuildContext context) {
    int amount = Provider.of<TransferProvider>(context).getAmount;
    String notes = Provider.of<TransferProvider>(context).getNotes;
    AccountModel? accountReceiver =
        Provider.of<TransferProvider>(context).accountModel;

    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Confirm Transfer",
          style: AppStyles.h4.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        // width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "\$$amount",
              style: AppStyles.h1.copyWith(
                  fontWeight: FontWeight.bold, color: AppColors.primaryColor),
            ),
            const SizedBox(height: 20),
            ConfirmWaining(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Divider(
                color: AppColors.greyText.withOpacity(0.5),
                thickness: 0.5,
              ),
            ),
            ConformInforTransfer(
              amount: amount,
              nameReceiver: accountReceiver!.name ?? "",
              notes: notes,
            ),
            const Spacer(),
            AppButton(
              text: "Transfer Now",
              onTap: () async {
                if (await _handleTransfer(accountReceiver.id!, amount, notes)) {
                  // ignore: use_build_context_synchronously
                  await Provider.of<BalanceProvider>(context, listen: false)
                      .fetchBalanceHistory(context, prefs);
                  // ignore: use_build_context_synchronously
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TransferSuccessScreen(
                          name: accountReceiver.name!, amount: amount),
                    ),
                    (route) => false,
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
