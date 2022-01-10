import 'package:flutter_bloc/flutter_bloc.dart';


class ExpensesDateCubit extends Cubit<DateTime?> {
  ExpensesDateCubit() : super(null);

  void setDateTime(DateTime? dateTime) => emit(dateTime);
}