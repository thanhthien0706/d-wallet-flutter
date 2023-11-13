import 'package:cn1_d_wallet/models/pagination.dart';
import 'package:cn1_d_wallet/models/transactions/card-model.dart';
import 'package:cn1_d_wallet/services/card-service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CardProvider extends ChangeNotifier {
  PaginationModel<CardModel>? _cardModels;

  PaginationModel<CardModel>? get cardModels => _cardModels;

  set addCard(CardModel newCard) {
    _cardModels!.data.add(newCard);
    notifyListeners();
  }

  Future<void> fetchCardModels(
      BuildContext context, SharedPreferences prefs) async {
    try {
      PaginationModel<CardModel>? cardModels =
          await CardService(context: context, prefs: prefs).getAllCards();
      if (cardModels != null) {
        _cardModels = cardModels;
        notifyListeners();
      } else {
        throw Exception('Failed to load item card');
      }
    } catch (e) {
      print("Error : $e");
    }
  }
}
