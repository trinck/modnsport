import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modnsport/pages/sigin.page.dart';

import '../blocs/authenticationstate/authstate.bloc.dart';
import '../blocs/authenticationstate/authstate.state.dart';
import 'demo.widget.dart';

class SigInDemo extends StatefulWidget {
  const SigInDemo({Key? key}) : super(key: key);

  @override
  State<SigInDemo> createState() => _SigInDemoState();
}

class _SigInDemoState extends State<SigInDemo> {
  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<AuthStateBloc,AuthManagementState>(builder: (context, state){

      if (state is Authenticated && FirebaseAuth.instance.currentUser!.emailVerified){

        return const Demo();
      }
      return const SigIn();



    },);
  }
}
