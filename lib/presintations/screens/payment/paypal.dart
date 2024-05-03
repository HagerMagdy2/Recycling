import 'package:firstly/presintations/screens/home_screen.dart';
import 'package:firstly/presintations/screens/payment/payment_gateway.dart';
import 'package:firstly/presintations/screens/payment/paymob_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';

class CheckoutPage extends StatefulWidget {
  static String id = 'CheckoutPage';
  final num totalprice = 10;
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  void _continuePayment() {
    PaymobManager()
      .payWithPaymob(widget.totalprice.toInt()).then((paymentKey) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => paymentGateway(paymentToken: paymentKey),
          ),
        );
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "PayPal Checkout",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Center(
        child: TextButton(
          onPressed: () async {
            _continuePayment();
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
            shape: const BeveledRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(1),
              ),
            ),
          ),
          child: const Text('Checkout'),
        ),
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
