import 'dart:ui';
import 'package:firstly/presintations/screens/home/languages_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firstly/constants.dart';
import 'package:firstly/presintations/bloc/authentication_bloc.dart';
import 'package:firstly/presintations/screens/home/about_us.dart';
import 'package:firstly/presintations/screens/home/profile-screen.dart';
import 'package:firstly/presintations/screens/start/signup_screen.dart';
import 'package:firstly/presintations/screens/settingPage/settingPage.dart';

class AppDrawer extends StatelessWidget {
  static String id = 'AppDrawer';

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    gradient: kMainColorGradient,
                    borderRadius: BorderRadius.circular(20)),
                width: double.infinity,
                height: 200,
              ),
              Positioned(
                //bottom: 35,
                //  left: 100,
                child: Transform.rotate(
                  angle: 0.0,
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 250,
                    height: 250,
                    color: Colors.white,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 55),
                child: Text(
                  'Be',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 100),
                child: Text(
                  'Green',
                  style: TextStyle(
                    fontSize: 50,
                    color: kMainColor,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(Icons.account_circle, color: kMainColor),
              title: const Text(
                "Profile",
                style: TextStyle(
                  fontSize: 20,
                  color: kMainColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(Icons.language, color: kMainColor),
              title: const Text(
                "Language",
                style: TextStyle(
                  fontSize: 20,
                  color: kMainColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LanguagePage()),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(Icons.settings, color: kMainColor),
              title: const Text(
                "Settings",
                style: TextStyle(
                  fontSize: 20,
                  color: kMainColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => settingPage()),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(Icons.help_outline, color: kMainColor),
              title: const Text(
                "About Us",
                style: TextStyle(
                  fontSize: 20,
                  color: kMainColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutUsScreen()),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(Icons.logout, color: kMainColor),
              title: Text(
                tr('Log Out'),
                style: TextStyle(
                  fontSize: 20,
                  color: kMainColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                // Show confirmation dialog on log out button press
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return BackdropFilter(
                      filter: ImageFilter.blur(sigmaY: 6, sigmaX: 6),
                      child: AlertDialog(
                        title: Row(
                          children: [
                            Text('LogOut'),
                            SizedBox(
                              height: 15,
                            ),
                            Icon(
                              Icons.logout,
                              size: 20,
                            )
                          ],
                        ),
                        content: Text("Are you sure ?"),
                        actions: <Widget>[
                          Container(
                            child: Row(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Close dialog
                                  },
                                  child: Text("No",
                                      style: TextStyle(color: kMainColor)),
                                ),
                                const Spacer(),
                                TextButton(
                                  onPressed: () {
                                    context
                                        .read<AuthenticationBloc>()
                                        .add(SignOutEvent());
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignupScreen()),
                                    );
                                  },
                                  child: Text("Yes",
                                      style: TextStyle(color: kMainColor)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
