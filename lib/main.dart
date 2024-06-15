import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firstly/constants.dart';
import 'package:firstly/data/authentication_remote_data_source.dart';

import 'package:firstly/data/remotDs/product_remote_data_source.dart';
import 'package:firstly/presintations/bloc/authentication_bloc.dart';
import 'package:firstly/presintations/bloc/cart_bloc.dart';

import 'package:firstly/presintations/bloc/products_bloc.dart';
import 'package:firstly/presintations/provider/adminMode.dart';
import 'package:firstly/presintations/screens/add-edit/edit-profile-screen.dart';
import 'package:firstly/presintations/screens/helpPage/help.dart';
import 'package:firstly/presintations/screens/home/my-product.dart';
import 'package:firstly/presintations/screens/start/login_screen.dart';
import 'package:firstly/presintations/screens/start/signup_screen.dart';
import 'package:firstly/presintations/screens/start/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) => AuthenticationBloc(AuthenticationRemoteDsImp()),
        ),
        BlocProvider<CartBloc>(
          create: (context) => CartBloc(ProductRemoteDsImp()),
        ),
        BlocProvider<ProductBloc>(
          create: (context) => ProductBloc(ProductRemoteDsImp()),
        ),
      ],
      child: EasyLocalization(
          fallbackLocale: Locale('ar'),
          child: const MyApp(),
          supportedLocales: [Locale('en'), Locale('ar')],
          path: 'assets/translations')));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AdminMode>(
      create: (context) => AdminMode(),
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        color: kMainColor,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: kSecondaryColor, primary: kMainColor),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: StartScreen.id,
        routes: {
          StartScreen.id: (context) => StartScreen(),
          SignupScreen.id: (context) => SignupScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          EditProfileScreen.id: (context) => EditProfileScreen(
                currentEmail: '',
                currentName: '',
              ),
          HelpScreen.id: (context) => HelpScreen(),
           '/myProduct': (context) => MyProduct(),
        },
      ),
    );
  }
}