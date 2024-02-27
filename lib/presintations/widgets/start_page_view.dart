import 'package:firstly/constants.dart';
import 'package:firstly/presintations/screens/login_screen.dart';
import 'package:firstly/presintations/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.center,
          height: 500,
          child: Lottie.asset('assets/images/Animation2.json'),
        ),
        Text(
          'welcome to be green ',
          style: TextStyle(
              color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text(
          'we are HAM!! ',
          textAlign: TextAlign.left,
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: 500,
          child: Lottie.asset('assets/images/Animation3.json'),
        ),
        Text(
          'Bknlnefknklfnekl b v   fnlkfe',
          style: TextStyle(
              color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class Page4 extends StatelessWidget {
  const Page4({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: 500,
          child: Lottie.asset('assets/images/Animation5.json'),
        ),
        Container(
          alignment: Alignment.center,
          child: Text(
            'Let\'s Start',
            style: TextStyle(
                fontSize: 50, color: kMainColor1, fontWeight: FontWeight.w900),
          ),
        ),
        SizedBox(
          height: 120,
        ),
        Container(
          width: 250,
          child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: kMainColor,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
              child: const Text(
                'Sign In',
                style: TextStyle(color: Colors.white, fontSize: 18),
              )),
        ),
        Container(
          width: 250,
          child: TextButton(
              style: TextButton.styleFrom(
                surfaceTintColor: kMainColor,
                side: BorderSide(width: 2, color: kMainColor),
                //   backgroundColor: kMainColor,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, SignupScreen.id);
              },
              child: const Text(
                'Creat Account',
                style: TextStyle(color: kMainColor, fontSize: 18),
              )),
        ),
      ],
    );
  }
}
