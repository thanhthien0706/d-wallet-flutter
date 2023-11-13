class BalanceHistoryModel {
  int? id;
  String? createAt;
  String? updateAt;
  String? deleteAt;
  int value = 0;
  String? status;

  BalanceHistoryModel(
      {this.id,
      this.createAt,
      this.updateAt,
      this.deleteAt,
      this.value = 0,
      this.status});

  factory BalanceHistoryModel.fromJson(Map<String, dynamic> json) {
    return BalanceHistoryModel(
      id: json['id'] as int?,
      createAt: json['createAt'] as String?,
      updateAt: json['updateAt'] as String?,
      deleteAt: json['deleteAt'] as String?,
      value: json['value'] as int,
      status: json['status'] as String?,
    );
  }
}
