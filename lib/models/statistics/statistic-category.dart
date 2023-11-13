class StatisticCategory {
  String typeTransaction;
  double percent;
  int totalAmount;

  StatisticCategory(
      {required this.typeTransaction,
      required this.percent,
      required this.totalAmount});

  factory StatisticCategory.fromJson(Map<String, dynamic> json) {
    return StatisticCategory(
      typeTransaction: json["typeTransaction"] as String,
      percent: json["percent"] as double,
      totalAmount: json["totalAmount"] as int,
    );
  }
}
