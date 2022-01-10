import 'package:final_exam/logic/expenses_date_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/src/provider.dart';

extension DateFormatting on DateTime {
  String format() {
    return DateFormat('dd/MM/yyyy').format(this);
  }
// ···
}

Future<DateTime?> selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime.now(),
    locale: const Locale('en', 'GB'),
  );
  context.read<ExpensesDateCubit>().setDateTime(picked);
}