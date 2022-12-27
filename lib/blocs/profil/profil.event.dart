import 'package:firebase_auth/firebase_auth.dart';

class ProfileEvent{}


class UpdateUser extends ProfileEvent{

  User user;
  UpdateUser({required this.user});
}



class UpdateEmail extends ProfileEvent{
  final String email;

  UpdateEmail({required this.email});
}

class UpdatePassword extends ProfileEvent{
  final String password;

  UpdatePassword({required this.password});
}

class UpdateDisplayName extends ProfileEvent{
  final String displayname;
  UpdateDisplayName({required this.displayname});
}

class UpdatePhoto extends ProfileEvent{
  final String url;
  UpdatePhoto({required this.url});
}



class LogOut extends ProfileEvent{}
class DeleteAccount extends ProfileEvent{}

class ListeningDisconnected extends ProfileEvent{}

