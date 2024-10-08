
import 'package:easy_localization/easy_localization.dart';
import 'package:firstly/constants.dart';
import 'package:firstly/data/models/product.dart';
import 'package:firstly/presintations/screens/home/location.dart';

import 'package:firstly/constants.dart';
import 'package:firstly/data/models/product.dart';

import 'package:firstly/presintations/screens/payment/payment_gateway.dart';
import 'package:firstly/presintations/screens/payment/paymob_manager.dart';
import 'package:firstly/presintations/screens/payment/paypal.dart';
import 'package:firstly/presintations/widgets/show_in_checkout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';

class CheckOutPage extends StatefulWidget {

  const CheckOutPage({Key? key, required this.cartProducts}) : super(key: key);
  final List<Product> cartProducts;

  const CheckOutPage({Key? key, required this.cartProducts}) : super(key: key);
  final List<Product> cartProducts;
  


  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
<<<<<<< HEAD
  late num totalPrice = 0;
=======

>>>>>>> 1f75ed218b06bd42ef38d9693fd7f69fc9197195
  num getTotalPrice() {
    // Initialize totalPrice inside the method

    for (var product in widget.cartProducts) {
      totalPrice += product.price * product.quantity;
    }

    return totalPrice;
  }

  void _continuePayment() {
<<<<<<< HEAD
    //num totalprice = getTotalPrice().toDouble();
    PaymobManager().payWithPaymob(totalPrice.toInt()).then((paymentKey) {
=======
    num totalprice = getTotalPrice().toDouble();
    PaymobManager().payWithPaymob(totalprice.toInt()).then((paymentKey) {

  late num totalPrice =0;
    num getTotalPrice() {
    //double totalPrice = 0.0;
    for (var product in widget.cartProducts) {
      totalPrice += product.price * product.quantity;
    }
    return totalPrice;
  }
  void _continuePayment() {
    // num totalprice = getTotalPrice().toDouble();
    PaymobManager().payWithPaymob(totalPrice.toInt()).then((paymentKey) {

>>>>>>> 1f75ed218b06bd42ef38d9693fd7f69fc9197195
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => paymentGateway(paymentToken: paymentKey),
        ),
      );
    });
  }





  InputDecoration _buildInputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      contentPadding: EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 16.0),
    );
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Confirm Order',
            style: TextStyle(
              color: kSecondaryColor,
            ),
          ),
          backgroundColor: kMainColor,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.grey[200],
                ),
                child: TextField(
                  controller: nameController,
                  decoration: _buildInputDecoration('Name'),
                ),
              ),
              SizedBox(height: 12.0),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.grey[200],
                ),
                child: TextField(
                  controller: emailController,
                  decoration: _buildInputDecoration('Email'),
                ),
              ),
              SizedBox(height: 12.0),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.grey[200],
                ),
                child: TextField(
                  controller: phoneController,
                  decoration: _buildInputDecoration('Phone'),
                ),
              ),
              SizedBox(height: 12.0),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.grey[200],
                ),
                child: TextField(
                  controller: phoneController,
                  decoration: _buildInputDecoration('Address'),
                ),
              ),
              SizedBox(height: 12.0),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.grey[200],
                ),
                child: TextField(
                  controller: notesController,
                  decoration: _buildInputDecoration('Notes'),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
<<<<<<< HEAD
                _showPaymentDialog();
=======
                Navigator.push(
                  context,
                  MaterialPageRoute(

                      builder: (context) =>
                          PaymentPage(totalprice: getTotalPrice())),

                      builder: (context) => PaymentPage(totalprice:totalPrice )),

                );
>>>>>>> 1f75ed218b06bd42ef38d9693fd7f69fc9197195
              },
              child: Text(
                'Confirm',
                style: TextStyle(
                  color: kSecondaryColor,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel',
                  style: TextStyle(
                    color: kSecondaryColor,
                  )),
            ),
          ],
        );
      },
    );
  }
void _showPaymentDialog() {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: 200, // Adjust height as needed
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Text(
              'Pay',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            Expanded(
              child: ListView(
                children: [
                  GestureDetector(
                    onTap: () =>   _continuePayment(),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/paymobLogo.png',
                            width: 50,
                            height: 50,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Pay With Paymob',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PaypalCheckout(sandboxMode: true,
                        clientId:
                            "AftxijrSfWNnLyyVF_3jKzbyqpwDMhJZbU8IXaYcpLdW6d2CBwyAx9rKZ57waYdAY40kPaU2V2SH5p2V",
                        secretKey:
                            "EM8uOZf_WELwN2h7JCubnux9SL5mX_meISEEPKuqdh71-E6PQFjtLtNsxZcWYInXcHmyoEyKiHhMjreE",
                        returnURL: "success.snippetcoder.com",
                        cancelURL: "cancel.snippetcoder.com",

                        //  emailPersonal:sb-st7md30520465@personal.example.com pass:123456789
                        //  emailBissness:sb-pr743330543964@business.example.com pass:123456789

                        transactions: [
                          {
                            "amount": {
                              "total": '$totalPrice',
                              "currency": "USD",
                              "details": {
                                "subtotal": '$totalPrice',
                                "shipping": '0',
                                "shipping_discount": 0
                              }
                            },
                            "description":
                                "The payment transaction description.",
                            // "payment_options": {
                            //   "allowed_payment_method":
                            //       "INSTANT_FUNDING_SOURCE"
                            // },
                            "item_list": {
                              "items": widget.cartProducts
                                  .map((product) => {
                                        "name": product.name,
                                        "quantity": product.quantity,
                                        "price": product.price,

                                        "currency": "USD"
                                        // ... other item details (optional)
                                      })
                                  .toList(),
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
                            MaterialPageRoute(
                                builder: (context) => SuccessPage()),
                          );
                        },
                        onError: (error) {
                          print("onError: $error");
                          // Navigate to the failure page
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FailurePage()),
                          );
                        },
                        onCancel: () {
                          print('cancelled:');
                        },
                      ),
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/paypal.png',
                            width: 50,
                            height: 50,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Pay With Paypal',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Add more similar structures for other payment options
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}

  void _showpaymentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Pay',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: kMainColor,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                ),
                child: GestureDetector(
                  onTap: () async {
                    _continuePayment();
                  },
                  child: Row(
                    children: [
                      Image.asset("assets/images/paymobLogo.png",
                          width: 50, height: 50),
                      SizedBox(width: 10),
                      Text(
                        "Pay With Paymob",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(height: 8),
                      Container(
                        width: 100,
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12.0),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                ),
                child: GestureDetector(
                  onTap: () async {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => PaypalCheckout(
                        sandboxMode: true,
                        clientId:
                            "AftxijrSfWNnLyyVF_3jKzbyqpwDMhJZbU8IXaYcpLdW6d2CBwyAx9rKZ57waYdAY40kPaU2V2SH5p2V",
                        secretKey:
                            "EM8uOZf_WELwN2h7JCubnux9SL5mX_meISEEPKuqdh71-E6PQFjtLtNsxZcWYInXcHmyoEyKiHhMjreE",
                        returnURL: "success.snippetcoder.com",
                        cancelURL: "cancel.snippetcoder.com",

                        //  emailPersonal:sb-st7md30520465@personal.example.com pass:123456789
                        //  emailBissness:sb-pr743330543964@business.example.com pass:123456789


                        transactions: [
                          {
                            "amount": {
                              "total": '$totalPrice',
                              "currency": "USD",
                              "details": {
<<<<<<< HEAD
                                "subtotal": '$totalPrice',
=======
                                "subtotal": '$getTotalPrice()',

                        
                        transactions:  [
                          {
                            "amount": {
                              "total": '$totalPrice',
                              "currency": "USD",
                              "details": {
                                "subtotal":'$totalPrice',

>>>>>>> 1f75ed218b06bd42ef38d9693fd7f69fc9197195
                                "shipping": '0',
                                "shipping_discount": 0
                              }
                            },
                            "description":
                                "The payment transaction description.",
                            // "payment_options": {
                            //   "allowed_payment_method":
                            //       "INSTANT_FUNDING_SOURCE"
                            // },
                            "item_list": {

                              "items": widget.cartProducts
                                  .map((product) => {
                                        "name": product.name,
                                        "quantity": product.quantity,
                                        "price": product.price,

                                        "currency": "USD"
                                        // ... other item details (optional)
                                      })
                                  .toList(),
                              // shipping address is not required though

                            "items": widget.cartProducts.map((product) => {
    "name": product.name,
    "quantity": product.quantity,
     "price": product.price,

"currency": "USD"
    // ... other item details (optional)
  }).toList(),
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
                            MaterialPageRoute(
                                builder: (context) => SuccessPage()),
                          );
                        },
                        onError: (error) {
                          print("onError: $error");
                          // Navigate to the failure page
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FailurePage()),
                          );
                        },
                        onCancel: () {
                          print('cancelled:');
                        },
                      ),
                    ));
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/paypal.png",
                        width: 50,
                        height: 50,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Pay With Paypal",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(height: 8),
                      Container(
                        width: 100,
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: kMainColor,
        title: Text(
          tr('Checkout'),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 23,
          ),
        ),
      ),
      body: Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                child: Row(
                  children: [
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      tr("QTY"),
                      style: TextStyle(
                        color: kMainColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 78,
                    ),
                    Text(
                      tr("PRODUCT NAME"),
                      style: TextStyle(
                        color: kMainColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Text(
                      tr("PRICE"),
                      style: TextStyle(
                        color: kMainColor,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.cartProducts.length,
                itemBuilder: (context, i) =>
                    ShowInCheckout(product: widget.cartProducts[i]),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      SizedBox(
                        width: 70,
                      ),
                      Text(
                        tr("Total Price: "),
                        style: TextStyle(
                          color: kMainColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Text(
                        "${getTotalPrice().toStringAsFixed(2)} " + tr("EGP"),
                        style: TextStyle(
                          color: kMainColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: _showConfirmationDialog,
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(500, 50),
                      backgroundColor: kMainColor,
                    ),
                    child: Text(
                      tr('CONFIRM ORDER'),
                      style: TextStyle(
                        color: kSecondaryColor,
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Location()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(500, 50),
                      backgroundColor: kMainColor,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on,
                          color: kSecondaryColor,
                        ),
                        SizedBox(width: 8),
                        Text(
                          tr('Location'),
                          style: TextStyle(
                            color: kSecondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
<<<<<<< HEAD
=======

>>>>>>> 1f75ed218b06bd42ef38d9693fd7f69fc9197195
