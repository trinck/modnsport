import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modnsport/blocs/authenticationstate/authstate.bloc.dart';
import 'package:modnsport/pages/home.page.dart';
import 'package:modnsport/pages/login.page.dart';
import 'package:modnsport/pages/profil.page.dart';
import 'package:modnsport/pages/program.page.dart';
import 'package:modnsport/pages/reload_email_verification.page.dart';
import 'package:modnsport/pages/sigin.page.dart';
import 'package:modnsport/pages/sigin_demo.page.dart';
import 'package:modnsport/pages/stats.page.dart';
import 'package:modnsport/pages/unknown.page.dart';
import 'package:modnsport/widget/siginform.widget.dart';

import '../blocs/authenticationstate/authstate.event.dart';
import '../blocs/authenticationstate/authstate.state.dart';
import '../blocs/demo/demo.bloc.dart';
import '../blocs/demo/demo.event.dart';
import '../blocs/login/login.bloc.dart';
import '../blocs/login/login.event.dart';
import '../blocs/sigin/sigin.bloc.dart';
import '../blocs/sigin/sigin.event.dart';
import '../blocs/sigin/sigin.state.dart';
import '../utils/utils.dart';
import 'activity.page.dart';
import 'landing.page.dart';

class Root extends StatefulWidget {
  const Root({Key? key}) : super(key: key);

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {


  @override
  Widget build(BuildContext context) {
    //check authentication

    return MaterialApp(
        title: "modnsport",
      routes: {
        "login":(context) =>const Login(),
        "home":(context) =>const Home(),
        "sigIn":(context) => const SigIn(),
        "landing":(context) => const Landing(),
        "sigin_demo":(context) => const SigInDemo(),
        "emailVerification":(context) => const ReloadEmailVerification(),
        "activity":(context) => const ActivityPage(),
        "program":(context) => const ProgramPage(),
        "stats":(context) => const StatsPage(),

      },
      initialRoute: "profile",
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) {
          if(settings.name == "profile"){
            return PageTransitionUtils.scaleTransitionUtils(child: const Profile(), curveTarget: Curves.easeIn,duration: const Duration(seconds: 1));
          }
          return PageTransitionUtils.scaleTransitionUtils(child:  UnknownPage(name: settings.name,), curveTarget: Curves.linear,duration: const Duration(milliseconds: 100));


      },

    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AuthCheckingUtils.checkAuth(context);
    AuthCheckingUtils.checkValidationEmail(context);
    //checkValidationEmail();
    //checkAuth();
  }

}
