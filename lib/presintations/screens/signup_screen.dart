import 'package:firstly/presintations/bloc/authentication_bloc.dart';
import 'package:firstly/presintations/screens/login_screen.dart';
import 'package:firstly/presintations/screens/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants.dart';
import '../widgets/custom_textfield.dart';

class SignupScreen extends StatefulWidget {
  static String id = 'SignupScreen';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
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
                MaterialPageRoute(builder: (_) => const StartScreen()));
          }
        },
        builder: (context, state) {
          print(state);
          return Form(
            key: _globalKey,
            child: ListView(
              children: [
                if (state is AuthLoding) const CircularProgressIndicator(),
                if (state is AuthError) const Text('Error'),
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
                SizedBox(
                  height: height * 0.1,
                ),
                CustomTextField(
                    hint: 'Enter your name', icon: Icons.perm_identity),
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
                  height: height * 0.05,
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
                                email: EmailC.text, password: PasswordC.text));
                          }
                        },
                        child: const Text(
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
