import 'package:firebase_auth/firebase_auth.dart';

import '../../models/users.model.dart';

abstract class AuthManagementState{}


class AuthenticationInit extends AuthManagementState{}


class Authenticated extends AuthManagementState{
  User? user;
  UserModel? userModel;
  Authenticated({required this.user,  this.userModel});
}
class NotAuthenticated extends AuthManagementState{}
class ErrorOnAuthenticatedChecking extends AuthManagementState{
  dynamic error;
  ErrorOnAuthenticatedChecking({this.error});
}