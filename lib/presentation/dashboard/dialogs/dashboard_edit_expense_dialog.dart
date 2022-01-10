import 'package:final_exam/data/model/expense.dart';
import 'package:final_exam/extensions/date_ext.dart';
import 'package:final_exam/logic/expenses_provider.dart';
import 'package:final_exam/widgets/edit_text_widget.dart';
import 'package:final_exam/widgets/rounded_rectangle_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/src/provider.dart';

import '../../../main.dart';

Form showEditExpenseBottomDialog(BuildContext context, Expense expense) {
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController(text: expense.id.toString());
  final _amountController =
      TextEditingController(text: expense.amount.toString());
  final _titleController = TextEditingController(text: expense.expenseTitle);
  DateTime? _selectedDate;
  return Form(
      key: _formKey,
      child: Container(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Column(children: [
            EditTextWidget(
                'Please enter expense ID', _idController, 'Please enter ID'),
            EditTextWidget('Please enter expense amount', _amountController,
                'Please enter amount'),
            EditTextWidget('Please enter expense title', _titleController,
                'Please enter title'),
            Row(
              children: [
                Text(expense.date.format(),
                    style: GoogleFonts.poppins(
                        color: const Color(textColor), fontSize: 18)),
                RoundedRectangleButtonWidget(darkGreen, const Text('Pick Date'),
                    () async {
                  _selectedDate = await selectDate(context);
                }),
              ],
            ),
            RoundedRectangleButtonWidget(
                darkGreen,
                Text('EDIT',
                    style: GoogleFonts.poppins(
                        color: const Color(textColor), fontSize: 18)), () {
              if (_formKey.currentState!.validate()) {
                var expense = Expense(
                    id: int.parse(_idController.text),
                    amount: int.parse(_amountController.text),
                    expenseTitle: _titleController.text,
                    date: _selectedDate!);
                context.read<ExpensesCubit>().updateExpense(expense);
              }
            })
          ])));
}

Future<DateTime?> selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime.now(),
    locale: const Locale('en', 'GB'),
  );
  return picked;
}
