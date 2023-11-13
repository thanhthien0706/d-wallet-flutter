import 'package:flutter/material.dart';

import '../../../common/constant/app-colors.dart';
import '../../../common/constant/app_styles.dart';
import '../../../models/users/account.model.dart';

class TransferRecentUser extends StatefulWidget {
  final List<AccountModel> recentUsers;

  const TransferRecentUser({super.key, required this.recentUsers});

  @override
  State<TransferRecentUser> createState() => _TransferRecentUserState();
}

class _TransferRecentUserState extends State<TransferRecentUser> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(12),
        // height: 166,
        decoration: const BoxDecoration(
          color: AppColors.backgroudSecondColor,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recent",
                  style: AppStyles.h4.copyWith(fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "See all contact",
                    style: AppStyles.h5.copyWith(color: AppColors.primaryColor),
                  ),
                )
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: widget.recentUsers
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 50,
                                width: 50,
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(e.avatar ??
                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSeeJ6oLaKkQiCeiH6DHrRu492XWtwaf44wJkt6hLBBUg&s"),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(e.name ?? "")
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
