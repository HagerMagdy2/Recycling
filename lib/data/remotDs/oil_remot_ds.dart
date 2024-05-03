import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firstly/data/models/product.dart';

abstract class OilRemoteDs {
  Future<void> addOil(Product product);
  Future<List<Product>> getOil();
  Future<void> addToCart(Product product);
  Future<List<Product>> getCartProduct();
  Future<void> removeOil(String id);
  Future<void> removeProductFromCart(String id);
  Future<void> updateOil(Product product);
}

class OilRemoteDsImp extends OilRemoteDs {
  @override
  Future<void> addOil(Product product) async {
    await FirebaseFirestore.instance.collection("Oil").add(product.toMap());
  }

  @override
  Future<List<Product>> getOil() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection("Oil").get();
      return snapshot.docs.map((d) => Product.fromDoc(d)).toList();
    } catch (e) {
      print("Error getting oil products: $e");
      return [];
    }
  }

  @override
  Future<void> removeOil(String id) async {
    try {
      await FirebaseFirestore.instance.collection("Oil").doc(id).delete();
    } catch (e) {
      print("Error removing oil product: $e");
    }
  }

  @override
  Future<void> updateOil(Product product) async {
    try {
      await FirebaseFirestore.instance
          .collection("Oil")
          .doc(product.id)
          .update(product.toMap());
    } catch (e) {
      print("Error updating oil product: $e");
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
      print("Error adding oil product to cart: $e");
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
      print("Error getting oil cart products: $e");
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
        print("Oil product removed from cart");
      } else {
        print("User not signed in.");
      }
    } catch (e) {
      print("Error removing oil product from cart: $e");
    }
  }
}
