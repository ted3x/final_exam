import 'package:final_exam/data/model/expense.dart';
import 'package:final_exam/extensions/date_ext.dart';
import 'package:final_exam/logic/expenses_date_provider.dart';
import 'package:final_exam/logic/expenses_provider.dart';
import 'package:final_exam/widgets/edit_text_widget.dart';
import 'package:final_exam/widgets/rounded_rectangle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/src/provider.dart';

import '../../../main.dart';

Form getEditExpenseWidget(BuildContext context, Expense expense) {
  context.read<ExpensesDateCubit>().setDateTime(expense.date);
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController(text: expense.id.toString());
  final _amountController =
      TextEditingController(text: expense.amount.toString());
  final _titleController = TextEditingController(text: expense.expenseTitle);
  var _selectedDate;
  return Form(
      key: _formKey,
      child: Container(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
          child: Column(children: [
            EditTextWidget(
                'Please enter expense ID', _idController, 'Please enter ID', TextAlign.start, Colors.white),
            EditTextWidget('Please enter expense amount', _amountController,
                'Please enter amount',TextAlign.start, Colors.white),
            EditTextWidget('Please enter expense title', _titleController,
                'Please enter title',TextAlign.start,  Colors.white),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocBuilder<ExpensesDateCubit, DateTime?>(
                  builder: (context, dateTime) {
                    if (dateTime != null) {
                      _selectedDate = dateTime;
                      return Text(dateTime.format(),
                          style: GoogleFonts.poppins(
                              color: const Color(textColor), fontSize: 18));
                    } else {
                      return Text('Pick Date',
                          style: GoogleFonts.poppins(
                              color: const Color(textColor), fontSize: 18));
                    }
                  },
                ),
                RoundedRectangleButtonWidget(darkGreen,  Text('Pick Date',style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        color: Colors.white, fontSize: 20))),
                    () {
                    selectDate(context, _selectedDate);
                  }
                ),
              ],
            ),
            const SizedBox(height: 41),
            RoundedRectangleButtonWidget(
                darkGreen,
                Text('EDIT',
                    style: GoogleFonts.poppins(
                        color: Colors.white, fontSize: 18)), () {
              if (_formKey.currentState!.validate() && _selectedDate != null) {
                var expense = Expense(
                    id: int.parse(_idController.text),
                    amount: int.parse(_amountController.text),
                    expenseTitle: _titleController.text,
                    date: _selectedDate!);
                context.read<ExpensesCubit>().updateExpense(expense);
                Navigator.popUntil(context,ModalRoute.withName('/dashboard'));
              }
            })
          ])));
}
