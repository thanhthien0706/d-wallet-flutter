import 'package:cn1_d_wallet/models/notification.model.dart';
import 'package:cn1_d_wallet/models/pagination.dart';
import 'package:cn1_d_wallet/pages/notifications/views/item-notification-widget.dart';
import 'package:cn1_d_wallet/services/notification-service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/constant/app-colors.dart';
import '../../common/constant/app_styles.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  PaginationModel<NotificationModel>? notificationsModel;
  SharedPreferences? prefs;

  @override
  void initState() {
    super.initState();
    initDataDefault();
  }

  // Lấy Data từ api thông qua providers
  initDataDefault() async {
    prefs = await SharedPreferences.getInstance();
    final datas = await NotificationService(context: context, prefs: prefs)
        .getAllNotifications();
    setState(() {
      notificationsModel = datas;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primaryBackground,
        centerTitle: true,
        title: Text(
          "Notifications",
          style: AppStyles.h4.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: AppColors.primaryBackground,

      // render giao diện
      body: notificationsModel != null
          ? Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: ListView(
                children: notificationsModel!.data
                    .map((e) => ItemNotificationWidget(notificationModel: e))
                    .toList(),
              ),
            )
          : Center(
              child: Text(
                "List local bank is empty",
                style: AppStyles.h4.copyWith(color: AppColors.greyText),
              ),
            ),
    );
  }
}
