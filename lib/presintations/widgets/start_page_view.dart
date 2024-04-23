import 'package:firstly/constants.dart';
import 'package:firstly/presintations/screens/start/login_screen.dart';
import 'package:firstly/presintations/screens/start/signup_screen.dart';
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
          height: 425,
          child: Lottie.asset('assets/images/Animation2.json'),
        ),
        SizedBox(
          height: 32,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              'Welcome ',
              style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: 50,
                  color: kMainColor1,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(23.0),
          child: Column(
            children: [
              Text(
                'We are Be Green, dedicated to fostering a greener world through recycling.',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Together, we can make a lasting impact.',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        )
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
          'Be part of the solution !',
          style: TextStyle(
              color: kMainColor1, fontSize: 30, fontWeight: FontWeight.w900),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Text(
                'Our mission is to inspire and empower individuals to make environmentally conscious choices.',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 10),
              Text(
                ' Start your recycling journey here..          ',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class Page4 extends StatelessWidget {
  const Page4({Key? key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            height: 400, // Adjusted height
            child: Lottie.asset('assets/images/Animation5.json'),
          ),
          SizedBox(height: 40), // Adjusted spacing
          Container(
            alignment: Alignment.center,
            child: Text(
              'Let\'s Start',
              style: TextStyle(
                  fontSize: 36,
                  color: kMainColor1,
                  fontWeight: FontWeight.w900),
            ),
          ),
          SizedBox(height: 60), // Adjusted spacing
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
          SizedBox(height: 20), // Adjusted spacing
          Container(
            width: 250,
            child: TextButton(
                style: TextButton.styleFrom(
                  surfaceTintColor: kMainColor,
                  side: BorderSide(width: 2, color: kMainColor),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, SignupScreen.id);
                },
                child: const Text(
                  'Create Account',
                  style: TextStyle(color: kMainColor, fontSize: 18),
                )),
          ),
          SizedBox(height: 40), // Adjusted spacing
        ],
      ),
    );
  }
}
