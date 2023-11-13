import 'package:cn1_d_wallet/common/constant/app-colors.dart';
import 'package:cn1_d_wallet/common/values/share-key.dart';
import 'package:cn1_d_wallet/models/users/account.model.dart';
import 'package:cn1_d_wallet/pages/auth/sign-in/signin-page.dart';
import 'package:cn1_d_wallet/pages/profiles/personal-screen.dart';
import 'package:cn1_d_wallet/pages/profiles/views/item-service.dart';
import 'package:cn1_d_wallet/pages/profiles/views/profile-header.dart';
import 'package:cn1_d_wallet/pages/profiles/views/profile-user.dart';
import 'package:cn1_d_wallet/providers/user-profile-provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _avatar =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSeeJ6oLaKkQiCeiH6DHrRu492XWtwaf44wJkt6hLBBUg&s";
  String _fullname = "";
  String _email = "";
  String _phone = "";

  late UserProfileProvider _userProfileProvider;
  late final SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initDefaultValue();
  }

  initDefaultValue() async {
    prefs = await SharedPreferences.getInstance();
    _userProfileProvider =
        // ignore: use_build_context_synchronously
        Provider.of<UserProfileProvider>(context, listen: false);
  }

  final List<ItemProfileModel> _itemServices = <ItemProfileModel>[
    ItemProfileModel(
        icon: Icons.person,
        title: "Personal",
        color: Colors.blue,
        onTap: (BuildContext context) async {
          await Future.delayed(Duration(microseconds: 500), () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => PersonalScreen()));
          });
        }),
    ItemProfileModel(
        icon: Icons.lock,
        title: "Privacy & Security",
        color: Colors.yellow,
        onTap: (BuildContext context) async {}),
    ItemProfileModel(
        icon: Icons.wallet_giftcard,
        title: "Offers & Rewards",
        color: Colors.purple,
        onTap: (BuildContext context) async {}),
    ItemProfileModel(
        icon: Icons.help,
        title: "Help",
        color: Colors.green,
        onTap: (BuildContext context) async {}),
    ItemProfileModel(
      icon: Icons.logout,
      title: "Logout",
      color: Colors.pink,
      onTap: (BuildContext context) async {
        final prefs = await SharedPreferences.getInstance();
        await Future.delayed(Duration(seconds: 2));

        await prefs.remove(ShareKey.ACCESS_TOKEN);
        await prefs.remove(ShareKey.EXPIRED_TIME);
        await prefs.remove(ShareKey.REFRESH_TOKEN);

        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) => SigninPage()), (route) => false);
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: Consumer<UserProfileProvider>(
        builder: (context, userProfileProvider, child) {
          final AccountModel? userProfile = userProfileProvider.userProfile;

          if (userProfile != null) {
            _avatar = userProfile.avatar ?? _avatar;
            _email = userProfile.email ?? _email;
            _fullname = userProfile.name ?? _fullname;
            _phone = userProfile.phone ?? _phone;
          }

          return ListView(
            padding: const EdgeInsets.only(left: 16, right: 16),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: [
              ProfileHeaderScreen(),
              ProfileUserScreen(
                  avatar: _avatar,
                  email: _email,
                  fullname: _fullname,
                  phone: _phone),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10),
                child: Divider(
                  color: AppColors.greyText.withOpacity(0.5),
                  thickness: 0.5,
                ),
              ),
              ItemService(itemModels: _itemServices)
            ],
          );
        },
      ),
    );
  }
}

class ItemProfileModel {
  final IconData icon;
  final String title;
  Function(BuildContext context) onTap;
  final MaterialColor color;

  ItemProfileModel(
      {required this.icon,
      required this.title,
      required this.color,
      required this.onTap});
}
