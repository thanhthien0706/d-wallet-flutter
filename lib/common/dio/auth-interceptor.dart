import 'dart:convert';

import 'package:cn1_d_wallet/common/constant/app_endpoint.dart';
import 'package:cn1_d_wallet/common/values/share-key.dart';
import 'package:cn1_d_wallet/pages/auth/sign-in/signin-page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart' hide Response;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../app_flavor.dart';

class AuthInterceptor extends Interceptor {
  static Future<Interceptor> getInterceptor(BuildContext context) async {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        options.headers["Content-Type"] = 'application/json';
        final _prefs = await SharedPreferences.getInstance();
        if (!options.path.contains('http')) {
          options.path = AppEndpoint.mainEndpoint + options.path;
        }

        options.connectTimeout = 3000 as Duration?;
        options.receiveTimeout = 3000 as Duration?;

        String? accessToken = _prefs.getString(ShareKey.ACCESS_TOKEN);
        String? expiredTime = _prefs.getString(ShareKey.EXPIRED_TIME);
        String? refreshToken = _prefs.getString(ShareKey.REFRESH_TOKEN);

        if (accessToken == null ||
            expiredTime == null ||
            refreshToken == null) {
          return handler.next(options);
        }

        final expiredTimeConvert = DateTime.parse(expiredTime);
        final isExpired = DateTime.now().isAfter(expiredTimeConvert);

        if (isExpired) {
          try {
            options.headers['Authorization'] = "Bearer $refreshToken";
            Uri url = Uri.parse(AppEndpoint.authEndpoint + "refresh");
            final response = await http.get(url);

            if (response.statusCode == 200) {
              var decodeReponse = jsonDecode(response.body);
              _prefs.setString(
                  ShareKey.ACCESS_TOKEN, decodeReponse.accessToken);
              _prefs.setString(
                  ShareKey.ACCESS_TOKEN, decodeReponse.accessToken);
              _prefs.setString(ShareKey.EXPIRED_TIME,
                  DateTime.now().add(const Duration(minutes: 15)).toString());
            } else {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => SigninPage()),
                  (route) => false);
            }
            return handler.next(options);
          } on DioError catch (e) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => SigninPage()),
                (route) => false);
            return handler.reject(e, true);
          }
        } else {
          options.headers['Authorization'] = "Bearer $accessToken";
          return handler.next(options);
        }
      },
      onResponse: (Response response, handler) {
        // Do something with response data
        return handler.next(response);
      },
      onError: (DioError error, ErrorInterceptorHandler handler) async {
        if (error.response?.statusCode == 401) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => SigninPage()),
              (route) => false);
        } else {
          handler.next(error);
        }
      },
    );
  }
}
