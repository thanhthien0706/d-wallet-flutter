import 'package:cn1_d_wallet/common/constant/app-colors.dart';
import 'package:cn1_d_wallet/common/constant/app_styles.dart';
import 'package:cn1_d_wallet/models/notification.model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemNotificationWidget extends StatelessWidget {
  NotificationModel notificationModel;

  ItemNotificationWidget({super.key, required this.notificationModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(right: 20),
                      child: notificationModel.type == "TRANSFER"
                          ? Icon(
                              Icons.transfer_within_a_station,
                              color: Colors.blue,
                            )
                          : notificationModel.type == "DEPOSIT"
                              ? Icon(
                                  Icons.credit_card,
                                  color: Colors.yellow,
                                )
                              : Icon(
                                  Icons.money,
                                  color: Colors.red,
                                ),
                      decoration: BoxDecoration(
                        color: notificationModel.type == "TRANSFER"
                            ? Colors.blue.withOpacity(0.2)
                            : notificationModel.type == "DEPOSIT"
                                ? Colors.yellow.withOpacity(0.2)
                                : Colors.red.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(notificationModel.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppStyles.h4.copyWith(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 6),
                        Text(
                            "${DateFormat('dd/MM/yyyy').format(DateTime.parse(notificationModel.createdAt))}",
                            style: AppStyles.h5.copyWith(
                                fontSize: 16, color: AppColors.greyText))
                      ],
                    )
                  ],
                ),
                //   if (!notificationModel.seenByUser)
                //     Container(
                //       padding:
                //           const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                //       decoration: BoxDecoration(
                //         color: Colors.blue,
                //         borderRadius: BorderRadius.circular(8),
                //       ),
                //       child: Text("New", style: AppStyles.h5),
                //     )
              ],
            ),
            const SizedBox(height: 10),
            Text(
              "${notificationModel.content}",
              style: AppStyles.h5.copyWith(color: AppColors.greyText),
            )
          ],
        ),
      ),
    );
  }
}
