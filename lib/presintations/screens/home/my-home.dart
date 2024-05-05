import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstly/constants.dart';
import 'package:firstly/controller/home-page-controller.dart';
import 'package:firstly/core/storage_helper.dart';
import 'package:firstly/data/models/product.dart';
import 'package:firstly/presintations/screens/category/compost-page.dart';
import 'package:firstly/presintations/screens/category/glasses_page.dart';
import 'package:firstly/presintations/screens/category/oils_page.dart';
import 'package:firstly/presintations/screens/category/papers-page.dart';
import 'package:firstly/presintations/screens/category/plastic-page.dart';
import 'package:firstly/presintations/widgets/bottom-bar.dart';
import 'package:firstly/presintations/widgets/drawer.dart';
import 'package:firstly/presintations/widgets/item.dart';
import 'package:firstly/presintations/widgets/matrial_widget.dart';
import 'package:firstly/presintations/widgets/show_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? profilePhotoUrl;
  late String userId;
  String? userName;
  @override
  void initState() {
    super.initState();
    userId = StorageHelperImpl().getCurrentUserId();
    loadProfilePhotoUrl();
    loadProfileData(); // Call loadPhoneNumber here
    StorageHelperImpl().profilePhotoStream.listen((String newUrl) {
      setState(() {
        profilePhotoUrl = newUrl;
      });
    });
  }

  Future<void> loadProfilePhotoUrl() async {
    profilePhotoUrl = await StorageHelperImpl().getProfilePhotoUrl(userId);
    setState(() {});
  }

  Future<void> loadProfileData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userName = user.displayName;
      });
    }
  }

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
                          color: Colors.white),
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
                  style: TextStyle(
                      fontSize: 22,
                      color: kMainColor1,
                      fontWeight: FontWeight.w500),
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
                                      "assets/images/icons-glasses.png",
                                      height: 50,
                                    )),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PlasticCategoryPage()),
                                  );
                                },
                                child: Matrial(
                                    title: "Plastic",
                                    icon: Image.asset(
                                      "assets/images/icons-plastics.png",
                                      height: 50,
                                    )),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CompostCategoryPage()),
                                  );
                                },
                                child: Matrial(
                                    title: "Compost",
                                    icon: Image.asset(
                                      "assets/images/icons-carrots.png",
                                      height: 50,
                                    )),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PapersCategoryPage()),
                                  );
                                },
                                child: Matrial(
                                    title: "Papers",
                                    icon: Image.asset(
                                      "assets/images/icons-paper.png",
                                      height: 50,
                                    )),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            OilsCategoryPage()),
                                  );
                                },
                                child: Matrial(
                                    title: "Oils",
                                    icon: Image.asset(
                                      "assets/images/icons-oils.png",
                                      height: 50,
                                    )),
                              ),
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
                    style: TextStyle(
                        fontSize: 20,
                        color: kMainColor1,
                        fontWeight: FontWeight.w500),
                  ),
                ]),
            Container(
                height: 320,
                width: 400,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ListView(
                    children: [
                      ShowProducts(
                          product: Product(
                        image:
                            "https://firebasestorage.googleapis.com/v0/b/recycling-ab7d2.appspot.com/o/product_images%2F1714767572806.jpg?alt=media&token=da7134f5-8e70-4011-bf68-aa379d440731",
                        name: "Cooking Oil",
                        price: 25,
                        id: '',
                        userId: '',
                        userName: 'maiatef',
                        userEmail: 'maiatef17@gmail.com',
                        userPhone: '01119257229',
                        quantity: 1,
                        availableQuantity: 5,
                      )),
                      ShowProducts(
                          product: Product(
                        image:
                            "https://firebasestorage.googleapis.com/v0/b/recycling-ab7d2.appspot.com/o/product_images%2F1714759096537.jpg?alt=media&token=552b2757-3ae2-42be-9c2a-cffece628920",
                        name: "Flower Vase",
                        price: 95,
                        id: '',
                        userId: '',
                        userName: 'hagar',
                        userEmail: 'hagarmag5@gmail.com',
                        userPhone: '0115516',
                        quantity: 1,
                        availableQuantity: 5,
                      )),
                      ShowProducts(
                          product: Product(
                        image:
                            "https://firebasestorage.googleapis.com/v0/b/recycling-ab7d2.appspot.com/o/product_images%2F1714760266207.jpg?alt=media&token=854b8c8d-5aa6-40fb-9f06-51ac23ca2a79",
                        name: "Print Newspapers",
                        price: 95,
                        id: '',
                        userId: '',
                        userName: 'Arwa',
                        userEmail: 'arwa@gmail.com',
                        userPhone: '012346',
                        quantity: 1,
                        availableQuantity: 5,
                      ))
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
