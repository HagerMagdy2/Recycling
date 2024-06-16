import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firstly/constants.dart';
import 'package:firstly/presintations/bloc/authentication_bloc.dart';
import 'package:firstly/presintations/provider/adminMode.dart';
import 'package:firstly/presintations/screens/start/signup_screen.dart';
import 'package:firstly/presintations/screens/home/home_screen.dart';
import 'package:firstly/presintations/widgets/custom_textfield.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'LoginScreen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  TextEditingController EmailC = TextEditingController();
  TextEditingController PasswordC = TextEditingController();
  bool isAdmin = false;
  bool isPasswordIncorrect = false;

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
                MaterialPageRoute(builder: (_) => const HomeScreen()),
              );
            } else if (state is AuthError) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(tr('Error')),
                  content: Text(
                      tr('No account exists with this email. Please sign up first.')),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(tr('OK')),
                    ),
                  ],
                ),
              );
            }
          },
          builder: (context, state) {
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
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.32,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 70),
                            child: Container(
                              height: 200,
                              width: 300,
                              child: Image.asset(
                                "assets/images/Mobile login2.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 155),
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
                            padding: EdgeInsets.only(top: 210),
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
                    ),
                  ),
                  SizedBox(
                    height: height * 0.1,
                  ),
                  CustomTextField(
                    controller: EmailC,
                    hint: tr('Enter your email'),
                    icon: Icons.email,
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  CustomTextField(
                    controller: PasswordC,
                    hint: tr('Enter your password'),
                    icon: Icons.lock,
                    showPasswordToggle: true, // Enable the toggle for password
                  ),
                  Visibility(
                    visible: isPasswordIncorrect,
                    child:  Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Row(
                          children: [
                            Icon(
                              Icons.error_outline,
                              color: Colors.red,
                            ),
                            SizedBox(width: 5),
                            Text(
                            tr('Incorrect password'),
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
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
                      onPressed: () async {
                        if (_globalKey.currentState!.validate()) {
                          bool isPasswordCorrect = await _checkPassword(
                            EmailC.text,
                            PasswordC.text,
                          );

                          if (isPasswordCorrect) {
                            context.read<AuthenticationBloc>().add(SignInEvent(
                                  email: EmailC.text,
                                  password: PasswordC.text,
                                ));
                          } else {
                            setState(() {
                              isPasswordIncorrect = true;
                            });
                          }
                        }
                      },
                      child:  Text(
                        tr('Login'),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
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
                        child: const CircleAvatar(
                          backgroundColor: kSecondaryColor,
                          radius: 25,
                          backgroundImage:
                              AssetImage("assets/images/google.png"),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          context
                              .read<AuthenticationBloc>()
                              .add(signInWithFacebookEvent());
                        },
                        child: const CircleAvatar(
                          radius: 25,
                          backgroundImage:
                              AssetImage("assets/images/facebook.png"),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Text(
                        tr('Don\'t have an account ? '),
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, SignupScreen.id);
                        },
                        child:  Text(
                          tr('Signup'),
                          style: TextStyle(
                            fontSize: 16,
                            color: kMainColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<bool> _checkPassword(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      print('Error: $e');
      return false;
    }
  }
}