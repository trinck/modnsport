import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginEvent{}


class InitializeLogin extends LoginEvent{}
class AuthenticatingUser extends LoginEvent{
  String email;
  String password;
  AuthenticatingUser({required this.email,required this.password});

}





//class CreatingSucceed extends UserEvent{}

