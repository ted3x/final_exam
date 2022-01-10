import 'dart:ui';
import 'package:final_exam/data/model/expense.dart';
import 'package:final_exam/extensions/date_ext.dart';
import 'package:final_exam/logic/expenses_helper.dart';
import 'package:final_exam/logic/expenses_provider.dart';
import 'package:final_exam/logic/state.dart';
import 'package:final_exam/main.dart';
import 'package:final_exam/widgets/expense_item_widget.dart';
import 'package:final_exam/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final expensesHelper = ExpensesHelper();

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Image.asset("assets/background.png"),
        Container(
            padding: const EdgeInsets.only(
                left: 32, right: 45, bottom: 41, top: 117),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('Personal Expenses',
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            color: Color(textColor), fontSize: 25))),
                Container(
                  alignment: Alignment.center,
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(darkGreen),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.add, color: Colors.white),
                    onPressed: () {
                      showAddExpenseBottomDialog(context);
                    },
                  ),
                )
              ]),
              const SizedBox(height: 41),
              BlocBuilder<ExpensesCubit, RequestState>(
                bloc: context.read<ExpensesCubit>()..fetchExpenses(),
                builder: (context, state) {
                  if (state is Loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is Success<List<Expense>>) {
                    return Expanded(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Card(
                                  elevation: 6,
                                  shadowColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    side: BorderSide(
                                      color: Colors.black.withOpacity(0.3),
                                      width: 1,
                                    ),
                                  ),
                                  child: SizedBox(
                                      height: 204,
                                      width: 329,
                                      child: Container(
                                          padding: const EdgeInsets.only(
                                              top: 71, left: 22),
                                          child: Text(
                                              '${ExpensesHelper().sumOfExpenses(state.data)} \$',
                                              style: GoogleFonts.poppins(
                                                  textStyle: const TextStyle(
                                                      fontSize: 20,
                                                      color: Color(
                                                          textColor))))))),
                              Expanded(
                                  child: ListView.separated(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      separatorBuilder:
                                          (BuildContext context, int index) =>
                                              const SizedBox(height: 4),
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            // amis feri ver davamtxvie dokumentaciidan, xd-shic sxva feria amitom davtove es
                                            showModalBottomSheet(
                                                backgroundColor:
                                                    const Color(0xff95d3c4),
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return BackdropFilter(
                                                      filter: ImageFilter.blur(
                                                          sigmaX: 1, sigmaY: 1),
                                                      child:
                                                          showExpenseBottomDialog(
                                                              context,
                                                              state.data[
                                                                  index]));
                                                });
                                          },
                                          child: ExpenseItemWidget(
                                              state.data[index].expenseTitle,
                                              state.data[index].amount
                                                      .toString() +
                                                  ' \$',
                                              state.data[index].date),
                                        );
                                      },
                                      itemCount: state.data.length))
                            ]));
                  } else {
                    return Center(
                      child: Text((state as Error).errorMessage),
                    );
                  }
                },
              ),
            ]))
      ]),
    );
  }
}

void showAddExpenseBottomDialog(BuildContext context) {}

Column showExpenseBottomDialog(BuildContext context, Expense expense) {
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
              Icons.edit, Colors.white, () {}),
          RoundButtonWidget(const Color(darkGreen), const Color(darkGreen),
              Icons.delete, Colors.white, () async {
            showRemoveExpenseDialog(context);
          }),
        ],
      )
    ],
  );
}

void showRemoveExpenseDialog(BuildContext context) async {
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
                    Navigator.pop(context, true);
                  },
                  child: const Text('Remove'))
            ],
          ));
  if (result == true) {
    Navigator.pop(context, result);
  }
}
