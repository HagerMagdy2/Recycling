import 'package:firstly/constants.dart';
import 'package:firstly/presintations/screens/start/signup_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static String id = 'SplashScreen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToNextScreen();
  }

  void navigateToNextScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SignupScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          height: 100,
          width: 100,
          child: Image.asset(
            'assets/images/1.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
