import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
//import 'package:in_app_webview/in_app_webview.dart';

class paymentGateway extends StatefulWidget {
  final String paymentToken;

const  paymentGateway({super.key, required this.paymentToken});

  @override
  State<paymentGateway> createState() => _paymentGatewayState();
}

class _paymentGatewayState extends State<paymentGateway> {
  InAppWebViewController? _webViewController;

  void initState() {
    super.initState();
    startPayment();
  }

  void startPayment() {
    _webViewController?.loadUrl(
      urlRequest: URLRequest(
        url: Uri.parse(
          'https://accept.paymob.com/api/acceptance/iframes/844304?payment_token=${widget.paymentToken}',
        ),
      ),
    );
  }

  Future<void> handlePaymentSucces() async {
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: InAppWebView(
        initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(javaScriptEnabled: true)),
        onWebViewCreated: (controller) {
          _webViewController = controller;
          startPayment();
        },
        onLoadStop: (controller, url) {
          if (url != null &&
              url.queryParameters.containsKey('success') &&
              url.queryParameters['success'] == 'true') {
            print("payment success");
          } else if (url != null &&
              url.queryParameters.containsKey('success') &&
              url.queryParameters['success'] == 'false') {
            print("payment failed");
          }
        },
      ),
    );
  }
}
