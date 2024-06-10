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
  @override
  
  void initState() {
    super.initState();
    // Fetch user products when the widget is initialized
    context
        .read<ProductBloc>()
        .add(GetProduct()); // Dispatch FetchProducts event
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
            User? currentUser = FirebaseAuth.instance.currentUser;

            // Filter products based on the current user's email
            List<Product> filteredProducts = state.products
                .where((product) => product.userEmail == currentUser!.email)
                .toList();

            if (filteredProducts.isEmpty) {
              // If there are no products for the current user, display a message
              return Center(
                child: Text('No products found for the current user.'),
              );
            }

            return ListView.builder(
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                var product = filteredProducts[index];
                return ShowMYProducts(product: product);
              },
            );
          } else if (state is ProductErrorState) {
            // Show error message if products couldn't be loaded
            return Center(
              child: Text('Error loading products: ${state.errorMessage}'),
            );
          }

          // Show a generic loading indicator by default
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
