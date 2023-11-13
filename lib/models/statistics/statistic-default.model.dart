class StatisticDefault {
  double? average;
  String? totalTransaction;
  int? highestAmount;
  int? lowestAmount;

  StatisticDefault({
    this.average,
    this.totalTransaction,
    this.highestAmount,
    this.lowestAmount,
  });

  factory StatisticDefault.fromJson(Map<String, dynamic> json) {
    return StatisticDefault(
      average: double.parse(json["average"].toString()),
      totalTransaction: json["totalTransaction"] as String?,
      highestAmount: json["highestAmount"] as int?,
      lowestAmount: json["lowestAmount"] as int?,
    );
  }
}
