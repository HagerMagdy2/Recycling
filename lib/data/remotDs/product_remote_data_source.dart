import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstly/data/models/product.dart';

abstract class ProductRemoteDs {
  Future<void> addProduct(Product product);
  Future<List<Product>> getProduct();
  Future<void> addToCart(Product product);
  Future<List<Product>> getCartProduct();
  Future<void> removeProduct(String id);
  Future<void> removeProductFromCart(String id);
  Future<void> updateProduct(Product product);
  Future<void> updateCartProduct(Product product);
  Future<void> addToFavorites(
      Product product); // Add method for adding to favorites
  Future<List<Product>> getFavoriteProducts();
  Future<void> removeFromFavorites(String id);
  Future<bool> isInCart(
      String productId); // Add method for getting favorite products
}

class ProductRemoteDsImp extends ProductRemoteDs {
  @override
  Future<void> addProduct(Product product) async {
    await FirebaseFirestore.instance.collection("Products").add(
          product.toMap(),
        );
    print("added product");
  }

  @override
  Future<List<Product>> getProduct() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection("Products").get();
      return snapshot.docs.map((d) => Product.fromDoc(d)).toList();
    } catch (e) {
      print("Error getting products: $e");
      return [];
    }
  }

  @override
  Future<void> removeProduct(String id) async {
    try {
      await FirebaseFirestore.instance.collection("Products").doc(id).delete();
    } catch (e) {
      print("Error removing product: $e");
    }
  }

  @override
  Future<void> updateProduct(Product product) async {
    try {
      await FirebaseFirestore.instance
          .collection("Products")
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

  // Future<bool> isInCart(String productId, User currentUser) async {
  //   try {
  //     // Query the 'users-cart-items' collection to check if the product exists in the user's cart
  //     QuerySnapshot querySnapshot = await FirebaseFirestore.instance
  //         .collection("users-cart-items")
  //         .doc(currentUser.email)
  //         .collection("items")
  //         .where('productId', isEqualTo: productId)
  //         .get();

  //     // If the query snapshot has any documents, it means the product is in the cart
  //     return querySnapshot.docs.isNotEmpty;
  //   } catch (error) {
  //     // Handle error
  //     print('Error checking if product is in cart: $error');
  //     return false;
  //   }
  // }

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
        print("User is signed in. Attempting to remove product from cart.");
        print("Document ID: $id");

        final documentReference = FirebaseFirestore.instance
            .collection("users-cart-items")
            .doc(currentUser.email)
            .collection("items")
            .doc(id);

        final documentSnapshot = await documentReference.get();

        if (documentSnapshot.exists) {
          // Document exists, proceed with deletion
          await documentReference.delete();
          print("Product removed from cart successfully.");
        } else {
          // Document does not exist
          print("Error: Document not found in cart items collection.");
        }
      } else {
        // User is not signed in
        print("Error: User not signed in.");
      }
    } catch (e, stackTrace) {
      print("Error removing from cart: $e");
      print(stackTrace); // Print stack trace for more details
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
@override
  // New method to check if a product is in the cart
  Future<bool> isInCart(String productId) async {
    List<Product> cartProducts = await getCartProduct();
           // print(isInCart);

    return cartProducts.any((product) => product.id == productId);

  }
    Future<bool> isFavorite(String productId) async {
    List<Product> favoriteProducts = await getFavoriteProducts();
    return favoriteProducts.any((product) => product.id == productId);
  }
}
