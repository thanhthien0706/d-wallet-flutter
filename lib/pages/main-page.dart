import 'package:cn1_d_wallet/pages/notifications/notification-screen.dart';
import 'package:cn1_d_wallet/pages/profiles/profile-screent.dart';
import 'package:cn1_d_wallet/pages/statistics/statistics-main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../common/constant/app-colors.dart';
import '../common/constant/app_icons.dart';
import '../widgets/bottom_navigator.dart';
import 'home/home-page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = <Widget>[
      HomePage(),
      StatisticMainScreen(),
      NotificationScreen(),
      ProfileScreen(),
    ];

    void _onItemTapped(int index) {
      _selectedIndex = index;
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
      body: tabs.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBarCustom(
        tabs: tabs,
        index: _selectedIndex,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: AppColors.primaryOrange,
        onPressed: () {},
        child: SvgPicture.asset(AppIcons.iconQr),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
