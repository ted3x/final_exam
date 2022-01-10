import 'package:final_exam/logic/expenses_date_provider.dart';
import 'package:final_exam/logic/expenses_provider.dart';
import 'package:final_exam/presentation/dashboard/dashboard_screen.dart';
import 'package:final_exam/presentation/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ExpensesCubit()),
          BlocProvider(create: (context) => ExpensesDateCubit())
        ],
        child: MaterialApp(
          title: 'Personal Expenses',
          routes: {
            '/login': (context) => const LoginScreen(),
            '/dashboard': (context) => const DashboardScreen()
          },
          initialRoute: '/login',
        ));
  }
}

const int lightGreen = 0xff95d3c4;
const int darkGreen = 0xff267b7b;
const int textColor = 0xff707070;
