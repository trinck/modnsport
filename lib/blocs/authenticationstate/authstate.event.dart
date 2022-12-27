import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthManagementEvent{}
class CheckAuthentication extends AuthManagementEvent{}
class AuthenticatedEvent extends AuthManagementEvent{
  User? user;
  AuthenticatedEvent({this.user});
}
class NotAuthenticatedEvent extends AuthManagementEvent{}