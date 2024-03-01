import 'package:firebase_core/firebase_core.dart';
import 'package:firstly/data/authentication_remote_data_source.dart';
import 'package:firstly/presintations/bloc/authentication_bloc.dart';
import 'package:firstly/presintations/screens/login_screen.dart';
import 'package:firstly/presintations/screens/signup_screen.dart';
import 'package:firstly/presintations/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<AuthenticationBloc>(
        create: (context) => AuthenticationBloc(AuthenticationRemoteDsImp()),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SignupScreen.id,
      routes: {
        SignupScreen.id: (context) => SignupScreen(),
        LoginScreen.id: (context) => LoginScreen(),
      },
    );
  }
}
