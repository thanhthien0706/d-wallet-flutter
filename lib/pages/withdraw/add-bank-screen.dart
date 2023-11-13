import 'package:cn1_d_wallet/models/local-bank.dart';
import 'package:cn1_d_wallet/providers/local-bank-provider.dart';
import 'package:cn1_d_wallet/services/local-bank-service.dart';
import 'package:cn1_d_wallet/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/constant/app-colors.dart';
import '../../common/constant/app_styles.dart';
import '../../widgets/item-text-field.dart';

class AddBankScreen extends StatefulWidget {
  const AddBankScreen({super.key});

  @override
  State<AddBankScreen> createState() => _AddBankScreenState();
}

class _AddBankScreenState extends State<AddBankScreen> {
  final _accountNumberController = TextEditingController();
  final _bankCodeController = TextEditingController();
  final _bankNameController = TextEditingController();
  final _bankUserNameController = TextEditingController();

  late final prefs;
  @override
  void initState() {
    super.initState();

    initDefaultValue();
  }

  initDefaultValue() async {
    prefs = await SharedPreferences.getInstance();
  }

//  lấy thông tin vào truyền qua api đẻ thêm bank vào
  Future<void> handleAddNewBank() async {
    LocalBankModel localBankModel = LocalBankModel(
      accountNumber: _accountNumberController.text,
      bankCode: _bankCodeController.text,
      bankName: _bankNameController.text,
      bankUserName: _bankUserNameController.text,
    );

// goi toi service để tạo bank
    LocalBankModel? newData =
        await LocalBankService(context: context, prefs: prefs)
            .createLocalBank(localBankModel);

    if (newData != null) {
      // ignore: use_build_context_synchronously
      Provider.of<LocalBankProvider>(context, listen: false).addBank = newData;
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primaryBackground,
        centerTitle: true,
        title: Text(
          "Add New Bank",
          style: AppStyles.h4.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: AppColors.primaryBackground,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Fill in the fields below",
              style: AppStyles.h5
                  .copyWith(color: AppColors.greyText, fontSize: 16),
            ),
            const SizedBox(height: 20),
            ItemTextFieldWidget(
                textcontroller: _accountNumberController,
                hindText: "Account Number"),
            const SizedBox(height: 12),
            ItemTextFieldWidget(
                textcontroller: _bankCodeController, hindText: "Bank Code"),
            const SizedBox(height: 12),
            ItemTextFieldWidget(
                textcontroller: _bankNameController, hindText: "Bank Name"),
            const SizedBox(height: 12),
            ItemTextFieldWidget(
                textcontroller: _bankUserNameController,
                hindText: "Bank User Name"),
            const Spacer(),
            AppButton(text: "Create Bank", onTap: () => handleAddNewBank())
          ],
        ),
      ),
    );
  }
}
