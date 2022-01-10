import 'package:final_exam/data/model/expense.dart';

class ExpensesHelper {
  double sumOfExpenses(List<Expense> expenses) {
    double sum = 0;
    for (int i = 0; i < expenses.length; i++) {
      sum += expenses[i].amount;
    }
    return sum;
  }
}