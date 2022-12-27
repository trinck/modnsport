import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:modnsport/blocs/login/login.state.dart';
import 'package:modnsport/blocs/sigin/sigin.event.dart';
import 'package:modnsport/blocs/sigin/sigin.state.dart';
import 'package:modnsport/repositories/user/user.repository.dart';
import 'package:modnsport/repositories/user/user.repository.firebase.dart';

import '../../models/users.model.dart';

class SigInBloc extends Bloc<SigInEvent, SigInState>{

  UserRepositoryFirebase repositoryFirebase = GetIt.I.get<UserRepositoryFirebase>();
  SigInBloc(super.initialState){

    on<InitializeSigIn>((event, emit)async {
      emit(InitSigIn());
    },);

    on<ResentEmailVerification>((event, emit)async {
      await repositoryFirebase.emailVerification();
    },);


    on<EmailChecking>((event, emit)async {
      emit(UserEmailChecking(email: "${event.email}"));
    },);

    on<CreatingUser>((event, emit)async {
      emit(UserCreating());

      try{
        var credential = await repositoryFirebase.createUser(email: event.email, password: event.password);

          await FirebaseAuth.instance.setLanguageCode("fr");
          await credential.user?.sendEmailVerification();
          emit(UserEmailChecking(email: "${credential.user?.email}"));

      }catch(e){
        emit(UserCreatingFailed(error: e));
      }

    });

    on<VerifiedEmail>((event, emit)async {
      emit(UserCreated(user: event.user));
      emit(InitSigIn());
    },);



  }

}