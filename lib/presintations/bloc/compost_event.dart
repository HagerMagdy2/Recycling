import 'package:firstly/data/models/product.dart';

sealed class CompostEvent {}

class GetCompost extends CompostEvent {}

class GetCartProduct extends CompostEvent {}

class AddCompost extends CompostEvent {
  final Product product;

  AddCompost({required this.product});
}

class AddProductToCart extends CompostEvent {
  final Product product;

  AddProductToCart({required this.product});
}

class RemoveCompost extends CompostEvent {
  final String id;

  RemoveCompost({required this.id});
}

class RemoveProductFromCart extends CompostEvent {
  final String id;

  RemoveProductFromCart({required this.id});
}

class UpdateCompost extends CompostEvent {
  final Product product;

  UpdateCompost({required this.product});
}
