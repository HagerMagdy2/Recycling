import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstly/constants.dart';
import 'package:firstly/controller/home-page-controller.dart';
import 'package:firstly/presintations/screens/add_product.dart';
import 'package:firstly/presintations/widgets/bottom-bar.dart';
import 'package:firstly/presintations/widgets/drawer.dart';
import 'package:firstly/presintations/widgets/item.dart';
import 'package:firstly/presintations/widgets/matrial_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyHomePage extends StatefulWidget {
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
                          backgroundColor: kMainColor,
                          radius: 65,
                          backgroundImage: profilePhotoUrl != null
                              ? NetworkImage(profilePhotoUrl!)
                              : null,
                          child: profilePhotoUrl == null
                              ? Icon(
                                  Icons.person,
                                  size: 80,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                      ),
                    )),
                    SizedBox(
                      height: 10,
                    ),
                  Text(
              userName ?? 'User Name',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            ),
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
                  "      Materials",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 20, color: Gray),
                ),
                Row(
                  children: [
                    Container(
                      height: 120,
                      width: 400,
                      child: Padding(
                        
                        padding: const EdgeInsets.all(8.0),
                        child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            GlassesCategoryPage()),
                                  );
                                },
                                child: Matrial(
                                  title: "Glasses",
                                  icon: Image.asset(
                                      "assets/images/icons-glass.png")),
                              Matrial(
                                  title: "Plastic",
                                  icon: Image.asset(
                                    "assets/images/icons-plastics.png",
                                    height: 50,
                                  )),
                              Matrial(
                                  title: "Compost",
                                  icon: Image.asset(
                                    "assets/images/icons-carrots.png",
                                    height: 50,
                                  )),
                              Matrial(
                                  title: "Papers",
                                  icon: Image.asset(
                                    "assets/images/icons-paper.png",
                                    height: 50,
                                  )),
                              Matrial(
                                  title: "Oils",
                                  icon: Image.asset(
                                    "assets/images/icons-oils.png",
                                    height: 50,
                                  )),
                            ]),
                      ),
                    )
                  ],
                ),
              ],
            ),
            Column(
              //  mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "For you",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 18, color: Gray),
                ),
              ]
            ),
            Container(
                height: 320,
                width: 400,
                child: ListView(
                  children: [
                    ItemsGrideTail(),
                    ItemsGrideTail(),
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
