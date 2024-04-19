import 'package:firstly/data/models/product.dart';

sealed class PapersEvent {}

class GetPapers extends PapersEvent {}

class GetCartProduct extends PapersEvent {}

class AddPapers extends PapersEvent {
  final Product product;

  AddPapers({required this.product});
}

class AddProductToCart extends PapersEvent {
  final Product product;

  AddProductToCart({required this.product});
}

class RemovePapers extends PapersEvent {
  final String id;

  RemovePapers({required this.id});
}

class RemoveProductFromCart extends PapersEvent {
  final String id;

  RemoveProductFromCart({required this.id});
}

class UpdatePapers extends PapersEvent {
  final Product product;

  UpdatePapers({required this.product});
}
