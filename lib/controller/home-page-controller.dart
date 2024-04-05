import 'package:firstly/presintations/screens/home_screen.dart';
import 'package:firstly/presintations/screens/my-home.dart';
import 'package:firstly/presintations/screens/profile-screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class HomeController extends GetxController {
  changePage(int page);
}

class HomeControllerImp extends HomeController {
  int currentPage = 0;
  List<Widget> pagesList = [
    MyHomePage(),
    Column(
      children: [Center(child: Text("one"))],
    ),
    Column(
      children: [Center(child: Text("two"))],
    ),
    ProfileScreen()
  ];
  @override
  changePage(int page) {
    // TODO: implement changePage
    currentPage = page;
    update();
 }
}