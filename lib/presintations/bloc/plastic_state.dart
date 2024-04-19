import 'package:firstly/data/models/product.dart';
import 'package:flutter/material.dart';

@immutable
sealed class PlasticState {}

final class PlasticInitial extends PlasticState {}

final class PlasticLoadingState extends PlasticState {}

final class PlasticLoaded extends PlasticState {
  final List<Product> products;

  PlasticLoaded({required this.products});
}

final class PlasticErrorState extends PlasticState {
  final String errorMessage;

  PlasticErrorState({required this.errorMessage});
}
