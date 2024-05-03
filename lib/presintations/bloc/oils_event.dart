import 'package:firstly/data/models/product.dart';

sealed class OilsEvent {}

class GetOils extends OilsEvent {}

class GetCartProduct extends OilsEvent {}

class AddOils extends OilsEvent {
  final Product product;

  AddOils({required this.product});
}

class AddProductToCart extends OilsEvent {
  final Product product;

  AddProductToCart({required this.product});
}

class RemoveOils extends OilsEvent {
  final String id;

  RemoveOils({required this.id});
}

class RemoveProductFromCart extends OilsEvent {
  final String id;

  RemoveProductFromCart({required this.id});
}

class UpdateOils extends OilsEvent {
  final Product product;

  UpdateOils({required this.product});
}
