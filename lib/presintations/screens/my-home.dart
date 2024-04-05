import 'package:firstly/constants.dart';

import 'package:firstly/presintations/widgets/item.dart';
import 'package:firstly/presintations/widgets/matrial_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Column(
                  children: [
                    Center(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 55,
                      )),
                    )),
                    SizedBox(
                      height: 20,
                    ),
                    Text("uhu")
                  ],
                ),
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: kMainColor,
                ),
              ),
            ),
            Column(
              //  mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "       Materials",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 20, color: Gray),
                ),
                Row(
                  children: [
                    Container(
                      height: 150,
                      width: 400,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              Matrial(
                                  title: "Glasses",
                                  icon: Image.asset(
                                      "assets/images/icons-glass.png")),
                              Matrial(
                                  title: "Plastic",
                                  icon: Image.asset(
                                      "assets/images/icons-plastics.png")),
                              Matrial(
                                  title: "Compost",
                                  icon: Icon(Icons.food_bank_outlined)),
                              Matrial(
                                  title: "Papers",
                                  icon: Icon(Icons.file_copy_outlined)),
                              Matrial(
                                  title: "Oils",
                                  icon: Icon(Icons.oil_barrel_outlined)),
                            ]),
                      ),
                    )
                  ],
                ),
              ],
            ),
            Container(
                height: 350,
                width: 400,
                child: ListView(
                  children: [
                    ItemsGrideTail(),
                    ItemsGrideTail(),
                    ItemsGrideTail(),
                    ItemsGrideTail(),
                    ItemsGrideTail(),
                    ItemsGrideTail()
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
