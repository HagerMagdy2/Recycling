import 'package:firstly/data/models/product.dart';
import 'package:flutter/material.dart';

@immutable
sealed class ProductEvent {}

class GetProduct extends ProductEvent {}

class GetCartProduct extends ProductEvent {}

class AddProduct extends ProductEvent {
  final Product product;

  AddProduct({required this.product});
}

class AddProductToCart extends ProductEvent {
  final Product product;

  AddProductToCart({required this.product});
}

class RemoveProduct extends ProductEvent {
  final String id;

  RemoveProduct({required this.id});
}

class RemoveProductFromCart extends ProductEvent {
  final String id;
  final Product product;

  RemoveProductFromCart({required this.id, required this.product});
}

class UpdateProduct extends ProductEvent {
  final Product product;

  UpdateProduct({required this.product});
}

class UpdateCartProduct extends ProductEvent {
  final Product product;

  UpdateCartProduct({required this.product});
}

class AddProductToFavorites extends ProductEvent {
  final Product product;

  AddProductToFavorites({required this.product});
}

class RemoveProductFromFavorites extends ProductEvent {
  final String id;

  RemoveProductFromFavorites({required this.id});
}

class GetFavoriteProduct extends ProductEvent {}
