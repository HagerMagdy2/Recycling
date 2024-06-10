import 'package:firstly/constants.dart';
import 'package:firstly/presintations/bloc/authentication_bloc.dart';
import 'package:firstly/presintations/screens/home/favorite_screen.dart';
import 'package:firstly/presintations/screens/home/home_screen.dart';
import 'package:firstly/presintations/screens/home/profile-screen.dart';
import 'package:firstly/presintations/screens/start/login_screen.dart';
import 'package:firstly/presintations/screens/start/signup_screen.dart';
import 'package:firstly/presintations/screens/settingPage/settingPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppDrawer extends StatelessWidget {
  static String id = 'AppDrawer';
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
        child: ListView(
          children: [
            Container(
              color:kMainColor,
              width: double.infinity,
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Center(
                  child: Text('Be Green',
                  style: TextStyle(
                    fontFamily: 'RobotoMono',
                    fontSize: 50,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                      ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: const Icon(Icons.account_circle,
                    color: kMainColor),
                title: const Text("Profile",
                  style: TextStyle(
                    fontSize: 20,
                    color: kMainColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, ProfileScreen.id);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: const Icon(Icons.language,
                    color: kMainColor),
                title: const Text("Language",
                  style: TextStyle(
                    fontSize: 20,
                    color: kMainColor,
                    fontWeight: FontWeight.bold,
                  ),),
                onTap: () {
                  //Navigator.pushNamed(context, SignupScreen.id);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: const Icon(Icons.settings,
                    color: kMainColor),
                title: const Text("Settings",
                  style: TextStyle(
                    fontSize: 20,
                    color: kMainColor,
                    fontWeight: FontWeight.bold,
                  ),),
                onTap: () {
                  Navigator.pushNamed(context, settingPage.id);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: const Icon(Icons.help_outline,
                    color: kMainColor),
                title: const Text("About Us",
                  style: TextStyle(
                    fontSize: 20,
                    color: kMainColor,
                    fontWeight: FontWeight.bold,
                  ),),
                onTap: () {
                 // Navigator.pushNamed(context, settingPage.id);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: const Icon(Icons.logout,
                color: kMainColor),
                title: const Text("Logout",
                  style: TextStyle(
                    fontSize: 20,
                    color: kMainColor,
                    fontWeight: FontWeight.bold,
                  ),),
                onTap: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
              ),
            ),
          ],
        )
    );
  }
}
