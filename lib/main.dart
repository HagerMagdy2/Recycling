import 'package:firstly/screens/login_screen.dart';
import 'package:firstly/screens/signup_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
       initialRoute: LoginScreen.id,
       routes: {
         LoginScreen.id: (context) => LoginScreen(),
         SignupScreen.id:(context) => SignupScreen(),
       },
    );
  }
}
