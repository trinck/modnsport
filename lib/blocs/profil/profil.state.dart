import 'package:firebase_auth/firebase_auth.dart';

class ProfileState{}
class ProfileInit extends ProfileState{}

class ProfileUpdating extends ProfileState{}

class ProfileUpdated extends ProfileState{
  User? user;
  ProfileUpdated({required this.user});
}

