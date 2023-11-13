import 'package:cn1_d_wallet/models/users/account.model.dart';
import 'package:cn1_d_wallet/services/user_services.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileProvider extends ChangeNotifier {
  AccountModel? _userProfile;

  AccountModel? get userProfile => _userProfile;

  set setAvatar(String avatar) {
    _userProfile!.avatar = avatar;
    notifyListeners();
  }

  set setPhone(String phone) {
    _userProfile!.phone = phone;
    notifyListeners();
  }

  set setAddress(String address) {
    _userProfile!.address = address;
    // notifyListeners();
  }

  set setDob(String dob) {
    _userProfile!.dob = dob;
    notifyListeners();
  }

  set setGender(String gender) {
    _userProfile!.gender = gender;
    notifyListeners();
  }

  Future<void> fetchUserProfile(
      BuildContext context, SharedPreferences prefs) async {
    AccountModel? responseAccount =
        await UserService(context: context, prefs: prefs).getInformationUser();

    if (responseAccount != null) {
      _userProfile = responseAccount;
      notifyListeners();
    } else {
      // ignore: use_build_context_synchronously
      fetchUserProfile(context, prefs);
    }
  }

  Future<void> updateUserProfile(
    BuildContext context,
    SharedPreferences prefs,
  ) async {
    try {
      AccountModel? userProfile =
          await UserService(context: context, prefs: prefs)
              .updateInformationUser(_userProfile!);

      notifyListeners();
    } catch (e) {
      print("Error : $e");
    }
  }
}
