import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firstly/data/models/product.dart';

abstract class ProductRemoteDs {
  Future<void> addProduct(Product product);
  Future<List<Product>> getProduct();
  Future<void> addToCart(Product product);
  Future<List<Product>> getCartProduct();
  Future<void> removeProduct(String id);
  Future<void> removeProductFromCart(String id);
  Future<void> updateProduct(Product product);
}

class ProductRemoteDsImp extends ProductRemoteDs {
  @override
  Future<void> addProduct(Product product) async {
    await FirebaseFirestore.instance
        .collection("products")
        .add(product.toMap());
  }

  @override
  Future<List<Product>> getProduct() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection("products").get();
      return snapshot.docs.map((d) => Product.fromDoc(d)).toList();
    } catch (e) {
      print("Error getting products: $e");
      return [];
    }
  }

  @override
  Future<void> removeProduct(String id) async {
    try {
      await FirebaseFirestore.instance.collection("products").doc(id).delete();
    } catch (e) {
      print("Error removing product: $e");
    }
  }

  @override
  Future<void> updateProduct(Product product) async {
    try {
      final String productId = product.id; // Assuming 'id' is the document ID
      if (productId.isNotEmpty) {
        await FirebaseFirestore.instance
            .collection("products")
            .doc(productId) // Ensure productId is not empty
            .update(product.toMap()); // Update the document with product data
        print("Product updated successfully");
      } else {
        print("Error: Product ID is empty");
      }
    } catch (e) {
      print("Error updating product: $e");
    }
  }

  @override
  Future<void> addToCart(Product product) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      var currentUser = firebaseAuth.currentUser;

      if (currentUser != null) {
        await FirebaseFirestore.instance
            .collection("users-cart-items")
            .doc(currentUser.email)
            .collection("items")
            .add(product.toMap());
        print("Added to cart");
      } else {
        print("User not signed in.");
      }
    } catch (e) {
      print("Error adding to cart: $e");
    }
  }

  Future<bool> isInCart(String productId, User currentUser) async {
    try {
      // Query the 'users-cart-items' collection to check if the product exists in the user's cart
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("users-cart-items")
          .doc(currentUser.email)
          .collection("items")
          .where('productId', isEqualTo: productId)
          .get();

      // If the query snapshot has any documents, it means the product is in the cart
      return querySnapshot.docs.isNotEmpty;
    } catch (error) {
      // Handle error
      print('Error checking if product is in cart: $error');
      return false;
    }
  }

  @override
  Future<List<Product>> getCartProduct() async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      var currentUser = firebaseAuth.currentUser;

      if (currentUser != null) {
        final snapshot = await FirebaseFirestore.instance
            .collection("users-cart-items")
            .doc(currentUser.email)
            .collection("items")
            .get();

        final Set<String> productIds = Set<String>();
        final List<Product> cartProducts = [];

        snapshot.docs.forEach((doc) {
          final product = Product.fromDoc(doc);
          if (!productIds.contains(product.id)) {
            productIds.add(product.id);
            cartProducts.add(product);
          }
        });

        return cartProducts;
      } else {
        print("User not signed in.");
        return [];
      }
    } catch (e) {
      print("Error getting cart products: $e");
      return [];
    }
  }

  @override
  Future<void> removeProductFromCart(String id) async {
    try {
      if (id.isNotEmpty) {
        final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
        var currentUser = firebaseAuth.currentUser;

        if (currentUser != null) {
          await FirebaseFirestore.instance
              .collection("users-cart-items")
              .doc(currentUser.email)
              .collection("items")
              .doc(id) // Ensure 'id' is not empty
              .delete(); // Delete the document
          print("Product removed from cart successfully");
        } else {
          print("User not signed in.");
        }
      } else {
        print("Error: Document ID is empty");
      }
    } catch (e) {
      print("Error removing from cart: $e");
    }
  }
}
