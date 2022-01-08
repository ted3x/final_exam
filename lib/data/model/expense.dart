import 'dart:core';

class Expense {
  late final int id;
  late final String expenseTitle;
  late final int amount;
  late final DateTime date;

  Expense({required this.id, required this.expenseTitle, required this.amount, required this.date});

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'],
      expenseTitle: json['expenseTitle'],
      amount: json['amount'],
      date: DateTime.parse(json['date'])
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'expenseTitle': expenseTitle,
    'amount': amount,
    'date': date,
  };
}