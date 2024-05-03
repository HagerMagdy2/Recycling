import 'package:firstly/data/models/product.dart';
import 'package:flutter/material.dart';

@immutable
sealed class CompostState {}

final class CompostInitial extends CompostState {}

final class CompostLoadingState extends CompostState {}

final class CompostLoaded extends CompostState {
  final List<Product> products;

  CompostLoaded({required this.products});
}

final class CompostErrorState extends CompostState {
  final String errorMessage;

  CompostErrorState({required this.errorMessage});
}
