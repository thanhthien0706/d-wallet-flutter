import 'package:cn1_d_wallet/common/constant/app-colors.dart';
import 'package:cn1_d_wallet/common/constant/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../deposit/select-method-screen.dart';
import '../../transfers/transfer-main.dart';
import '../../withdraw/item-bank-screen.dart';

class HomeScreenMainAction extends StatefulWidget {
  const HomeScreenMainAction({super.key});

  @override
  State<HomeScreenMainAction> createState() => _HomeScreenMainActionState();
}

class _HomeScreenMainActionState extends State<HomeScreenMainAction> {
  @override
  Widget build(BuildContext context) {
    List<ActionMainHome> actionMainHome = [
      ActionMainHome(
        AppIcons.iconTransfer,
        'Transfer',
        () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => TransferMainScreen(),
            ),
          );
        },
      ),
      ActionMainHome(
        AppIcons.iconTopup,
        'Deposit',
        () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => SelectMethodScreen(),
            ),
          );
        },
      ),
      ActionMainHome(
        AppIcons.iconHistory,
        'Withdraw',
        () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ItemMLocaBankodPayScreen(),
            ),
          );
        },
      ),
    ];

    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 24),
      padding: const EdgeInsets.only(),
      height: 84,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              HomeScreenMainActionDivider(),
              HomeScreenMainActionDivider(),
            ],
          ),
          Row(
            children: actionMainHome.map(
              (e) {
                return Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      e.route();
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          e.img,
                          height: 32,
                          width: 32,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(e.text,
                            style: context.textTheme.bodyMedium
                                ?.copyWith(color: Colors.white))
                      ],
                    ),
                  ),
                );
              },
            ).toList(),
          )
        ],
      ),
    );
  }
}

class ActionMainHome {
  final String img;
  final String text;
  final VoidCallback route;
  const ActionMainHome(this.img, this.text, this.route);
}

class HomeScreenMainActionDivider extends StatelessWidget {
  const HomeScreenMainActionDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 1,
          height: 40,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                Colors.white,
                Colors.white,
              ],
                  stops: [
                0.0,
                1.0
              ],
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  tileMode: TileMode.repeated)),
        ),
      ],
    );
  }
}
