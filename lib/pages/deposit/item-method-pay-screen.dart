import 'package:cn1_d_wallet/common/constant/app-colors.dart';
import 'package:cn1_d_wallet/common/constant/app_styles.dart';
import 'package:cn1_d_wallet/models/pagination.dart';
import 'package:cn1_d_wallet/models/transactions/card-model.dart';
import 'package:cn1_d_wallet/pages/deposit/add-card-screen.dart';
import 'package:cn1_d_wallet/pages/deposit/widgets/item-infor-card-widget.dart';
import 'package:cn1_d_wallet/providers/card-provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class ItemMethodPayScreen extends StatefulWidget {
  int idMethod;
  ItemMethodPayScreen({super.key, required this.idMethod});

  @override
  State<ItemMethodPayScreen> createState() => _ItemMethodPayScreenState();
}

class _ItemMethodPayScreenState extends State<ItemMethodPayScreen> {
  late final SharedPreferences prefs;
  late final CardProvider _cardProvider;

  @override
  void initState() {
    super.initState();
    initDefaultValues();
  }

  initDefaultValues() async {
    prefs = await SharedPreferences.getInstance();
    // ignore: use_build_context_synchronously
    _cardProvider = Provider.of<CardProvider>(context, listen: false);
    // ignore: use_build_context_synchronously
    await _cardProvider.fetchCardModels(context, prefs);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primaryBackground,
        centerTitle: true,
        title: Text(
          "List of ${widget.idMethod == 0 ? 'Cards' : 'Banks'}",
          style: AppStyles.h4.copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => AddCardScreen()));
              },
              icon: Icon(Icons.add))
        ],
      ),
      backgroundColor: AppColors.primaryBackground,
      body: Consumer<CardProvider>(
        builder: (context, cardProvider, child) {
          PaginationModel<CardModel>? _cardModels = cardProvider.cardModels;

          return _cardModels != null && _cardModels.data.isNotEmpty
              ? ListView(
                  children: _cardModels.data
                      .map((e) => ItemInforCardWidget(cardModel: e))
                      .toList(),
                )
              : Center(
                  child: Text(
                    "List card is empty",
                    style: AppStyles.h4.copyWith(color: AppColors.greyText),
                  ),
                );
        },
      ),
    );
  }
}
