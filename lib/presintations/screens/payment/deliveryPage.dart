import 'dart:math';

import 'package:firstly/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class OrderDetails {
  final String name;
  final String email;
  final String phone;
  final String location;
  final String notes;

  OrderDetails({
    required this.name,
    required this.email,
    required this.phone,
    required this.location,
    required this.notes,
  });
}

class DeliveryPage extends StatelessWidget {
  final OrderDetails orderDetails;
  final DateTime orderDate;

  const DeliveryPage({
    Key? key,
    required this.orderDetails,
    required this.orderDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateTime deliveryDate = orderDate.add(Duration(days: 2));
    final String formattedOrderDate =
        DateFormat('yyyy-MM-dd HH:mm').format(orderDate);
    final String formattedDeliveryDate =
        DateFormat('yyyy-MM-dd').format(deliveryDate);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMainColor,
        foregroundColor: Colors.white,
        title: Text('Delivery Confirmation'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                width: 500,
                height: 400,
                child: Lottie.asset('assets/images/delivery.json'),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Text(
                  'Order Number:',
                  style:
                      TextStyle(color: kMainColor, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  generateOrderNumber(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Text(
                  'Name:',
                  style:
                      TextStyle(color: kMainColor, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  orderDetails.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Text(
                  'Email:',
                  style:
                      TextStyle(color: kMainColor, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  orderDetails.email,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Text(
                  'Phone:',
                  style:
                      TextStyle(color: kMainColor, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  orderDetails.phone,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Text(
                  'Location:',
                  style:
                      TextStyle(color: kMainColor, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    orderDetails.location,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Text(
                  'Notes:',
                  style:
                      TextStyle(color: kMainColor, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    orderDetails.notes,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Text(
                  'Order Date:',
                  style:
                      TextStyle(color: kMainColor, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  formattedOrderDate,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Text(
                  'Delivery Date:',
                  style:
                      TextStyle(color: kMainColor, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  formattedDeliveryDate,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              'Your order will arrive in 2 days on $formattedDeliveryDate.',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Text(
                  'Thank you for choosing ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Be Green!',
                  style: TextStyle(
                      color: kMainColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  String generateOrderNumber() {
    // Generate a random number combined with current timestamp to ensure uniqueness
    Random random = Random();
    int randomNumber = random.nextInt(9997); // Adjust upper limit as needed
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    return '$randomNumber-$timestamp';
  }
}
