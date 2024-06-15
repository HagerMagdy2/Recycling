import 'package:firstly/constants.dart';
import 'package:firstly/data/models/product.dart';
import 'package:firstly/presintations/bloc/products_bloc.dart';
import 'package:firstly/presintations/bloc/products_event.dart';
import 'package:firstly/presintations/bloc/products_state.dart';
import 'package:firstly/presintations/screens/home/check_out_page.dart';
import 'package:firstly/presintations/widgets/show_in_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class CartPage extends StatefulWidget {
  const CartPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(GetCartProduct());
    // context.read<ProductBloc>().add(GetProduct());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: kMainColor,
        title: Text(
          'Cart Page',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: BlocListener<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is ProductLoaded) {
            // Handle the loaded state, if needed
          } else if (state is ProductErrorState) {
            // Handle the error state, if needed
          }
        },
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
              // Filter products to show only those in the cart
              // List<Product> cartProducts =
              //     state.products.where((product) => product.isInCart).toList();

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: state.products.length,
                        itemBuilder: (context, i) =>
                            ShowInCart(product: state.products[i]),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Price: ${calculateTotalPrice(state.products)} EGP',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CheckOutPage(
                                      cartProducts: state.products),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kMainColor,
                            ),
                            child: Text(
                              'Checkout',
                              style: TextStyle(color: kSecondaryColor),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return SizedBox(); // Return an empty widget for other states
            }
          },
        ),
      ),
    );
  }

  double calculateTotalPrice(List<Product> products) {
    double totalPrice = 0.0;
    for (var product in products) {
      totalPrice += product.price * product.quantity;
    }
    return totalPrice;
}
}