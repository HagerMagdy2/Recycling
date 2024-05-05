import 'package:firebase_core/firebase_core.dart';
import 'package:firstly/constants.dart';
import 'package:firstly/data/authentication_remote_data_source.dart';
import 'package:firstly/data/remotDs/compost-remot-ds.dart';
import 'package:firstly/data/remotDs/oil_remot_ds.dart';
import 'package:firstly/data/remotDs/papers-remot-ds.dart';
import 'package:firstly/data/remotDs/plastic-remot-ds.dart';
import 'package:firstly/data/remotDs/product_remote_data_source.dart';
import 'package:firstly/presintations/bloc/authentication_bloc.dart';
import 'package:firstly/presintations/bloc/compost_bloc.dart';
import 'package:firstly/presintations/bloc/oils_bloc.dart';
import 'package:firstly/presintations/bloc/papers_bloc.dart';
import 'package:firstly/presintations/bloc/plastic_bloc.dart';
import 'package:firstly/presintations/bloc/products_bloc.dart';
import 'package:firstly/presintations/screens/payment/paypal.dart';
import 'package:firstly/presintations/screens/start/login_screen.dart';
import 'package:firstly/presintations/screens/start/signup_screen.dart';
import 'package:firstly/presintations/screens/start/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:flutter_stripe/flutter_stripe.dart';

import 'package:provider/provider.dart';


void main() async {
//   Stripe.publishableKey=ApiKeys.pusblishableKey;
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  runApp(MultiBlocProvider(
    providers: [  
      BlocProvider<AuthenticationBloc>(
        create: (context) => AuthenticationBloc(AuthenticationRemoteDsImp()),
      ),
      BlocProvider<PlasticBloc>(
        create: (context) => PlasticBloc(PlasticRemoteDsImp()),
      ),
      BlocProvider<ProductBloc>(
        create: (context) => ProductBloc(ProductRemoteDsImp()),
      ),
      BlocProvider<CompostBloc>(
        create: (context) => CompostBloc(CompostRemoteDsImp()),
      ),
      BlocProvider<PapersBloc>(
        create: (context) => PapersBloc(PapersRemoteDsImp()),
      ),
      BlocProvider<OilsBloc>(
        create: (context) => OilsBloc(OilRemoteDsImp()),
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
       initialRoute: StartScreen.id,
      //initialRoute: CheckoutPage.id,
      //initialRoute: CustomRadioButton.id,
      routes: {
        StartScreen.id: (context) => StartScreen(),
        SignupScreen.id: (context) => SignupScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        // HomeScreen.id: (context) => HomeScreen(),
      //  CheckoutPage.id: (context) => CheckoutPage(),
      },
    );
  }
}