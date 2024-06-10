import 'package:flutter/material.dart';
import 'package:order_tracker/order_tracker.dart';
class DeliveryScreen extends StatefulWidget {
  const DeliveryScreen({Key? key}) : super(key: key);

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

List<TextDto> orderList = [
  TextDto("Your order has been placed", "Fri, 25th Mar '22 - 10:47pm"),
  TextDto("Seller ha processed your order", "Sun, 27th Mar '22 - 10:19am"),
  TextDto("Your item has been picked up by courier partner.", "Tue, 29th Mar '22 - 5:00pm"),
];

List<TextDto> shippedList = [
  TextDto("Your order has been shipped", "Tue, 29th Mar '22 - 5:04pm"),
  TextDto("Your item has been received in the nearest hub to you.", null),
];

List<TextDto> outOfDeliveryList = [
  TextDto("Your order is out for delivery", "Thu, 31th Mar '22 - 2:27pm"),
];

List<TextDto> deliveredList = [
  TextDto("Your order has been delivered", "Thu, 31th Mar '22 - 3:58pm"),
];

class _DeliveryScreenState extends State<DeliveryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delivery'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Delivery boy is coming',style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),),
              Text('Estimated arriving at : 9:30 AM - 10:10 Am',style: TextStyle(
                  fontSize: 16,
                color: Colors.grey
              ),),

              SizedBox(
                height: 20,
              ),

              OrderTracker(
                status: Status.order,
                activeColor: Colors.green,
                inActiveColor: Colors.grey[300],
                orderTitleAndDateList: orderList,
                shippedTitleAndDateList: shippedList,
                outOfDeliveryTitleAndDateList: outOfDeliveryList,
                deliveredTitleAndDateList: deliveredList,

              ),

              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey[400],
              ),

              SizedBox(
                height: 20,
              ),

              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage('https://static.vecteezy.com/system/resources/previews/015/119/100/original/businessman-icon-man-icon-design-illustration-free-png.png'),
                    radius: 40,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Tanzir Fahad',style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),),
                      Text('Delivery Boy',style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey
                      ),),
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Row(
                    children: [
                      CircleAvatar(child: Icon(Icons.chat,color: Colors.green,)),
                       SizedBox(
                         width: 10,
                       ),
                      CircleAvatar(child: Icon(Icons.call,color: Colors.green)),
                    ],
                  ),
                ],
              ),



            ],
          ),
        ),
      ),
    );
  }
}
