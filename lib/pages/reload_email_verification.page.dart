import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modnsport/blocs/profil/profil.bloc.dart';
import '../blocs/profil/profil.event.dart';
import '../blocs/sigin/sigin.bloc.dart';
import '../blocs/sigin/sigin.event.dart';

class ReloadEmailVerification extends StatelessWidget {
  const ReloadEmailVerification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Card(margin: EdgeInsets.symmetric(horizontal: 10),
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [ const Icon(Icons.info), const SizedBox(width: 5,), Expanded(child: Text("An email verification was sent to ${FirebaseAuth.instance.currentUser?.email}",overflow: TextOverflow.clip)) ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    MaterialButton(child:  Text("Abort",style: TextStyle(color: Theme.of(context).primaryColor),),onPressed: () => context.read<ProfilBloc>().add(DeleteAccount()),),
                    MaterialButton(child:  Text("Resent",style: TextStyle(color: Theme.of(context).primaryColor),),onPressed: () => context.read<SigInBloc>().add(ResentEmailVerification()),),
                  ],
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
