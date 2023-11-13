class StatisticIncomeExpense {
  int label;
  int income;
  int expense;

  StatisticIncomeExpense(
      {required this.label, required this.income, required this.expense});

  factory StatisticIncomeExpense.fromJson(Map<String, dynamic> json) {
    return StatisticIncomeExpense(
      expense: json["expense"] as int,
      income: json["income"] as int,
      label: json["label"] as int,
    );
  }
}
