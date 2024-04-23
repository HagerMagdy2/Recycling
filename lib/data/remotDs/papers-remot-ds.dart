import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstly/data/models/product.dart';

abstract class PapersRemoteDs {
  Future<void> addPapers(Product product);
  Future<List<Product>> getPapers();
  Future<void> addToCart(Product product);
  Future<List<Product>> getCartProduct();
  Future<void> removePapers(String id);
  Future<void> removeProductFromCart(String id);
  Future<void> updatePapers(Product product);
}

class PapersRemoteDsImp extends PapersRemoteDs {
  @override
  Future<void> addPapers(Product product) async {
    await FirebaseFirestore.instance.collection("Papers").add(product.toMap());
  }

  @override
  Future<List<Product>> getPapers() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection("Papers").get();
      return snapshot.docs.map((d) => Product.fromDoc(d)).toList();
    } catch (e) {
      print("Error getting papers products: $e");
      return [];
    }
  }

  @override
  Future<void> removePapers(String id) async {
    try {
      await FirebaseFirestore.instance.collection("Papers").doc(id).delete();
    } catch (e) {
      print("Error removing papers product: $e");
    }
  }

  @override
  Future<void> updatePapers(Product product) async {
    try {
      await FirebaseFirestore.instance
          .collection("Papers")
          .doc(product.id)
          .update(product.toMap());
    } catch (e) {
      print("Error updating papers product: $e");
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
      print("Error adding papers product to cart: $e");
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
      print("Error getting papers cart products: $e");
      return [];
    }
  }

  @override
  Future<void> removeProductFromCart(String id) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      var currentUser = firebaseAuth.currentUser;

      if (currentUser != null) {
        await FirebaseFirestore.instance
            .collection("users-cart-items")
            .doc(currentUser.email)
            .collection("items")
            .doc(id)
            .delete();
        print("Papers product removed from cart");
      } else {
        print("User not signed in.");
      }
    } catch (e) {
      print("Error removing papers product from cart: $e");
    }
  }
}
