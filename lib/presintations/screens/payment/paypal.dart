import 'package:firstly/presintations/screens/payment/payment_gateway.dart';
import 'package:firstly/presintations/screens/payment/paymob_manager.dart';
import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  static String id = 'CheckoutPage';
  final num totalprice;
  const PaymentPage({super.key,required this.totalprice});

  @override
  State<PaymentPage> createState() => _CheckoutPageState();

  void _continuePayment() {}
}

class _CheckoutPageState extends State<PaymentPage> {
  void _continuePayment() {
    PaymobManager().payWithPaymob(widget.totalprice.toInt()).then((paymentKey) {
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
      body: Row(
        children: [
          Column(
            children: [
              Center(
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
                  child: const Text('Checkout With Paymob'),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Center(
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
                  child: const Text('Paypal'),
                ),
              ),
            ],
          ),
        ],
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