import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:modnsport/models/chat.model.dart';
import 'package:modnsport/models/users.model.dart';

abstract class UserRepositoryFirebase
{

  Future<UserCredential>sigInUser ({required String email, required String password});
  Future<UserCredential> createUser ({required String email,required String password});
  Future<UserModel> createUserModel ();
  Future<dynamic> logOut ();
  Future<UserModel> getUser({required String userID});
  Future<List<UserModel>> getUsersPage({int limit = 10,  String? key});
  Future<UserModel> getMyProfile();
  //Future<UserCredential>sigInWithGoogle();
  //Future<UserCredential>sigInWithFacebook();
  Future<bool> updateDisplayName(String displayname);
  Future<bool> updatePassword(String password);
  Future<bool> updatePhoto(String url);
  Future<void> deleteAccount();
  Future<bool> updateEmail(String email);
  Future<void> sendDm({required String uid, Chat? chat});
  Future<void> subDm({required String uid});
  Future<void> subRdm({required String uid});
  Future<Rdm> getRdm({required String uid});
  Future<List<Rdm>> getRdms([int limit = 10,  String? key]);
  Future<List<Rdm>> getRdmsWithChat([int limit = 10,  String? key]);
  Future<List<Follower>> getFollowersWithChat([int limit = 10,  String? key]);
  Future<List<Follower>> getFollowers([int limit = 10,  String? key]);
  Future<List<Dm>> getDms([int limit = 10, String? key]);
  Future<void> emailVerification();
  Future<Dm> getDm({required String uid});
  Future<void> acceptRdm({required String uid});
  Future presence();
  Future<void> onValue({required String userFieldPath, required StreamController streamController});
}