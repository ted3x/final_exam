import 'package:final_exam/data/model/expense.dart';
import 'package:final_exam/data/repository/expenses_repository.dart';
import 'package:final_exam/logic/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpensesCubit extends Cubit<RequestState> {
  ExpensesCubit() : super(Loading());

  final expensesRepository = ExpensesRepository();

  Future<void> fetchExpenses() async {
    emit(Loading());
    try {
      var expenses = await expensesRepository.fetchExpenses();
      emit(Success(expenses!));
    } catch (e) {
      emit(
        Error(e.toString()),
      );
    }
  }

  Future<void> addExpense(Expense expense) async {
    emit(Loading());
    try {
      await expensesRepository.addExpense(expense);
      fetchExpenses();
    } catch (e) {
      emit(
        Error(e.toString()),
      );
    }
  }

  Future<void> deleteExpense(Expense expense) async {
    emit(Loading());
    try {
      await expensesRepository.deleteExpense(expense.id);
      fetchExpenses();
    } catch (e) {
      emit(
        Error(e.toString()),
      );
    }
  }

  Future<void> updateExpense(Expense expense) async {
    emit(Loading());
    try {
      await expensesRepository.updateExpense(expense);
      fetchExpenses();
    } catch (e) {
      emit(
        Error(e.toString()),
      );
    }
  }
}
