part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class GetCartProduct extends CartEvent {}

class AddProductToCart extends CartEvent {
  final Product cartProduct;

  AddProductToCart({required this.cartProduct});
}

class RemoveProductFromCart extends CartEvent {
  final String id;
  final Product cartProduct;

  RemoveProductFromCart({required this.id, required this.cartProduct});
}

class UpdateCartProduct extends CartEvent {
  final Product cartProducts;

  UpdateCartProduct({required this.cartProducts});
}
