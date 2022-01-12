import 'dart:ui';
import 'package:final_exam/data/model/expense.dart';
import 'package:final_exam/logic/expenses_helper.dart';
import 'package:final_exam/logic/expenses_provider.dart';
import 'package:final_exam/logic/state.dart';
import 'package:final_exam/main.dart';
import 'package:final_exam/widgets/expense_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dialogs/dashboard_add_expense_dialog.dart';
import 'dialogs/dashboard_show_expense_info_dialog.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  final expensesHelper = ExpensesHelper();
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..forward();
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(0.0, 1.0),
    end: const Offset(0.0, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.bounceIn,
  ));

  @override
  void initState() {
    super.initState();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
                      showBottomDialog(context, getAddExpenseWidget(context));
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
                  } else if (state is Success<List<Expense>> &&
                      state.data != null) {
                    return Flexible(
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
                                          '${ExpensesHelper().sumOfExpenses(state.data!)} \$',
                                          style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                                  fontSize: 20,
                                                  color: Color(textColor))))))),
                          Expanded(
                            child: SlideTransition(
                                position: _offsetAnimation,
                                child: ListView.separated(
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            const SizedBox(height: 4),
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          // amis feri ver davamtxvie dokumentaciidan, xd-shic sxva feria amitom davtove es
                                          showBottomDialog(
                                              context,
                                              getExpenseWidget(
                                                  context, state.data![index]));
                                        },
                                        child: ExpenseItemWidget(
                                            state.data![index].expenseTitle,
                                            state.data![index].amount
                                                    .toString() +
                                                ' \$',
                                            state.data![index].date),
                                      );
                                    },
                                    itemCount: state.data!.length)),
                          )
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

void showBottomDialog(BuildContext context, Widget widget) {
  showModalBottomSheet(
      backgroundColor: const Color(0xff95d3c4),
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1), child: widget);
      });
}
