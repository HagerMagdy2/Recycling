import 'package:firstly/constants.dart';
import 'package:firstly/controller/home-page-controller.dart';
import 'package:firstly/presintations/screens/add_product.dart';
import 'package:firstly/presintations/widgets/bottom-bar.dart';
import 'package:firstly/presintations/widgets/drawer.dart';
import 'package:firstly/presintations/widgets/item.dart';
import 'package:firstly/presintations/widgets/matrial_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeControllerImp());
    return GetBuilder<HomeControllerImp>(
        builder: (controller) => Scaffold(
            drawer: AppDrawer(),
            appBar: AppBar(
              foregroundColor: kMainColor,
              backgroundColor: Colors.white,
              title: const Text(
                'Be Green',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: kMainColor),
                textAlign: TextAlign.center,
              ),
            ),
            body: controller.pagesList.elementAt(controller.currentPage),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              child: Icon(Icons.add),
              backgroundColor: kMainColor,
              elevation: 10,
            ),
            bottomNavigationBar: BottomAppBar(
              height: 50.0,
              notchMargin: 5.0,
              shape: CircularNotchedRectangle(),
              color: Colors.white,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: MaterialButton(
                        onPressed: () => controller.changePage(0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.home,
                              color: Colors.grey,
                            ),
                            Text('Home', style: TextStyle(color: Colors.grey))
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: MaterialButton(
                        onPressed: () => controller.changePage(1),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.favorite,
                              color: Colors.grey,
                            ),
                            Text('Favorite',
                                style: TextStyle(color: Colors.grey))
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: MaterialButton(
                        onPressed: () => controller.changePage(2),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.lightbulb,
                              color: Colors.grey,
                            ),
                            Text('Learn', style: TextStyle(color: Colors.grey))
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: MaterialButton(
                        onPressed: () => controller.changePage(3),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.person,
                              color: Colors.grey,
                            ),
                            Text('Profile',
                                style: TextStyle(color: Colors.grey))
                          ],
                        ),
                      ),
                    ),
                  ]),
            )));
  }
}
