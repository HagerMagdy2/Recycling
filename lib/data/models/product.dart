import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String image,
      name,
      id,
      userId,
      userName,
      userEmail,
      userPhone,
      category; // Add category field
  num quantity, price, availableQuantity;
  bool isFav;
  bool isInCart;

  Product({
    required this.image,
    required this.name,
    required this.id,
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.userPhone,
    required this.price,
    required this.quantity,
    required this.availableQuantity,
    required this.category, // Initialize category in constructor
    this.isFav = false,
    this.isInCart = false,
  });

  Map<String, dynamic> toMap() {
    return {
      "image": image,
      "name": name,
      "id": id,
      "userId": userId,
      "userName": userName,
      "userEmail": userEmail,
      "userPhone": userPhone,
      "price": price,
      "quantity": quantity,
      "availableQuantity": availableQuantity,
      "category": category, // Include category in the map
      "isFav": isFav,
      "isInCart": isInCart,
    };
  }

  factory Product.fromDoc(QueryDocumentSnapshot<Object?> doc) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

    if (data == null) {
      throw Exception("Document data was null.");
    }

    return Product(
      image: data['image'] as String,
      name: data['name'] as String,
      id: doc.id,
      userId: data['userId'] as String,
      userName: data['userName'] as String,
      userEmail: data['userEmail'] as String,
      userPhone: data['userPhone'] as String,
      price: data['price'] as num,
      quantity: (data['quantity'] as num).toInt(),
      availableQuantity: data['availableQuantity'] as num,
      category: data['category'] as String, // Retrieve category from document
      isFav: data['isFav'] as bool? ?? false,
      isInCart: data['isInCart'] as bool? ?? false,
    );
  }

  Product copyWith({
    String? id,
    String? name,
    String? image,
    String? userId,
    String? userName,
    String? userEmail,
    String? userPhone,
    double? price,
    num? quantity,
    num? availableQuantity,
    String? category, // Add category parameter
    bool? isFav,
    bool? isInCart,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userEmail: userEmail ?? this.userEmail,
      userPhone: userPhone ?? this.userPhone,
      price: price ?? this.price,
      quantity: quantity != null ? quantity.toInt() : this.quantity,
      availableQuantity: availableQuantity ?? this.availableQuantity,
      category: category ?? this.category, // Update category
      isFav: isFav ?? this.isFav,
      isInCart: isInCart ?? this.isInCart,
    );
  }
}