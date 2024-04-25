import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String image, name, id;
  num quantity, price;

  Product({
    required this.image,
    required this.name,
    required this.id,
    required this.price,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      "image": image,
      "name": name,
      "id": id,
      "price": price,
      "quantity": quantity
    };
  }

  factory Product.fromDoc(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return Product(
        image: doc.data()['image'],
        name: doc.data()['name']!,
        id: doc.id,
        price: doc.data()['price'],
        quantity: doc.data()['quantity']);
  }
  Product copyWith({
    String? id,
    String? name,
    String? image,
    double? price,
    num? quantity,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      price: price ?? this.price,
      quantity: quantity != null ? quantity.toInt() : this.quantity,
    );
  }
}
