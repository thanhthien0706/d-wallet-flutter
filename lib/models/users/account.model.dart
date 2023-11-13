import '../../common/enum/gender-type.dart';

class AccountModel {
  int? id;
  String? email;
  String? name;
  String? avatar;
  String? phone;
  String? password;
  String? gender;
  String? address;
  String? dob;
  String? createAt;
  String? updateAt;
  String? deleteAt;
  String? fullname;

  AccountModel(
      {this.id,
      this.email = "",
      this.name = "",
      this.avatar = "",
      this.phone = "",
      this.password = "",
      this.gender,
      this.address = "",
      this.dob = "",
      this.createAt = "",
      this.updateAt = "",
      this.deleteAt = "",
      this.fullname = ""});

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      id: json['id'] as int?,
      email: json['email'] as String?,
      name: json['name'] as String?,
      avatar: json['avatar'] as String?,
      phone: json['phone'] as String?,
      password: json['password'] as String?,
      gender: json['gender'] == "MALE" ? GenderType[0] : GenderType[1],
      address: json['address'] as String?,
      dob: json['dob'] as String?,
      createAt: json['createAt'] as String?,
      updateAt: json['updateAt'] as String?,
      fullname: json['fullname'] as String?,
      deleteAt: json['deleteAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'avatar': avatar,
      'phone': phone,
      'password': password,
      'gender': gender,
      'address': address,
      'dob': dob,
      'createAt': createAt,
      'updateAt': updateAt,
      'fullname': fullname,
      'deleteAt': deleteAt,
    };
  }
}
