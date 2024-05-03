import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstly/core/storage_helper.dart';
import 'package:firstly/presintations/screens/payment/const.dart';

class PaymobManager {
  Dio dio = Dio();
  Future<String> payWithPaymob(int amount) async {
    try {
      String token = await getToken();
          int orderId =
          await getOrderId(token: token, amount: (100 * amount).toString());
          String paymentKey = await getPaymentKey(
          token: token,
          OrderId: (orderId).toString(),
          amount: (100 * amount).toString());
      return paymentKey;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getToken() async {
    try {
      Response response = await dio.post(
          'https://accept.paymob.com/api/auth/tokens',
          data: {"api_key": Constants.api_key});
      return response.data['token'];
    } catch (e) {
      rethrow;
    }
  }

  Future<int> getOrderId(
      {required String token, required String amount}) async {
    try {
      Response response = await dio
          .post('https://accept.paymob.com/api/ecommerce/orders',
           data: {
        "auth_token": token,
        "delivery_needed": "true",
        "amount_cents": amount,
        "currency": "EGP",
        "items": []
      });
      return response.data['id'];
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getPaymentKey(
      {required String token,
      required String OrderId,
      required String amount}) async {
    try {
      User? user = await FirebaseAuth.instance.currentUser;

      Response response = await dio
          .post('https://accept.paymob.com/api/acceptance/payment_keys', data: {
        "auth_token": token,
        "amount_cents": amount,
        "currency": "EGP",
        "integration_id": "4570448",
        "order_id": OrderId,
        "lock_order_when_paid": "false",
        "billing_data": {
          "apartment": "NA",
          "email": user!.email,
          "floor": "NA",
          "first_name": "test",
          "street": "NA",
          "building": "NA",
          "phone_number": "NA",
          "shipping_method": "NA",
          "postal_code": "NA",
          "city": "NA",
          "country": "NA",
          "last_name": "account",
          "state": "NA"
        },
      });
      return response.data['token'];
    } catch (e) {
      rethrow;
    }
  }
}
