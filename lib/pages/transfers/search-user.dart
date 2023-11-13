import 'package:cn1_d_wallet/common/constant/app-colors.dart';
import 'package:cn1_d_wallet/models/transactions/recent-user-transaction.dart';
import 'package:cn1_d_wallet/models/users/account.model.dart';
import 'package:cn1_d_wallet/services/user_services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/item-show-user-1.dart';

class SearchUserScreen extends StatefulWidget {
  const SearchUserScreen({super.key});

  @override
  State<SearchUserScreen> createState() => _SearchUserScreenState();
}

class _SearchUserScreenState extends State<SearchUserScreen> {
  final _searchController = TextEditingController();
  bool _isFocusedSearch = false;
  late final prefs;

  List<AccountModel> dataUsers = [];
  @override
  void initState() {
    super.initState();

    initDefaultValue();
  }

  initDefaultValue() async {
    prefs = await SharedPreferences.getInstance();
  }

  _handleApiSearchUser(String text) async {
    PaginationAccountModel? dataUsersApi =
        await UserService(context: context, prefs: prefs).searchUsers(text);
    setState(() {
      dataUsers = dataUsersApi == null ? [] : dataUsersApi.data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      backgroundColor: AppColors.primaryBackground,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                _handleApiSearchUser(value);
              },
              maxLines: 1,
              controller: _searchController,
              decoration: InputDecoration(
                filled: true,
                contentPadding: const EdgeInsets.all(20),
                border: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.textColor.withOpacity(0.2)),
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primaryColor),
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                hintText: 'Enter text search',
                hintStyle: TextStyle(
                  color: _isFocusedSearch
                      ? AppColors.primaryColor
                      : AppColors.greyText,
                ),
                fillColor: AppColors.backgroudSecondColor,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: dataUsers.length,
                itemBuilder: (BuildContext context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ItemShowUser1(
                      accontModel: dataUsers[index],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
