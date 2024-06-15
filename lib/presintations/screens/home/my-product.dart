import 'package:firstly/constants.dart';
import 'package:firstly/data/models/product.dart';
import 'package:firstly/presintations/bloc/products_bloc.dart';
import 'package:firstly/presintations/bloc/products_event.dart';
import 'package:firstly/presintations/bloc/products_state.dart';
import 'package:firstly/presintations/widgets/show-myProduct.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyProduct extends StatefulWidget {
  @override
  _MyProductState createState() => _MyProductState();
}

class _MyProductState extends State<MyProduct> {
  List<Product> userProducts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    retrieveUserProducts();
  }

  Future<void> retrieveUserProducts() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Products') // Specify the collection name directly
          .where('userEmail', isEqualTo: currentUser.email)
          .get();

      List<Product> products =
          querySnapshot.docs.map((doc) => Product.fromDoc(doc)).toList();

      setState(() {
        userProducts = products;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoadingState) {
            // Show loading indicator while fetching products
            return Center(
              child: Lottie.asset(
                'assets/images/Animation loading1.json',
                height: 200,
                width: 200,
                repeat: true,
              ),
            );
          } else if (state is ProductLoaded) {
            // Update userProducts when products are loaded
            userProducts = state.products;
            isLoading = false;
          }

          return isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: userProducts.length,
                  itemBuilder: (context, index) {
                    var product = userProducts[index];
                    return ShowMYProducts(product: product);
                  },
                );
        },
      ),
    );
  }
}
