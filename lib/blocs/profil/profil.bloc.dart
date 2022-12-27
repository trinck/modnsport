import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:modnsport/blocs/profil/profil.event.dart';
import 'package:modnsport/blocs/profil/profil.state.dart';
import 'package:modnsport/repositories/user/user.repository.dart';
import 'package:modnsport/repositories/user/user.repository.firebase.dart';

class ProfilBloc extends Bloc<ProfileEvent,ProfileState>{

  UserRepositoryFirebase repositoryFirebase =  GetIt.I.get<UserRepositoryFirebase>();
  ProfilBloc(super.initialState){



    on<LogOut>((event, emit)async{

       await repositoryFirebase.logOut();

    });

    on<DeleteAccount>((event, emit)async{

       await repositoryFirebase.deleteAccount();

    });

    on<UpdateDisplayName>((event, emit)async{
      emit(ProfileUpdating());
      var result = await repositoryFirebase.updateDisplayName(event.displayname);
      emit(ProfileUpdated(user: FirebaseAuth.instance.currentUser));
    });

    on<UpdateEmail>((event, emit)async{
      emit(ProfileUpdating());
      var result = await repositoryFirebase.updateEmail(event.email);
      emit(ProfileUpdated(user: FirebaseAuth.instance.currentUser));

    });

    on<UpdatePassword>((event, emit)async{

      emit(ProfileUpdating());
      var result = await repositoryFirebase.updatePassword(event.password);
      emit(ProfileUpdated(user: FirebaseAuth.instance.currentUser));

    });

    on<UpdatePhoto>((event, emit)async{
      emit(ProfileUpdating());
      await repositoryFirebase.updatePhoto(event.url);
      emit(ProfileUpdated(user: FirebaseAuth.instance.currentUser));

    });



    on<UpdateUser>((event, emit)async{

      emit(ProfileUpdated(user: event.user));

    });


  }


}