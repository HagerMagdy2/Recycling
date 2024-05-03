import 'package:firstly/constants.dart';
import 'package:firstly/presintations/bloc/products_bloc.dart';
import 'package:firstly/presintations/bloc/products_event.dart';
import 'package:firstly/presintations/bloc/products_state.dart';

import 'package:firstly/presintations/widgets/show_product.dart';
import 'package:firstly/presintations/widgets/show_in_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';
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
                                onPressed: () async {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => PaypalCheckout(
                sandboxMode: true,
                clientId: "AftxijrSfWNnLyyVF_3jKzbyqpwDMhJZbU8IXaYcpLdW6d2CBwyAx9rKZ57waYdAY40kPaU2V2SH5p2V",
                secretKey: "EM8uOZf_WELwN2h7JCubnux9SL5mX_meISEEPKuqdh71-E6PQFjtLtNsxZcWYInXcHmyoEyKiHhMjreE",
                returnURL: "success.snippetcoder.com",
                cancelURL: "cancel.snippetcoder.com",

              //  emailPersonal:sb-st7md30520465@personal.example.com pass:123456789
             //  emailBissness:sb-pr743330543964@business.example.com pass:123456789
                transactions: const [
                  {
                    "amount": {
                      "total": '2',
                      "currency": "USD",
                      "details": {
                        "subtotal": '2',
                        "shipping": '0',
                        "shipping_discount": 0
                      }
                    },
                    "description": "The payment transaction description.",
                    // "payment_options": {
                    //   "allowed_payment_method":
                    //       "INSTANT_FUNDING_SOURCE"
                    // },
                    "item_list": {
                      "items": [
                        {
                          "name": "Apple",
                          "quantity": 1,
                          "price": '1',
                          "currency": "USD"
                        },
                        {
                          "name": "Pineapple",
                          "quantity": 1,
                          "price": '1',
                          "currency": "USD"
                        }
                      ],

                      // shipping address is not required though
                      //   "shipping_address": {
                      //     "recipient_name": "Raman Singh",
                      //     "line1": "Delhi",
                      //     "line2": "",
                      //     "city": "Delhi",
                      //     "country_code": "IN",
                      //     "postal_code": "11001",
                      //     "phone": "+00000000",
                      //     "state": "Texas"
                      //  },
                    }
                  }
                ],
                note: "Contact us for any questions on your order.",
                onSuccess: (Map params) async {
                  print("onSuccess: $params");
                  // Navigate to the success page
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => SuccessPage()) ,
                  );
                },
                onError: (error) {
                  print("onError: $error");
                  // Navigate to the failure page
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => FailurePage()),
                  );
                },
                onCancel: () {
                  print('cancelled:');
                },
              ),
            ));
          },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: kMainColor, // Use kMainColor as button background color
                                ),
                                child: Text('Checkout' , style: TextStyle(color: Colors.white),),
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

class FailurePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment Failed"),
      ),
      body: Center(
        child: Text(
          "Your payment failed. Please try again.",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

class SuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment Successful"),
      ),
      body: Center(
        child: Text(
          "Your payment was successful!",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}