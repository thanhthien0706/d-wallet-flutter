import 'package:cn1_d_wallet/pages/deposit/deposit-success.dart';
import 'package:cn1_d_wallet/providers/balance-provider.dart';
import 'package:cn1_d_wallet/providers/deposit-provider.dart';
import 'package:cn1_d_wallet/services/transactions-service.dart';
import 'package:cn1_d_wallet/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/constant/app-colors.dart';
import '../../common/constant/app_styles.dart';

class DepositAmountScreen extends StatefulWidget {
  const DepositAmountScreen({super.key});

  @override
  State<DepositAmountScreen> createState() => _DepositAmountScreenState();
}

class _DepositAmountScreenState extends State<DepositAmountScreen> {
  final _amountController = TextEditingController();
  late final prefs;

  @override
  void initState() {
    super.initState();

    initDefaultValue();
  }

  initDefaultValue() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    int value = Provider.of<BalanceProvider>(context, listen: false)
        .balanceHistoryModel!
        .value;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primaryBackground,
        centerTitle: true,
        title: Text(
          "Deposit Amount",
          style: AppStyles.h4.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: AppColors.primaryBackground,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Enter the amount to deposit",
              style: AppStyles.h5
                  .copyWith(color: AppColors.greyText, fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              "Available balance: \$$value",
              style: AppStyles.h5
                  .copyWith(color: AppColors.greyText, fontSize: 16),
            ),
            const SizedBox(height: 10),
            TextField(
              onChanged: (value) {
                Provider.of<DepositProvider>(context, listen: false).amount =
                    int.parse(value);
              },
              controller: _amountController,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 50),
              decoration: InputDecoration(
                filled: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 30),
                border: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.textColor.withOpacity(0.2)),
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primaryColor),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                hintText: '\$0',
                hintStyle:
                    const TextStyle(color: AppColors.greyText, fontSize: 50),
                fillColor: AppColors.backgroudSecondColor,
              ),
            ),
            const Spacer(),
            AppButton(
              text: "Deposit",
              onTap: () async {
                int cardId =
                    Provider.of<DepositProvider>(context, listen: false)
                        .cardId!;
                int amount =
                    Provider.of<DepositProvider>(context, listen: false)
                        .amount!;
                bool? checkDeposit =
                    await TransactionService(context: context, prefs: prefs)
                        .deposit(cardId, amount);
                if (checkDeposit != null && checkDeposit) {
                  // ignore: use_build_context_synchronously
                  await Provider.of<BalanceProvider>(context, listen: false)
                      .fetchBalanceHistory(context, prefs);
                  // ignore: use_build_context_synchronously
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => DepositSuccessScreen(
                            amount: int.parse(_amountController.text))),
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
