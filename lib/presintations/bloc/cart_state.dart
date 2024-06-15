part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLoadingState extends CartState {}

final class CartLoaded extends CartState {
  final List<Product> cartProducts;

  CartLoaded({required this.cartProducts, });
}

final class CartErrorState extends CartState {
  final String errorMessage;

  CartErrorState({required this.errorMessage});
}
