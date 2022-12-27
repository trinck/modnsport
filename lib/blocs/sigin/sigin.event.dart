import 'package:firebase_auth/firebase_auth.dart';

import '../../models/users.model.dart';

abstract class SigInEvent{}

class InitializeSigIn extends SigInEvent{}
class EmailChecking extends SigInEvent{
  String? email;
  EmailChecking({this.email});
}
class ResentEmailVerification extends SigInEvent{}
class VerifiedEmail extends SigInEvent{
  User? user;
  UserModel? userModel;
  VerifiedEmail({ required this.user});
}
class CreatingUser extends SigInEvent{
  String email;
  String password;
  CreatingUser({required this.email,required this.password});

}
