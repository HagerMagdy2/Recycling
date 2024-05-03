import 'package:firstly/data/models/product.dart';
import 'package:flutter/material.dart';

@immutable
sealed class OilsState {}

final class OilsInitial extends OilsState {}

final class OilsLoadingState extends OilsState {}

final class OilsLoaded extends OilsState {
  final List<Product> products;

  OilsLoaded({required this.products});
}

final class OilsErrorState extends OilsState {
  final String errorMessage;

  OilsErrorState({required this.errorMessage});
}
