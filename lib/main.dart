import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modnsport/blocs/login/login.bloc.dart';
import 'package:modnsport/blocs/login/login.state.dart';
import 'package:modnsport/blocs/profil/profil.bloc.dart';
import 'package:modnsport/blocs/profil/profil.state.dart';
import 'package:modnsport/blocs/sigin/sigin.bloc.dart';
import 'package:modnsport/blocs/sigin/sigin.state.dart';
import 'package:modnsport/firebase_options.dart';
import 'package:modnsport/pages/root.page.dart';
import "utils/injection.dart" as injection;
import 'blocs/authenticationstate/authstate.bloc.dart';
import 'blocs/authenticationstate/authstate.state.dart';
import 'blocs/demo/demo.bloc.dart';
import 'blocs/demo/demo.state.dart';
void main() async{

      /*****initialisation de firebase**********
      * **********************************
      * ************************************/
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
       );


      /**injection de dépendences**********
      * **********************************
      * **********************************/
       await injection.registerDependence();
      /***********************************
       * **********run app************************
       * **********************************/
         runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [

        BlocProvider(create: (context)  {
           return ProfilBloc(ProfileInit());
        }),

        BlocProvider(
          create: (context) {
            return LoginBloc(InitLogin());
          }),

        BlocProvider(
          create: (context) =>SigInBloc(InitSigIn())
        ),

        BlocProvider(
          create: (context) =>DemoBloc( InitDemos())
        ),

        BlocProvider(
          create: (context) =>AuthStateBloc(AuthenticationInit())
        ),

      ],
      child:const Root()
    );
  }



}
