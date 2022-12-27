import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:modnsport/blocs/login/login.event.dart';
import 'package:modnsport/blocs/login/login.state.dart';
import 'package:modnsport/models/users.model.dart';
import 'package:modnsport/repositories/user/user.repository.dart';
import 'package:modnsport/repositories/user/user.repository.firebase.dart';

class LoginBloc extends Bloc<LoginEvent,LoginState>{

  UserRepositoryFirebase repositoryFirebase = GetIt.I.get<UserRepositoryFirebase>();
  LoginBloc(super.initialState){

    on<InitializeLogin>((event, emit) async{

      emit(InitLogin());
    });

    on<AuthenticatingUser>((event, emit)async {
      emit(UserAuthenticating());

      try{
         await repositoryFirebase.sigInUser(email: event.email, password: event.password);
         emit(InitLogin());
      }catch(e){
        emit(UserAuthenticatingFailed(error: e));
      }
    });


  }
}