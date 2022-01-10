import 'package:final_exam/data/model/expense.dart';
import 'package:final_exam/logic/expenses_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

void showRemoveExpenseDialog(BuildContext context, Expense expense) async {
  var result = await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Removing Expense"),
        content: const Text("Do you really want to remove this expense?"),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Cancel')),
          TextButton(
              onPressed: () {
                context.read<ExpensesCubit>().deleteExpense(expense);
              },
              child: const Text('Remove'))
        ],
      ));
  if (result == true) {
    Navigator.pop(context, result);
  }
}
