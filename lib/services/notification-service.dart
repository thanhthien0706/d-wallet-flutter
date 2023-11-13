import 'dart:convert';

import 'package:cn1_d_wallet/models/notification.model.dart';
import 'package:cn1_d_wallet/models/pagination.dart';
import 'package:cn1_d_wallet/services/auth-service.dart';
import 'package:cn1_d_wallet/services/bases/header-endpoint.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../common/constant/app_endpoint.dart';

class NotificationService {
  final BuildContext? context;
  final SharedPreferences? prefs;

  NotificationService({this.context, this.prefs});

  Future<PaginationModel<NotificationModel>?> getAllNotifications() async {
    try {

      // khởi tạo uri 
      Uri url = Uri.parse(AppEndpoint.notificationsEndpoint);

      // 
      var response = await http.get(
        url,
        headers: HeaderEndpointService.getStaticAccessTokenBaseEndpoint(prefs!),
      );
      var dataReponse = jsonDecode(response.body) as Map;

      if (dataReponse["statusCode"] == 401) {
        bool? refreshToken = await AuthService(context: context!, prefs: prefs!)
            .getRefreshToken();
        refreshToken! ? getAllNotifications() : null;

        return null;
      }


      // chuyển dạng Map sang dạng List
      final notifications = List<NotificationModel>.from(dataReponse["data"]
          .map((notification) => NotificationModel.fromJson(notification)));
          
      return PaginationModel<NotificationModel>(
          data: notifications, total: dataReponse["total"]);
    } catch (e) {
      print("Error : $e");
    }
  }
}
