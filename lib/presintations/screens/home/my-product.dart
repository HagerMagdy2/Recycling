import 'package:firstly/constants.dart';
import 'package:firstly/data/models/product.dart';
import 'package:firstly/presintations/bloc/products_state.dart';
import 'package:firstly/presintations/widgets/show-myProduct.dart';
import 'package:firstly/presintations/bloc/products_bloc.dart'; // Import product bloc
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Import flutter bloc

class MyProduct extends StatefulWidget {
  @override
  _MyProductState createState() => _MyProductState();
}

class _MyProductState extends State<MyProduct> {
  List<Product> userProducts = [];
  bool isLoading = true;
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    retrieveUserProducts();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> retrieveUserProducts() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      try {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('Products')
            .where('userEmail', isEqualTo: currentUser.email)
            .get();

        List<Product> products =
            querySnapshot.docs.map((doc) => Product.fromDoc(doc)).toList();

        setState(() {
          userProducts = products;
          isLoading = false;
        });
      } catch (e) {
        print("Error fetching user products: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              onChanged: (query) {
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: 'Search...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                fillColor: Colors.white,
                filled: true,
                prefixIcon: Icon(Icons.search),
              ),
            ),
            SizedBox(height: 10), // Add some spacing between the search bar and the product list
            Expanded(
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoadingState) {
                    return Center(
                      child: Lottie.asset(
                        'assets/images/Animation loading1.json',
                        height: 200,
                        width: 200,
                        repeat: true,
                      ),
                    );
                  } else if (state is ProductLoaded) {
                    User? currentUser = FirebaseAuth.instance.currentUser;

                    // Filter products based on the current user's email and search query
                    List<Product> filteredProducts = state.products
                        .where((product) =>
                            product.userEmail == currentUser!.email &&
                            (searchController.text.isEmpty ||
                                product.name.toLowerCase().contains(
                                    searchController.text.toLowerCase())))
                        .toList();

                    return ListView.builder(
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        var product = filteredProducts[index];
                        return ShowMYProducts(product: product);
                      },
                    );
                  }

                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}