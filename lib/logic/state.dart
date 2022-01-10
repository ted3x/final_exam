import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class RequestState extends Equatable {}

class Loading<T> extends RequestState {
  @override
  List<Object?> get props => [];
}

class Success<T> extends RequestState {
  final T? data;

  Success(this.data);

  @override
  List<Object?> get props => [data];
}

class Error<T> extends RequestState {
  final String errorMessage;

  Error(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}