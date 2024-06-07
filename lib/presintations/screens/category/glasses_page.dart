import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstly/constants.dart';
import 'package:firstly/core/firebase-service.dart';
import 'package:firstly/presintations/bloc/products_bloc.dart';
import 'package:firstly/presintations/bloc/products_event.dart';
import 'package:firstly/presintations/bloc/products_state.dart';
import 'package:firstly/presintations/screens/add-edit/add_glasses.dart';
import 'package:firstly/presintations/widgets/show_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class GlassesCategoryPage extends StatefulWidget {
  const GlassesCategoryPage({
    Key? key,
  }) : super(key: key);

  @override
  State<GlassesCategoryPage> createState() => _GlassesCategoryPageState();
}

class _GlassesCategoryPageState extends State<GlassesCategoryPage> {
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    context.read<ProductBloc>().add(GetProduct());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: kMainColor,
        title: Text(
          'Glasses Page',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: kSecondaryColor),
            onPressed: () {
              showModalBottomSheet(
                backgroundColor: kMainColor,
                context: context,
                isScrollControlled: false,
                builder: (BuildContext context) {
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: TextField(
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
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (state is ProductLoadingState)
                    Lottie.asset(
                      'assets/images/Animation loading1.json',
                      height: 200,
                      width: 200,
                      repeat: true,
                    ),
                  if (state is ProductErrorState)
                    Text('Error: ${state.errorMessage}'),
                  if (state is ProductLoaded)
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.products.length,
                      itemBuilder: (context, i) {
                        final product = state.products[i];
                        //   print('Product Category: ${product.category}');
                        // Check if the product user email matches the current user's email
                        User? currentUser = FirebaseAuth.instance.currentUser;
                        //  print('Current User Email: ${currentUser!.email}');
                        // if (product.userEmail == currentUser!.email) {
                        //   print(
                        //       'Skipping product: ${product.name} because it belongs to current user.');
                        //   return SizedBox
                        //       .shrink(); // Skip displaying this product
                        // }

                        // Check if there's a search query and the product name doesn't contain it
                        if (searchController.text.isNotEmpty &&
                            !product.name.toLowerCase().contains(
                                searchController.text.toLowerCase())) {
                          // print(
                          //     'Skipping product: ${product.name} because it does not match search query.');
                          return SizedBox.shrink();
                        }

                        if (product.category.toLowerCase() != "glasses") {
                          // print(
                          //     'Skipping product: ${product.name} because it is not in the "glasses" category.');
                          return SizedBox
                              .shrink(); // Skip displaying this product
                        }
                        //  print('Displaying product: ${product.name}');
                        return ShowProducts(product: product);
                      },
                    ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kMainColor,
        onPressed: () async {
          await Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddGlassesPage()));
          setState(() {});
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
