import 'package:firebase_auth/firebase_auth.dart';

import '../../models/users.model.dart';

class LoginState {
}

class InitLogin extends LoginState{}

class UserAuthenticated extends LoginState{
  User? user;
  UserModel ?userModel;
  UserAuthenticated({ required this.user, this.userModel});
}

class UserAuthenticating extends LoginState{

}


class UserAuthenticatingFailed extends LoginState{

  dynamic error;
  UserAuthenticatingFailed({required this.error});
  dynamic get errorMap{return error;}
}
