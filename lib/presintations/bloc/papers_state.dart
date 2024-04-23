import 'package:firstly/data/models/product.dart';
import 'package:flutter/material.dart';

@immutable
sealed class PapersState {}

final class PapersInitial extends PapersState {}

final class PapersLoadingState extends PapersState {}

final class PapersLoaded extends PapersState {
  final List<Product> products;

  PapersLoaded({required this.products});
}

final class PapersErrorState extends PapersState {
  final String errorMessage;

  PapersErrorState({required this.errorMessage});
}
