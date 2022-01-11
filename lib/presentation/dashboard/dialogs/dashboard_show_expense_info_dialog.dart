import 'package:final_exam/data/model/expense.dart';
import 'package:final_exam/extensions/date_ext.dart';
import 'package:final_exam/presentation/dashboard/dialogs/dashboard_edit_expense_dialog.dart';
import 'package:final_exam/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../main.dart';
import '../dashboard_screen.dart';
import 'dashboard_remove_expense_dialog.dart';

Column getExpenseWidget(BuildContext context, Expense expense) {
  return Column(
    children: [
      const SizedBox(height: 30),
      Text(expense.expenseTitle,
          style: GoogleFonts.poppins(
              textStyle:
              const TextStyle(fontSize: 27, color: Color(textColor)))),
      const SizedBox(height: 39),
      Container(
          padding: const EdgeInsets.only(left: 32, right: 19),
          child:
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              'Expense Amount',
              style: GoogleFonts.poppins(
                  textStyle:
                  const TextStyle(color: Color(textColor), fontSize: 18)),
            ),
            Text(expense.amount.toString() + ' \$',
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        color: Color(textColor), fontSize: 18))),
          ])),
      Container(
          padding: const EdgeInsets.only(left: 32, right: 19, top: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Date',
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          color: Color(textColor), fontSize: 18))),
              Text(
                expense.date.format(),
                style: GoogleFonts.poppins(
                    textStyle:
                    const TextStyle(color: Color(textColor), fontSize: 18)),
              )
            ],
          )),
      const SizedBox(height: 102),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RoundButtonWidget(const Color(darkGreen), const Color(darkGreen),
              Icons.edit, Colors.white, () {
                showBottomDialog(
                    context, getEditExpenseWidget(context, expense));
              }),
          RoundButtonWidget(const Color(darkGreen), const Color(darkGreen),
              Icons.delete, Colors.white, () async {
                showRemoveExpenseDialog(context, expense);
              }),
        ],
      )
    ],
  );
}
