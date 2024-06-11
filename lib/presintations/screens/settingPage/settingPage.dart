import 'dart:ui';

import 'package:firstly/presintations/screens/home/cart-page.dart';
import 'package:firstly/presintations/screens/home/home_screen.dart';
import 'package:firstly/presintations/screens/start/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';
import '../../bloc/authentication_bloc.dart';
import '../../widgets/setting.dart';
import '../add-edit/edit-profile-screen.dart';
import '../helpPage/help.dart';
import '../home/favorite_screen.dart';
import '../home/profile-screen.dart';
import '../start/login_screen.dart';

class settingPage extends StatefulWidget {
  const settingPage({super.key});
  static String id = 'settingPage';

  @override
  State<settingPage> createState() => _settingPageState();
}

class _settingPageState extends State<settingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Center(
              child: Text(
                'Setting',
                style: TextStyle(
                  fontSize: 50,
                  color: kMainColor1,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          MenuPage(
              fun: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
              color: Colors.orange,
              icon: Icons.person,
              text: 'Profile',
              context: context),
          MenuPage(
              fun: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen(index: 1,)),
                );
              },
              color: Colors.blue,
              icon: Icons.favorite,
              text: 'Favorites',
              context: context),
          MenuPage(
              fun: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartPage()),
                );
              },
              color: Colors.pink,
              icon: Icons.payments_outlined,
              text: 'Payment',
              context: context),
          MenuPage(
              color: Colors.purple,
              icon: Icons.edit_note_outlined,
              text: 'Edit Personal Data',
              fun: () {
                Navigator.pushNamed(context, EditProfileScreen.id);
              },
              context: context),
          MenuPage(
              color: Colors.teal,
              icon: Icons.help_outline_outlined,
              text: 'Help',
              fun: () {
                Navigator.pushNamed(context, HelpScreen.id);
              },
              context: context),
          MenuPage(
              color: Colors.red,
              icon: Icons.logout,
              text: 'LogOut',
              fun: () {
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
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("No",
                                          style: TextStyle(color: kMainColor))),
                                  const Spacer(),
                                  TextButton(
                                    onPressed: () {
                                      context
                                          .read<AuthenticationBloc>()
                                          .add(SignOutEvent());
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SignupScreen()),
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
                    });
              },
              context: context),
        ],
      ),
    );
  }
}
