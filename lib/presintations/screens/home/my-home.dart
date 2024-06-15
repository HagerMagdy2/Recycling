import 'package:easy_localization/easy_localization.dart';
import 'package:firstly/presintations/screens/category/compost-page.dart';
import 'package:firstly/presintations/widgets/matrial_widget.dart';
import 'package:flutter/material.dart';
import 'package:firstly/constants.dart';
import 'package:firstly/data/models/product.dart';
import 'package:firstly/presintations/screens/category/glasses_page.dart';
import 'package:firstly/presintations/screens/category/oils_page.dart';
import 'package:firstly/presintations/screens/category/papers-page.dart';
import 'package:firstly/presintations/screens/category/plastic-page.dart';
import 'package:firstly/presintations/screens/home/profile-screen.dart';
import 'package:firstly/presintations/widgets/show_for_you.dart';
import 'package:firstly/core/storage_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? profilePhotoUrl;
  late String userId;
  String? userName;
  String? userEmail;

  @override
  void initState() {
    super.initState();
    userId = StorageHelperImpl().getCurrentUserId();
    loadProfilePhotoUrl();
    loadProfileData();
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
        userEmail = user.email;
      });
    }
  }

  void navigateToCategory(BuildContext context, int index) {
    // Define navigation based on the index
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OilsCategoryPage()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PlasticCategoryPage()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PapersCategoryPage()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GlassesCategoryPage()),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CompostCategoryPage()),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 22),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 200,
                    width: 400,
                    decoration: BoxDecoration(
                        gradient: kMainColorGradient,
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 12.0, top: 50.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            userName ?? 'User Name',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            userEmail ?? 'User Email',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: -40,
                    left: 115,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(65),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 4.0,
                          ),
                        ),
                        child: profilePhotoUrl != null
                            ? CircleAvatar(
                                backgroundColor: kMainColor,
                                radius: 65,
                                backgroundImage: NetworkImage(profilePhotoUrl!),
                              )
                            : const CircleAvatar(
                                backgroundColor: kMainColor,
                                radius: 65,
                                child: Icon(
                                  Icons.person,
                                  size: 80,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 150,
                    left: 115,
                    child: OutlinedButton(
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfileScreen(),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        fixedSize: const Size(140, 10),
                      ),
                      child: const Text(
                        'View Profile',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tr("      Materials"),
                  style: TextStyle(
                    fontSize: 22,
                    color: kMainColor1,
                    fontWeight: FontWeight.w500,
                  ),
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
                                title: tr("Glasses"),
                                icon: Image.asset(
                                  "assets/images/icons-glasses.png",
                                  height: 50,
                                ),
                              ),
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
                                title: tr("Plastic"),
                                icon: Image.asset(
                                  "assets/images/icons-plastics.png",
                                  height: 50,
                                ),
                              ),
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
                                title: tr("Compost"),
                                icon: Image.asset(
                                  "assets/images/icons-carrots.png",
                                  height: 50,
                                ),
                              ),
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
                                title: tr("Papers"),
                                icon: Image.asset(
                                  "assets/images/icons-paper.png",
                                  height: 50,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OilsCategoryPage()),
                                );
                              },
                              child: Matrial(
                                title: tr("Oils"),
                                icon: Image.asset(
                                  "assets/images/icons-oils.png",
                                  height: 50,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tr("For you"),
                  style: TextStyle(
                    fontSize: 20,
                    color: kMainColor1,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Container(
              height: 320,
              width: 400,
              child: ListView(
                children: [
                  GestureDetector(
                    onTap: () => navigateToCategory(context, 2),
                    child: ShowForYou(
                      product: Product(
                        image:
                            'https://firebasestorage.googleapis.com/v0/b/recycling-ab7d2.appspot.com/o/product_images%2F1713741794884.jpg?alt=media&token=6d02d1cc-0cbb-4d7b-b851-52771e762335',
                        name: 'Pepper Caffeine Container',
                        id: '',
                        userId: userId,
                        userName: '',
                        userEmail: '',
                        userPhone: '',
                        price: 10,
                        quantity: 1,
                        availableQuantity: 1,
                        category: 'pepper',
                      ),
                    ),
                  ),
                  
                  GestureDetector(
                    onTap: () => navigateToCategory(context, 1),
                    child: ShowForYou(
                      product: Product(
                        image:
                            'https://firebasestorage.googleapis.com/v0/b/recycling-ab7d2.appspot.com/o/product_images%2F1713741072235.jpg?alt=media&token=0654e890-f6a1-4345-8531-847c6fb9e8ea',
                        name: 'plastic food containers',
                        id: '',
                        userId: userId,
                        userName: '',
                        userEmail: '',
                        userPhone: '',
                        price: 90,
                        quantity: 3,
                        availableQuantity: 4,
                        category: 'plastic',
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => navigateToCategory(context, 0),
                    child: ShowForYou(
                      product: Product(
                        image:
                            'https://firebasestorage.googleapis.com/v0/b/recycling-ab7d2.appspot.com/o/product_images%2F1714767572806.jpg?alt=media&token=da7134f5-8e70-4011-bf68-aa379d440731',
                        name: 'Cooking Oil',
                        id: '',
                        userId: userId,
                        userName: '',
                        userEmail: '',
                        userPhone: '',
                        price: 25,
                        quantity: 2,
                        availableQuantity: 5,
                        category: 'oil',
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => navigateToCategory(context, 3),
                    child: ShowForYou(
                      product: Product(
                        image:
                            'https://firebasestorage.googleapis.com/v0/b/recycling-ab7d2.appspot.com/o/product_images%2F1717804503144.jpg?alt=media&token=e52e78c1-761e-40ce-a546-bafe89ae059a',
                        name: 'Candy Bowls',
                        id: '',
                        userId: userId,
                        userName: '',
                        userEmail: '',
                        userPhone: '',
                        price: 120,
                        quantity: 2,
                        availableQuantity: 5,
                        category: 'glass',
                      ),
                    ),
                  ),
                  
                  SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
          ],
        ),
    ),
);
}
}