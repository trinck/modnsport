
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/users.model.dart';

abstract class SigInState{}

class InitSigIn extends SigInState{}

class UserCreated extends SigInState{
  User? user;
  UserModel? userModel;
  UserCreated({ required this.user});
}


class UserCreating extends SigInState{

}
class UserEmailChecking extends SigInState{
  String email;
  UserEmailChecking({required this.email});
}


class UserCreatingFailed extends SigInState{
  dynamic error;
  UserCreatingFailed({required this.error});
  dynamic get errorMap{return error;}
}
