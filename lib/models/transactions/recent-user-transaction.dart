import 'package:cn1_d_wallet/models/users/account.model.dart';

class PaginationAccountModel {
  final List<AccountModel> data;
  final int total;

  PaginationAccountModel({required this.data, required this.total});
}
