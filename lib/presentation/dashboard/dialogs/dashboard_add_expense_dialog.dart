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

Form getAddExpenseWidget(BuildContext context) {
  context.read<ExpensesDateCubit>().setDateTime(null);
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _amountController = TextEditingController();
  final _titleController = TextEditingController();
  var _selectedDate;
  return Form(
      key: _formKey,
      child: Container(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 50),
          child: Column(children: [
            EditTextWidget('Please enter expense ID', _idController,
                'Please enter ID', TextAlign.center, Colors.black),
            const SizedBox(height: 10),
            EditTextWidget('Please enter expense amount', _amountController,
                'Please enter amount', TextAlign.center, Colors.black),
            const SizedBox(height: 10),
            EditTextWidget('Please enter expense title', _titleController,
                'Please enter title', TextAlign.center, Colors.black),
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
                RoundedRectangleButtonWidget(
                    darkGreen,
                    Text(
                      'Pick Date',
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              color: Colors.white, fontSize: 20)),
                    ), () {
                  selectDate(context, _selectedDate);
                }),
              ],
            ),
            Container(
                margin: const EdgeInsets.only(top: 41),
                alignment: Alignment.bottomRight,
                child: RoundedRectangleButtonWidget(
                    darkGreen,
                    Text('ADD',
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontSize: 18)), () {
                  if (_formKey.currentState!.validate()) {
                    var expense = Expense(
                        id: int.parse(_idController.text),
                        amount: int.parse(_amountController.text),
                        expenseTitle: _titleController.text,
                        date: context.read<ExpensesDateCubit>().state!);
                    context.read<ExpensesCubit>().addExpense(expense);
                    Navigator.pop(context);
                  }
                }))
          ])));
}
