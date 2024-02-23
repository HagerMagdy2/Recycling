import 'package:firstly/screens/login_screen.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../widgets/custom_textfield.dart';

class SignupScreen extends StatelessWidget {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  static String id = 'SignupScreen';

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        
        body: Form(
          key: _globalKey,
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 50),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.22,
                  child: Stack(
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
              SizedBox(
                height: height * 0.1,
              ),
              CustomTextField(
                  hint: 'Enter your name', icon: Icons.perm_identity),
              SizedBox(
                height: height * 0.02,
              ),
              CustomTextField(hint: 'Enter your email', icon: Icons.email),
              SizedBox(
                height: height * 0.02,
              ),
              CustomTextField(hint: 'Enter your password', icon: Icons.lock),
              SizedBox(
                height: height * 0.05,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 120),
                child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: kMainColor,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                    onPressed: () {
                      _globalKey.currentState!.validate();
                    },
                    child: Text(
                      'Sign up',
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Do have an account ? ',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, LoginScreen.id);
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 16,color: kMainColor,fontWeight:FontWeight.bold),
                      ))
                ],
              )
            ],
          ),
        ));
  }
}
