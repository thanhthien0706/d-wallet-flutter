import 'package:cn1_d_wallet/common/constant/app_styles.dart';
import 'package:flutter/material.dart';

import '../profile-screent.dart';

class ItemService extends StatefulWidget {
  final List<ItemProfileModel> itemModels;

  const ItemService({super.key, required this.itemModels});

  @override
  State<ItemService> createState() => _ItemServiceState();
}

class _ItemServiceState extends State<ItemService> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.itemModels
          .map(
            (item) => InkWell(
              onTap: () {
                item.onTap(context);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(right: 20),
                          child: Icon(
                            item.icon,
                            color: item.color,
                          ),
                          decoration: BoxDecoration(
                            color: item.color.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        Text(
                          item.title,
                          style: AppStyles.h5.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                    )
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
