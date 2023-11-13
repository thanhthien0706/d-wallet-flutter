import 'package:cn1_d_wallet/models/users/account.model.dart';

class AuthModel {
  final String accessToken;
  final String refreshToken;
  final AccountModel? account;

  AuthModel(
      {required this.accessToken, required this.refreshToken, this.account});

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
        account: json["account"] != null
            ? AccountModel.fromJson(json["account"])
            : null);
  }
}
