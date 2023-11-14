import 'dart:convert';

import 'package:cn1_d_wallet/common/constant/app_endpoint.dart';
import 'package:cn1_d_wallet/common/values/share-key.dart';
import 'package:cn1_d_wallet/models/auth/auth.model.dart';
import 'package:cn1_d_wallet/models/users/account.model.dart';
import 'package:cn1_d_wallet/pages/auth/sign-in/signin-page.dart';
import 'package:cn1_d_wallet/services/bases/header-endpoint.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final SharedPreferences? prefs;
  final BuildContext? context;

  AuthService({this.prefs, this.context});

  Future<AuthModel?> signup(BuildContext context, AccountModel account) async {
    try {
      Uri url = Uri.parse(AppEndpoint.authEndpoint + "signup");

      var body = jsonEncode({
        "email": account.email,
        "name": account.name,
        "password": account.password
      });

      var response = await http.post(url,
          headers: {'Content-Type': 'application/json'}, body: body);
      return AuthModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      print("Error : $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred while calling the API'),
        ),
      );
    }
  }

  Future<AuthModel?> signin(BuildContext context, AccountModel account) async {
    try {
      Uri url = Uri.parse(AppEndpoint.authEndpoint + "signin");

      var body =
          jsonEncode({"email": account.email, "password": account.password});

      var response = await http.post(url,
          headers: {'Content-Type': 'application/json'}, body: body);

      print(AuthModel.fromJson(jsonDecode(response.body)).accessToken);
      return AuthModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      print("Error : $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred while calling the API'),
        ),
      );
    }
  }

  Future<bool?> getRefreshToken() async {
    try {
      await prefs!.remove(ShareKey.ACCESS_TOKEN);
      await prefs!.remove(ShareKey.EXPIRED_TIME);

      Uri url = Uri.parse(AppEndpoint.authEndpoint + "refresh");

      var response = await http.get(url,
          headers:
              HeaderEndpointService.getStaticRefreshTokenBaseEndpoint(prefs!));

      var data = jsonDecode(response.body) as Map;

      if (data["statusCode"] == 401) {
        Navigator.push(
            context!, MaterialPageRoute(builder: (_) => SigninPage()));
      } else {
        prefs!.setString(ShareKey.ACCESS_TOKEN, data["accessToken"]);
        prefs!.setString(ShareKey.REFRESH_TOKEN, data["refreshToken"]);
        prefs!.setString(ShareKey.EXPIRED_TIME,
            DateTime.now().add(const Duration(minutes: 15)).toString());
        return true;
      }
    } catch (e) {
      print("Error : $e");
    }
  }
}
