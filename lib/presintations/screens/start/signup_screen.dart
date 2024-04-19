// ignore_for_file: avoid_print

import 'package:firstly/presintations/bloc/authentication_bloc.dart';
import 'package:firstly/presintations/screens/start/login_screen.dart';
import 'package:firstly/presintations/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../constants.dart';
import '../../widgets/custom_textfield.dart';

class SignupScreen extends StatefulWidget {
  static String id = 'SignupScreen';

  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  TextEditingController NameC = TextEditingController();
  TextEditingController EmailC = TextEditingController();
  TextEditingController PasswordC = TextEditingController();

  @override
  void initState() {
    context.read<AuthenticationBloc>().add(IsSignedInEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is Authorized) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const HomeScreen()));
          }
        },
        builder: (context, state) {
          print(state);
          return Form(
            key: _globalKey,
            child: ListView(
              children: [
                if (state is AuthLoding)
                  Lottie.asset(
                    'assets/images/Animation loading1.json',
                    height: 200,
                    width: 200,
                    repeat: true,
                  ),
                if (state is AuthError) const Text('Error'),
                Padding(
                  padding: const EdgeInsets.only(top: 45),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.32,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 70),
                          child: Container(
                            // color: Colors.amber,
                            height: 200,
                            width: 300,
                            child: Image.asset(
                              "assets/images/Mobile login2.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 155),
                          child: Text(
                            'Be',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 50,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 210),
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
                    controller: NameC,
                    hint: 'Enter your name',
                    icon: Icons.perm_identity),
                SizedBox(
                  height: height * 0.02,
                ),
                CustomTextField(
                  controller: EmailC,
                  hint: 'Enter your email',
                  icon: Icons.email,
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                CustomTextField(
                  controller: PasswordC,
                  hint: 'Enter your password',
                  icon: Icons.lock,
                ),
                SizedBox(
                  height: 10,
                ),
                if (state is UnAuthorized)
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
                          if (_globalKey.currentState!.validate()) {
                            context.read<AuthenticationBloc>().add(SignUpEvent(
                                  email: EmailC.text,
                                  password: PasswordC.text,
                                  name: NameC.text,
                                ));
                          }
                        },
                        child: const Text(
                          'Sign up',
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'SignUp ',
                          style: TextStyle(
                              fontSize: 16,
                              color: kMainColor,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'with others',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            context
                                .read<AuthenticationBloc>()
                                .add(SignInWithGoogleEvent());
                          },
                          child: CircleAvatar(
                            backgroundColor: kSecondaryColor,
                            radius: 25,
                            backgroundImage:
                                AssetImage("assets/images/google.png"),
                          ),
                        ),
                        SizedBox(width: 20),
                        InkWell(
                          onTap: () {
                            context
                                .read<AuthenticationBloc>()
                                .add(signInWithFacebookEvent());
                          },
                          child: CircleAvatar(
                            radius: 25,
                            backgroundImage:
                                AssetImage("assets/images/facebook.png"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Do have an account ? ',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, LoginScreen.id);
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 16,
                              color: kMainColor,
                              fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    ));
  }
}
