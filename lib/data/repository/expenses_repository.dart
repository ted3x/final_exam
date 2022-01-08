import 'package:dio/dio.dart';
import 'package:final_exam/data/model/expense.dart';

class ExpensesRepository {
  Dio dio = Dio();

  Future<List<Expense>?>? fetchExpenses() async {
    final response = await dio.get('https://jsonkeeper.com/b/SVV4');
    var expenses = <Expense>[];
    if (response.statusCode == 200) {
      response.data.forEach((expenseJson) {
        Expense expense = Expense.fromJson(expenseJson);
        expenses.add(expense);
        return expenses;
      });
    }
    return expenses;
  }

  Future<void>? addExpense(Expense expense) async {
    await dio.post('http://0.0.0.0:8080/add-expense', data: expense.toJson());
  }

  Future<void>? deleteExpense(int id) async {
    await dio.delete('http://0.0.0.0:8080/delete-expense/$id');
  }

  Future<void>? updateExpense(Expense expense) async {
    await dio.put('http://0.0.0.0:8080/update-expense', data: expense.toJson());
  }
}