import 'package:firstly/data/models/product.dart';

sealed class PlasticEvent {}

class GetPlastic extends PlasticEvent {}

class GetCartProduct extends PlasticEvent {}

class AddPlastic extends PlasticEvent {
  final Product product;

  AddPlastic({required this.product});
}

class AddProductToCart extends PlasticEvent {
  final Product product;

  AddProductToCart({required this.product});
}

class RemovePlastic extends PlasticEvent {
  final String id;

  RemovePlastic({required this.id});
}

class RemoveProductFromCart extends PlasticEvent {
  final String id;

  RemoveProductFromCart({required this.id});
}

class UpdatePlastic extends PlasticEvent {
  final Product product;

  UpdatePlastic({required this.product});
}
