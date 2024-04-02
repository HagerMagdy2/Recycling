import 'package:firstly/constants.dart';
import 'package:firstly/presintations/bloc/authentication_bloc.dart';
import 'package:firstly/presintations/provider/adminMode.dart';
import 'package:firstly/presintations/screens/signup_screen.dart';
import 'package:firstly/presintations/screens/home_screen.dart';
import 'package:firstly/presintations/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'LoginScreen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  TextEditingController EmailC = TextEditingController();
  TextEditingController PasswordC = TextEditingController();
  bool isAdmin = false;

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
          return Form(
            key: _globalKey,
            child: ListView(
              children: [
                if (state is AuthLoding) const CircularProgressIndicator(),
                if (state is AuthError) const Text('Error'),
                Padding(
                  padding: const EdgeInsets.only(top: 45),
                  child: SizedBox(
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
                        if (_globalKey.currentState!.validate()) {
                          context.read<AuthenticationBloc>().add(SignInEvent(
                                email: EmailC.text,
                                password: PasswordC.text,
                              ));
                          if (state is UnAuthorized)
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                title: const Text('Sign Up Required'),
                                content: const Text(
                                  'Please sign up first before logging in.',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text(
                                      'OK',
                                      style: TextStyle(color: kMainColor),
                                    ),
                                  ),
                                ],
                              ),
                            );
                        }
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account ? ',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, SignupScreen.id);
                        },
                        child: const Text(
                          'Signup',
                          style: TextStyle(
                              fontSize: 16,
                              color: kMainColor,
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                )
              ],
            ),
          );
        },
      ),
    ));
  }
}
