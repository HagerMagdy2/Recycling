import 'package:firstly/presintations/bloc/authentication_bloc.dart';
import 'package:firstly/presintations/screens/home/home_screen.dart';
import 'package:firstly/presintations/screens/start/start_screen.dart';
import 'package:firstly/presintations/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AuthenticationBloc>(context);
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is Authorized) {
          return SplashScreen();
        } else if (state is UnAuthorized) {
          return StartScreen();
        } else {
          return StartScreen();
        }
      },
    );
  }
}
