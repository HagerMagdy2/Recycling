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
import 'package:firstly/presintations/provider/adminMode.dart';
import 'package:firstly/presintations/screens/add-edit/edit-profile-screen.dart';
import 'package:firstly/presintations/screens/helpPage/help.dart';
import 'package:firstly/presintations/screens/home/favorite_screen.dart';
import 'package:firstly/presintations/screens/home/profile-screen.dart';
import 'package:firstly/presintations/screens/settingPage/settingPage.dart';
import 'package:firstly/presintations/screens/start/login_screen.dart';
import 'package:firstly/presintations/screens/start/signup_screen.dart';
import 'package:firstly/presintations/screens/start/start_screen.dart';
import 'package:firstly/presintations/widgets/drawer.dart';
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
    return ChangeNotifierProvider<AdminMode>(
      create: (context) => AdminMode(),
      child: MaterialApp(
        color: kMainColor,
        debugShowCheckedModeBanner: false,
        initialRoute: AppDrawer.id,
        routes: {
          StartScreen.id: (context) => StartScreen(),
          SignupScreen.id: (context) => SignupScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          AppDrawer.id: (context) => AppDrawer(),
          ProfileScreen.id: (context) => ProfileScreen(),
          settingPage.id: (context) => settingPage(),
          HelpScreen.id: (context) => HelpScreen(),
          FavoriteScreen.id: (context) => FavoriteScreen(),
          EditProfileScreen.id: (context) => EditProfileScreen(currentEmail: '', currentName: '',),
        },
      ),
    );
  }
}
