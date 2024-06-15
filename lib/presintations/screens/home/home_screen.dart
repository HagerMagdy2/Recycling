import 'package:firstly/constants.dart';
import 'package:firstly/controller/home-page-controller.dart';
import 'package:firstly/presintations/screens/home/add-frome-home.dart';
import 'package:firstly/presintations/screens/home/cart-page.dart';
import 'package:firstly/presintations/screens/home/favorite_screen.dart';
import 'package:firstly/presintations/screens/home/learn_screen.dart';
import 'package:firstly/presintations/screens/home/my-home.dart';
import 'package:firstly/presintations/screens/home/my-product.dart';
import 'package:firstly/presintations/screens/home/profile-screen.dart';
import 'package:firstly/presintations/widgets/bottom-bar.dart';
import 'package:firstly/presintations/widgets/drawer.dart';
import 'package:firstly/presintations/widgets/matrial_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> screens = [
    MyHomePage(),
    FavoriteScreen(),
    LearnScreen(),
    MyProduct()
  ];
  @override
  Widget build(BuildContext context) {
    Get.put(HomeControllerImp());
    return GetBuilder<HomeControllerImp>(
        builder: (controller) => Scaffold(
              drawer: AppDrawer(),
              appBar: AppBar(
                actions: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CartPage()),
                      );
                    },
                    child: Icon(
                      Icons.shopping_cart,
                      color: kMainColor,
                    ),
                  )
                ],
                foregroundColor: kMainColor,
                backgroundColor: Colors.white,
                title: const Text(
                  'Be Green',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: kMainColor),
                  textAlign: TextAlign.center,
                ),
              ),
              body: screens[currentIndex],
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.miniCenterDocked,
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddFromHome(),
                    ),
                  );
                },
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                backgroundColor: kMainColor,
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  currentIndex: currentIndex,
                  selectedItemColor: kMainColor,
                  onTap: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home,
                      ),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.favorite,
                        ),
                        label: 'Favorite'),
                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.lightbulb,
                        ),
                        label: 'Learn'),
                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.move_up_rounded,
                        ),
                        label: 'Your Products'),
                  ],
                ),
              ),
            ));
  }
}
