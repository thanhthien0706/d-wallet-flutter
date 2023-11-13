import 'package:cn1_d_wallet/models/transactions/card-model.dart';
import 'package:cn1_d_wallet/providers/card-provider.dart';
import 'package:cn1_d_wallet/services/card-service.dart';
import 'package:cn1_d_wallet/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/constant/app-colors.dart';
import '../../common/constant/app_styles.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final _cardNumberController = TextEditingController();
  final _expMonthController = TextEditingController();
  final _expYearController = TextEditingController();
  final _cvcController = TextEditingController();

  late final prefs;
  @override
  void initState() {
    super.initState();

    initDefaultValue();
  }

  initDefaultValue() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> handleAddNewCard() async {
    CardModel dataCard = CardModel(
        number: _cardNumberController.text,
        expMonth: _expMonthController.text,
        expYear: _expYearController.text,
        cvc: _cvcController.text);

    CardModel? newCard =
        await CardService(context: context, prefs: prefs).createCard(dataCard);
    CardProvider _cardProvider =
        // ignore: use_build_context_synchronously
        Provider.of<CardProvider>(context, listen: false);

    if (newCard != null) {
      _cardProvider.addCard = newCard;
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
          "Add New Card",
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextField(
                controller: _cardNumberController,
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
                  hintText: 'Card Number',
                  hintStyle: const TextStyle(
                    color: AppColors.greyText,
                  ),
                  fillColor: AppColors.backgroudSecondColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _expMonthController,
                      decoration: InputDecoration(
                        filled: true,
                        contentPadding: const EdgeInsets.all(20),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.textColor.withOpacity(0.2)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.primaryColor),
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        hintText: 'Month',
                        hintStyle: const TextStyle(
                          color: AppColors.greyText,
                        ),
                        fillColor: AppColors.backgroudSecondColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _expYearController,
                      decoration: InputDecoration(
                        filled: true,
                        contentPadding: const EdgeInsets.all(20),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.textColor.withOpacity(0.2)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.primaryColor),
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        hintText: 'Year',
                        hintStyle: const TextStyle(
                          color: AppColors.greyText,
                        ),
                        fillColor: AppColors.backgroudSecondColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _cvcController,
                      decoration: InputDecoration(
                        filled: true,
                        contentPadding: const EdgeInsets.all(20),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.textColor.withOpacity(0.2)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.primaryColor),
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        hintText: 'CVC',
                        hintStyle: const TextStyle(
                          color: AppColors.greyText,
                        ),
                        fillColor: AppColors.backgroudSecondColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            AppButton(text: "Create Card", onTap: () => handleAddNewCard())
          ],
        ),
      ),
    );
  }
}
