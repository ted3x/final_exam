import 'package:final_exam/data/model/expense.dart';
import 'package:final_exam/logic/expenses_provider.dart';
import 'package:final_exam/logic/state.dart';
import 'package:final_exam/widgets/expense_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Star Wars'),
      ),
      body: BlocBuilder<ExpensesCubit, RequestState>(
        bloc: context.read<ExpensesCubit>()..fetchExpenses(),
        builder: (context, state) {
          if (state is Loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is Success<List<Expense>>) {
            return Container(
                margin: EdgeInsets.only(left: 30, right: 30),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ExpenseItemWidget('title', 'amount', DateTime.now()),
                      Expanded(
                          child: ListView.separated(
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const SizedBox(height: 4),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    // Navigator.pushNamed(context, "/planet",
                                    //     arguments: state.data[index].homeworldUrl);
                                  },
                                  child: ExpenseItemWidget(
                                      state.data[index].expenseTitle,
                                      state.data[index].amount.toString() +
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
    );
  }
}
