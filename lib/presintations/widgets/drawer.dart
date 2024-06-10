import 'package:easy_localization/easy_localization.dart';
import 'package:firstly/constants.dart';
import 'package:firstly/presintations/bloc/authentication_bloc.dart';
import 'package:firstly/presintations/screens/home/about_us.dart';
import 'package:firstly/presintations/screens/start/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppDrawer extends StatefulWidget {
  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: kSecondaryColor,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.22,
                child: const Stack(
                  alignment: Alignment.center,
                  children: [
                    Text(
                      'Be',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 50,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 70),
                      child: Text(
                        'Green',
                        style: TextStyle(
                            fontSize: 50,
                            color: kMainColor,
                            fontWeight: FontWeight.w900),
                      ),
                    )
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<AuthenticationBloc>().add(SignOutEvent());
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SignupScreen()),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: kMainColor),
              child: Text(
                tr('Log Out'),
                style: TextStyle(color: kSecondaryColor),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutUsScreen()),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: kMainColor),
              child: Text(
                tr('About Us'),
                style: TextStyle(color: kSecondaryColor),
              ),
            ),
            SizedBox(
              height: 310,
            ),
            Text(
              tr('Languages'),
              style: TextStyle(
                  color: kMainColor, fontWeight: FontWeight.bold, fontSize: 30),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: kMainColor),
                onPressed: () async {
                  context.setLocale(Locale("ar"));
                  setState(() {});
                },
                child: Text(
                  tr('Arabic'),
                  style: TextStyle(color: kSecondaryColor),
                )),
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: kMainColor),
                onPressed: () async {
                  context.setLocale(Locale("en"));
                  setState(() {});
                },
                child: Text(
                  tr('English'),
                  style: TextStyle(color: kSecondaryColor),
                )),
          ],
        ),
      ),
    );
  }
}
