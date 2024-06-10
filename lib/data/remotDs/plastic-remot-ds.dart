import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firstly/data/models/product.dart';

abstract class PlasticRemoteDs {
  Future<void> addPlastic(Product product);
  Future<List<Product>> getPlastic();
  Future<void> addToCart(Product product);
  Future<List<Product>> getCartProduct();
  Future<void> removePlastic(String id);
  Future<void> removeProductFromCart(String id);
  Future<void> updatePlastic(Product product);
  Future<void> updateCartProduct(Product product);
  Future<void> addToFavorites(
      Product product); // Add method for adding to favorites
  Future<List<Product>> getFavoriteProducts();
  Future<void> removeFromFavorites(
      String id); 
}

class PlasticRemoteDsImp extends PlasticRemoteDs {
  @override
  Future<void> addPlastic(Product product) async {
    await FirebaseFirestore.instance.collection("Plastic").add(product.toMap());
  }

  @override
  Future<List<Product>> getPlastic() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection("Plastic").get();
      return snapshot.docs.map((d) => Product.fromDoc(d)).toList();
    } catch (e) {
      print("Error getting products: $e");
      return [];
    }
  }

  @override
  Future<void> removePlastic(String id) async {
    try {
      await FirebaseFirestore.instance.collection("Plastic").doc(id).delete();
    } catch (e) {
      print("Error removing product: $e");
    }
  }

  @override
  Future<void> updatePlastic(Product product) async {
    try {
      await FirebaseFirestore.instance
          .collection("Plastic")
          .doc(product.id)
          .update(product.toMap());
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
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      var currentUser = firebaseAuth.currentUser;

      if (currentUser != null) {
        await FirebaseFirestore.instance
            .collection("users-cart-items")
            .doc(currentUser.email)
            .collection("items")
            .doc(id)
            .delete();
        print("Product removed from cart");
      } else {
        print("User not signed in.");
      }
    } catch (e) {
      print("Error removing from cart: $e");
    }
  }
   @override
  Future<void> updateCartProduct(Product product) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      var currentUser = firebaseAuth.currentUser;

      if (currentUser != null) {
        await FirebaseFirestore.instance
            .collection("users-cart-items")
            .doc(currentUser.email)
            .collection("items")
            .doc(product.id)
            .update(product.toMap());
        print("Product quantity updated in cart");
      } else {
        print("User not signed in.");
      }
    } catch (e) {
      print("Error updating product quantity in cart: $e");
    }
  }

  @override
  Future<void> addToFavorites(Product product) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      var currentUser = firebaseAuth.currentUser;

      if (currentUser != null) {
        await FirebaseFirestore.instance
            .collection("users-favorite-items")
            .doc(currentUser.email)
            .collection("items")
            .doc(product.id)
            .set(product.toMap());
        print("Added to favorites");
      } else {
        print("User not signed in.");
      }
    } catch (e) {
      print("Error adding to favorites: $e");
    }
  }

  @override
  Future<List<Product>> getFavoriteProducts() async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      var currentUser = firebaseAuth.currentUser;

      if (currentUser != null) {
        final snapshot = await FirebaseFirestore.instance
            .collection("users-favorite-items")
            .doc(currentUser.email)
            .collection("items")
            .get();

        final List<Product> favoriteProducts = [];

        snapshot.docs.forEach((doc) {
          favoriteProducts.add(Product.fromDoc(doc));
        });

        return favoriteProducts;
      } else {
        print("User not signed in.");
        return [];
      }
    } catch (e) {
      print("Error getting favorite products: $e");
      return [];
    }
  }

  @override
  Future<void> removeFromFavorites(String id) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      var currentUser = firebaseAuth.currentUser;

      if (currentUser != null) {
        await FirebaseFirestore.instance
            .collection("users-favorite-items")
            .doc(currentUser.email)
            .collection("items")
            .doc(id)
            .delete();
        print("Removed from favorites");
      } else {
        print("User not signed in.");
      }
    } catch (e) {
      print("Error removing from favorites: $e");
    }
  }
}
