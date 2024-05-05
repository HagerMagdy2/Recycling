import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String image,
      name,
      id,
      userId,
      userName,
      userEmail,
      userPhone; // Add new fields
  num quantity, price, availableQuantity;

  Product({
    required this.image,
    required this.name,
    required this.id,
    required this.userId,
    required this.userName, // Initialize userName
    required this.userEmail, // Initialize userEmail
    required this.userPhone, // Initialize userPhone
    required this.price,
    required this.quantity,
    required this.availableQuantity,
  });

  Map<String, dynamic> toMap() {
    return {
      "image": image,
      "name": name,
      "id": id,
      "userId": userId,
      "userName": userName, // Include userName in the map
      "userEmail": userEmail, // Include userEmail in the map
      "userPhone": userPhone, // Include userPhone in the map
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
      userId: doc.data()['userId'],
      userName: doc.data()['userName'], // Initialize userName
      userEmail: doc.data()['userEmail'], // Initialize userEmail
      userPhone: doc.data()['userPhone'], // Initialize userPhone
      price: doc.data()['price'],
      quantity: doc.data()['quantity'],
      availableQuantity: doc.data()['availableQuantity'],
    );
  }

  Product copyWith({
    String? id,
    String? name,
    String? image,
    String? userId,
    String? userName, // Add userName parameter
    String? userEmail, // Add userEmail parameter
    String? userPhone, // Add userPhone parameter
    double? price,
    num? quantity,
    num? availableQuantity,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName, // Update userName
      userEmail: userEmail ?? this.userEmail, // Update userEmail
      userPhone: userPhone ?? this.userPhone, // Update userPhone
      price: price ?? this.price,
      quantity: quantity != null ? quantity.toInt() : this.quantity,
      availableQuantity: availableQuantity ?? this.availableQuantity,
    );
  }
}