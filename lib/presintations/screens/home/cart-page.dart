import 'package:firstly/constants.dart';
import 'package:firstly/presintations/bloc/products_bloc.dart';
import 'package:firstly/presintations/bloc/products_event.dart';
import 'package:firstly/presintations/bloc/products_state.dart';
import 'package:firstly/presintations/screens/home/check_out_page.dart';
import 'package:firstly/presintations/widgets/show_product.dart';
import 'package:firstly/presintations/widgets/show_in_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:firstly/constants.dart';
import 'package:firstly/data/models/product.dart';
import 'package:firstly/presintations/bloc/products_bloc.dart';
import 'package:firstly/presintations/bloc/products_event.dart';
import 'package:firstly/presintations/bloc/products_state.dart';
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
  }

  List<Product> getCartProducts() {
    if (context.read<ProductBloc>().state is ProductLoaded) {
      return (context.read<ProductBloc>().state as ProductLoaded).products;
    }
    return [];
  }

  double calculateTotalPrice(List<Product> products) {
    double totalPrice = 0.0;
    for (var product in products) {
      totalPrice += product.price * product.quantity;
    }
    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: kMainColor,
        title: Text(
          'cart Page',
          style: TextStyle(color: Colors.white),
        ),
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
                    Padding(
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
                                          cartProducts: getCartProducts()),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  primary:
                                      kMainColor, // Use kMainColor as button background color
                                ),
                                child: Text('Checkout',style: TextStyle(color: kSecondaryColor),),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
