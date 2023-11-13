import 'dart:convert';

import 'package:cn1_d_wallet/models/transactions/card-model.dart';
import 'package:cn1_d_wallet/services/auth-service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../common/constant/app_endpoint.dart';
import '../models/pagination.dart';
import 'bases/header-endpoint.dart';

class CardService {
  final BuildContext? context;
  final SharedPreferences? prefs;

  CardService({this.context, this.prefs});

  Future<CardModel?> createCard(CardModel cardModel) async {
    try {
      Uri url = Uri.parse(AppEndpoint.cardsDefaultEndpoint);
      var response = await http.post(url,
          headers:
              HeaderEndpointService.getStaticAccessTokenBaseEndpoint(prefs!),
          body: jsonEncode(cardModel.toJson()));

      var dataReponse = jsonDecode(response.body) as Map;
      print(dataReponse);

      if (dataReponse["statusCode"] == 401) {
        bool? refreshToken = await AuthService(context: context!, prefs: prefs!)
            .getRefreshToken();
        refreshToken! ? createCard(cardModel) : null;

        return null;
      }

      return CardModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      print("Error : $e");
    }
  }

  Future<PaginationModel<CardModel>?> getAllCards() async {
    try {
      Uri url = Uri.parse(AppEndpoint.cardsEndpoint + "findAllCard");

      var response = await http.get(url,
          headers:
              HeaderEndpointService.getStaticAccessTokenBaseEndpoint(prefs!));

      var dataReponse = jsonDecode(response.body) as Map;

      if (dataReponse["statusCode"] == 401) {
        bool? refreshToken = await AuthService(context: context!, prefs: prefs!)
            .getRefreshToken();
        refreshToken! ? getAllCards() : null;

        return null;
      }

      final cards = List<CardModel>.from(
          dataReponse["data"].map((card) => CardModel.fromJson(card)));
      return PaginationModel<CardModel>(
          data: cards, total: dataReponse["total"]);
    } catch (e) {
      print("Error : $e");
    }
  }
}
