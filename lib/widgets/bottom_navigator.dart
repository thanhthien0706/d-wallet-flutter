import 'package:cn1_d_wallet/common/constant/app-colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../common/constant/app_icons.dart';

// class BottomNavigationBarCustom extends StatelessWidget {
//   const BottomNavigationBarCustom(
//       {Key? key, required this.index, required this.onTap})
//       : super(key: key);

//   final int index;
//   final Function(int index) onTap;

//   @override
//   Widget build(BuildContext context) {
//     return StatefulBuilder(builder: (context, setState) {
//       return Container(
//         padding: const EdgeInsets.only(left: 16, right: 16),
//         color: AppColors.primaryBackground,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             IconButton(
//               onPressed: () {
//                 onTap(0);
//               },
//               icon: SvgPicture.asset(index == 0
//                   ? AppIcons.iconNavigatorHomeOn
//                   : AppIcons.iconNavigatorHome),
//             ),
//             IconButton(
//               onPressed: () {
//                 onTap(1);
//               },
//               icon: SvgPicture.asset(index == 1
//                   ? AppIcons.iconNavigatorStatisticOn
//                   : AppIcons.iconNavigatorStatistic),
//             ),
//             const SizedBox(),
//             IconButton(
//               onPressed: () {
//                 onTap(2);
//               },
//               icon: SvgPicture.asset(index == 2
//                   ? AppIcons.iconNavigatorNotificationOn
//                   : AppIcons.iconNavigatorNotification),
//             ),
//             IconButton(
//               onPressed: () {
//                 onTap(3);
//               },
//               icon: SvgPicture.asset(index == 3
//                   ? AppIcons.iconNavigatorProfileOn
//                   : AppIcons.iconNavigatorProfile),
//             ),
//           ],
//         ),
//       );
//     });
//   }
// }

class BottomNavigationBarCustom extends StatefulWidget {
  final List<Widget> tabs;
  final int index;
  final Function(int index) onTap;

  const BottomNavigationBarCustom(
      {Key? key, required this.tabs, required this.index, required this.onTap})
      : super(key: key);

  @override
  State<BottomNavigationBarCustom> createState() =>
      _BottomNavigationBarCustomState();
}

class _BottomNavigationBarCustomState extends State<BottomNavigationBarCustom> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16),
      color: AppColors.primaryBackground,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              widget.onTap(0);
            },
            icon: SvgPicture.asset(widget.index == 0
                ? AppIcons.iconNavigatorHomeOn
                : AppIcons.iconNavigatorHome),
          ),
          IconButton(
            onPressed: () {
              widget.onTap(1);
            },
            icon: SvgPicture.asset(widget.index == 1
                ? AppIcons.iconNavigatorStatisticOn
                : AppIcons.iconNavigatorStatistic),
          ),
          const SizedBox(),
          IconButton(
            onPressed: () {
              widget.onTap(2);
            },
            icon: SvgPicture.asset(widget.index == 2
                ? AppIcons.iconNavigatorNotificationOn
                : AppIcons.iconNavigatorNotification),
          ),
          IconButton(
            onPressed: () {
              widget.onTap(3);
            },
            icon: SvgPicture.asset(widget.index == 3
                ? AppIcons.iconNavigatorProfileOn
                : AppIcons.iconNavigatorProfile),
          ),
        ],
      ),
    );
  }
}
