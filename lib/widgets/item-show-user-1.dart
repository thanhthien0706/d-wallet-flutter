import 'package:cn1_d_wallet/models/users/account.model.dart';
import 'package:cn1_d_wallet/providers/transfer-provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/constant/app-colors.dart';
import '../common/constant/app_styles.dart';

class ItemShowUser1 extends StatefulWidget {
  final AccountModel accontModel;
  const ItemShowUser1({super.key, required this.accontModel});

  @override
  State<ItemShowUser1> createState() => _ItemShowUser1State();
}

class _ItemShowUser1State extends State<ItemShowUser1> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<TransferProvider>(context, listen: false).account =
            widget.accontModel;
        Navigator.pop(context);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
            width: 50,
            child: CircleAvatar(
              backgroundImage: NetworkImage(widget.accontModel.avatar ??
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSeeJ6oLaKkQiCeiH6DHrRu492XWtwaf44wJkt6hLBBUg&s"),
            ),
          ),
          const SizedBox(width: 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.accontModel.name!,
                style: AppStyles.h5.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                widget.accontModel.phone ?? "",
                style: AppStyles.h5.copyWith(color: AppColors.greyText),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                widget.accontModel.email!,
                style: AppStyles.h5.copyWith(color: AppColors.greyText),
              ),
            ],
          )
        ],
      ),
    );
  }
}
