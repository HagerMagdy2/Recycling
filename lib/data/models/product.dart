import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String image, name, id, userId; // Add userId field
  num quantity, price, availableQuantity;

  Product({
    required this.image,
    required this.name,
    required this.id,
    required this.userId, // Initialize userId
    required this.price,
    required this.quantity,
    required this.availableQuantity,
  });

  Map<String, dynamic> toMap() {
    return {
      "image": image,
      "name": name,
      "id": id,
      "userId": userId, // Include userId in the map
      "price": price,
      "quantity": quantity,
      "availableQuantity": availableQuantity,
    };
  }

  factory Product.fromDoc(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return Product(
      image: doc.data()['image'],
      name: doc.data()['name']!,
      id: doc.id,
      userId: doc.data()['userId'], // Initialize userId
      price: doc.data()['price'],
      quantity: doc.data()['quantity'],
      availableQuantity: doc.data()['availableQuantity'],
    );
  }

  Product copyWith({
    String? id,
    String? name,
    String? image,
    String? userId, // Add userId parameter
    double? price,
    num? quantity,
    num? availableQuantity,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      userId: userId ?? this.userId, // Update userId
      price: price ?? this.price,
      quantity: quantity != null ? quantity.toInt() : this.quantity,
      availableQuantity: availableQuantity ?? this.availableQuantity,
    );
  }
}