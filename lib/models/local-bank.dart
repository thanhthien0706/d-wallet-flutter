class LocalBankModel {
  int? id;
  String? accountNumber;
  String? bankCode;
  String? bankName;
  String? bankUserName;

  LocalBankModel(
      {this.id,
      this.accountNumber,
      this.bankCode,
      this.bankName,
      this.bankUserName});

  factory LocalBankModel.fromJson(Map<String, dynamic> json) {
    return LocalBankModel(
      id: json["id"] as int?,
      accountNumber: json["accountNumber"] as String?,
      bankCode: json["bankCode"] as String?,
      bankName: json["bankName"] as String?,
      bankUserName: json["bankUserName"] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "accountNumber": accountNumber,
      "bankCode": bankCode,
      "bankName": bankName,
      "bankUserName": bankUserName,
    };
  }
}
