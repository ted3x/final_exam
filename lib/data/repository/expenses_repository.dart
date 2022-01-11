import 'package:dio/dio.dart';
import 'package:final_exam/data/model/expense.dart';

class ExpensesRepository {
  Dio dio = Dio();

  Future<List<Expense>?>? fetchExpenses() async {
    final response = await dio.get('http://192.168.1.107:8080/expenses');
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

  Future<List<Expense>?>? addExpense(Expense expense) async {
    await dio.post('http://192.168.1.107:8080/add-expense', data: expense.toJson());
  }

  Future<List<Expense>?>? deleteExpense(int id) async {
    await dio.delete('http://192.168.1.107:8080/delete-expense/$id');
  }

  Future<List<Expense>?>? updateExpense(Expense expense) async {
    await dio.put('http://192.168.1.107:8080/update-expense', data: expense.toJson());
  }
}