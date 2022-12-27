import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modnsport/pages/login.page.dart';
import 'package:modnsport/pages/reload_email_verification.page.dart';
import 'package:modnsport/pages/sigin.page.dart';
import 'package:modnsport/pages/sigin_demo.page.dart';

import '../blocs/authenticationstate/authstate.bloc.dart';
import '../blocs/authenticationstate/authstate.state.dart';
import 'home.page.dart';

class Landing extends StatefulWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  Widget build(BuildContext context) {



    return  BlocBuilder<AuthStateBloc,AuthManagementState>(key: const Key("landing"),builder: (context, state) {


      if(state is AuthenticationInit){

        return  Scaffold(body: Center(child: Text("${FirebaseAuth.instance.currentUser?.emailVerified}"),),);
      }


      if (state is Authenticated) {

       if(FirebaseAuth.instance.currentUser!.emailVerified){
         return const Home();
       }
        return const ReloadEmailVerification();
      }

      return const Login();

    },);
  }
}
