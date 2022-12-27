
import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:modnsport/blocs/authenticationstate/authstate.event.dart';

import '../../repositories/user/user.repository.dart';
import '../../repositories/user/user.repository.firebase.dart';
import 'authstate.state.dart';

class AuthStateBloc extends Bloc<AuthManagementEvent,AuthManagementState>{
  UserRepositoryFirebase repositoryFirebase =  GetIt.I.get<UserRepositoryFirebase>();

  AuthStateBloc(super.initialState){

    on<CheckAuthentication>((event, emit)async{
      emit(AuthenticationInit());
    });


    on<AuthenticatedEvent>((event, emit)async{
        emit(Authenticated(user: event.user));

    });

    on<NotAuthenticatedEvent>((event, emit)async{

      emit(NotAuthenticated());
    });

  }


}