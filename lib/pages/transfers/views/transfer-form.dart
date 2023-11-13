import 'package:cn1_d_wallet/common/constant/app-colors.dart';
import 'package:cn1_d_wallet/common/constant/app_styles.dart';
import 'package:cn1_d_wallet/models/users/account.model.dart';
import 'package:cn1_d_wallet/pages/transfers/wally-confirmation.dart';
import 'package:cn1_d_wallet/providers/transfer-provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../widgets/app_button.dart';

class TransferForm extends StatefulWidget {
  const TransferForm({super.key});

  @override
  State<TransferForm> createState() => _TransferFormState();
}

class _TransferFormState extends State<TransferForm> {
  final _amountController = TextEditingController();
  bool _isFocusedAmount = false;

  final _notesController = TextEditingController(text: "Transfer to ");
  bool _isFocusedNotes = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Set Amount",
            style: AppStyles.h4.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            "How much would you like to transfer?",
            style: AppStyles.h5.copyWith(color: AppColors.greyText),
          ),
          const SizedBox(height: 10),
          TextField(
            onChanged: (value) {
              try {
                Provider.of<TransferProvider>(context, listen: false).amount =
                    int.parse(value);
              } catch (e) {
                print("Error: $e");
              }
            },
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              filled: true,
              contentPadding: const EdgeInsets.all(20),
              border: OutlineInputBorder(
                borderSide:
                    BorderSide(color: AppColors.textColor.withOpacity(0.2)),
                borderRadius: const BorderRadius.all(Radius.circular(16)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.primaryColor),
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              hintText: 'VD: 20.00',
              hintStyle: TextStyle(
                color: _isFocusedAmount
                    ? AppColors.primaryColor
                    : AppColors.greyText,
              ),
              fillColor: AppColors.backgroudSecondColor,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "Set Notes",
            style: AppStyles.h4.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            "Enter notes",
            style: AppStyles.h5.copyWith(color: AppColors.greyText),
          ),
          const SizedBox(height: 10),
          TextField(
            maxLines: 4,
            onChanged: (value) {
              Provider.of<TransferProvider>(context, listen: false).notes =
                  value;
            },
            controller: _notesController,
            decoration: InputDecoration(
              filled: true,
              contentPadding: const EdgeInsets.all(20),
              border: OutlineInputBorder(
                borderSide:
                    BorderSide(color: AppColors.textColor.withOpacity(0.2)),
                borderRadius: const BorderRadius.all(Radius.circular(16)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.primaryColor),
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              // hintText: 'VD: 20.00',
              hintStyle: TextStyle(
                color: _isFocusedNotes
                    ? AppColors.primaryColor
                    : AppColors.greyText,
              ),
              fillColor: AppColors.backgroudSecondColor,
            ),
          ),
          const SizedBox(height: 60),
          AppButton(
            text: "Continue",
            onTap: () {
              AccountModel? acountModel =
                  Provider.of<TransferProvider>(context, listen: false)
                      .accountModel;
              if (!_amountController.text.isEmpty &&
                  !_notesController.text.isEmpty &&
                  acountModel != null) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => WallyConfirmationScreen()));
              }
            },
          ),
        ],
      ),
    );
  }
}
