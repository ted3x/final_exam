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

Future<DateTime?> selectDate(BuildContext context, DateTime? selectedDate) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: selectedDate ?? DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime.now(),
    locale: const Locale('en', 'GB'),
  );
  if (picked != null) {
    context.read<ExpensesDateCubit>().setDateTime(picked);
  }
}