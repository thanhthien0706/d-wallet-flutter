import 'package:cn1_d_wallet/providers/transfer-provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/constant/app-colors.dart';
import '../../../common/constant/app_styles.dart';
import '../../../widgets/item-show-user-1.dart';
import '../search-user.dart';

class TransferSearchUser extends StatefulWidget {
  const TransferSearchUser({super.key});

  @override
  State<TransferSearchUser> createState() => _TransferSearchUserState();
}

class _TransferSearchUserState extends State<TransferSearchUser> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TransferProvider>(builder: (context, provider, child) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Contact",
              style: AppStyles.h4.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Expanded(child: Text("Search user by phone, email, name")),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => SearchUserScreen()),
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: 50,
                    child: Icon(Icons.search),
                    decoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              child: provider.accountModel != null
                  ? ItemShowUser1(
                      accontModel: provider.accountModel!,
                    )
                  : null,
            )
          ],
        ),
      );
    });
  }
}
