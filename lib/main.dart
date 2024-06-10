import 'package:firebase_core/firebase_core.dart';
import 'package:firstly/constants.dart';
import 'package:firstly/data/authentication_remote_data_source.dart';
import 'package:firstly/data/remotDs/compost-remot-ds.dart';
import 'package:firstly/data/remotDs/oil_remot_ds.dart';
import 'package:firstly/data/remotDs/papers-remot-ds.dart';
import 'package:firstly/data/remotDs/plastic-remot-ds.dart';
import 'package:firstly/data/remotDs/product_remote_data_source.dart';
import 'package:firstly/presintations/bloc/authentication_bloc.dart';
import 'package:firstly/presintations/bloc/cart_bloc.dart';

import 'package:firstly/presintations/bloc/products_bloc.dart';
import 'package:firstly/presintations/provider/adminMode.dart';
import 'package:firstly/presintations/screens/start/login_screen.dart';
import 'package:firstly/presintations/screens/start/signup_screen.dart';
import 'package:firstly/presintations/screens/start/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Firebase.appCheck.installAppCheckProviderFactory(
  //     SafetyNetAppCheckProviderFactory.getInstance());
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
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AdminMode>(
      create: (context) => AdminMode(),
      child: MaterialApp(
        color: kMainColor,
        debugShowCheckedModeBanner: false,
        initialRoute: StartScreen.id,
        routes: {
          StartScreen.id: (context) => StartScreen(),
          SignupScreen.id: (context) => SignupScreen(),
          LoginScreen.id: (context) => LoginScreen(),
        },
      ),
    );
  }
}
