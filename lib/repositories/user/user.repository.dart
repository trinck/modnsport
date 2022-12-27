



import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:modnsport/models/chat.model.dart';
import 'package:modnsport/models/users.model.dart';
import 'package:modnsport/repositories/user/user.repository.firebase.dart';
import 'package:modnsport/utils/fierebase.covertomap.dart';

class UserRepository extends UserRepositoryFirebase
{

  @override
  Future<UserCredential> sigInUser({required String email, required String password}) async {

    try {

      final  UserCredential   credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
          email: email.trim(),
          password: password.trim(),
        );

      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return throw({
          'error': 'No user found for that email.',
          'field': 'email'
        });
      } else if (e.code == 'wrong-password') {
        return throw({
          'error': 'Wrong password provided for that user.',
          'field': 'password'
        });
      }
    } catch (e) {
      return throw({'error': '$e', 'field': 'none'});
    }
    return Future(() => throw({'error': 'unknown', 'field': 'none'}));
  }

  @override
  Future<UserCredential> createUser({required String email, required String password}) async {

    try {

         UserCredential  credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: email.trim(),
          password: password.trim(),
        );


      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return throw({
          'error': 'The password provided is too weak',
          'field': 'password'
        });
      } else if (e.code == 'email-already-in-use') {
        return throw({
          'error': 'email-already-in-use',
          'field': 'email'});
      }else { return throw({
        'error': e,
        'field': 'anywhere'});}
    } catch (e) {
      return throw({
        'error': e,
        'field': 'none'});
    }

  }

  @override
  Future logOut() async {
    return await FirebaseAuth.instance.signOut();
  }

  @override
  Future<bool> updateDisplayName(String displayname)async {

    bool exists = FirebaseAuth.instance.currentUser == null;
    if(!exists) {
      await FirebaseAuth.instance.currentUser?.updateDisplayName(displayname);
     await FirebaseDatabase.instance.ref("users/${FirebaseAuth.instance.currentUser?.uid}/profile").update({"displayname": displayname});
    }

    return exists;
  }

  @override
  Future<bool> updateEmail(String email) async{
    bool result = FirebaseAuth.instance.currentUser == null;
    if(!result) {
      await FirebaseAuth.instance.currentUser?.updateEmail(email);
      FirebaseDatabase.instance.ref("users/${FirebaseAuth.instance.currentUser?.uid}/profile").update({"email": email});
    }

    return result;
  }

  @override
  Future<bool> updatePassword(String password)async {
    bool result = FirebaseAuth.instance.currentUser == null;
   if(!result) await FirebaseAuth.instance.currentUser?.updatePassword(password);

    return result;
  }

  @override
  Future<bool> updatePhoto(String url) async {
    bool result = FirebaseAuth.instance.currentUser == null;
   if(!result) {
      await FirebaseAuth.instance.currentUser?.updatePhotoURL(url);
      FirebaseDatabase.instance.ref("users/${FirebaseAuth.instance.currentUser?.uid}/profile").update({"photoUrl": url});
    }
    return result;
  }

  @override
  Future presence() async{
    // TODO: implement presense
    // Since I can connect from multiple devices, we store each connection
// instance separately any time that connectionsRef's value is null (i.e.
// has no children) I am offline.
    //bool result = FirebaseAuth.instance.currentUser == null;
    //if(result==null)return;
    var uid = FirebaseAuth.instance.currentUser?.uid;
    final myConnectionsRef =FirebaseDatabase.instance.ref("users/$uid/connexions");

// Stores the timestamp of my last disconnect (the last time I was seen online)
    final lastOnlineRef = FirebaseDatabase.instance.ref("/users/$uid/lastOnline");

    final connectedRef = FirebaseDatabase.instance.ref(".info/connected");
    var streamSubscription = connectedRef.onValue.listen((event) {
      final connected = event.snapshot.value as bool? ?? false;
      if (connected) {
        final con = myConnectionsRef.push();

        // When this device disconnects, remove it.
        con.onDisconnect().remove();

        // When I disconnect, update the last time I was seen online.
        lastOnlineRef.onDisconnect().set(ServerValue.timestamp);

        // Add this device to my connections list.
        // This value could contain info about the device or a timestamp too.
        con.set(true);
      }
    });

    return streamSubscription;
  }

  @override
  Future<void> onValue({required String userFieldPath, required StreamController streamController})async {

    final childActivityRef = FirebaseDatabase.instance.ref("users/$userFieldPath");
    childActivityRef.onValue.listen((event) {
      if(event.snapshot.exists){
        streamController.add(event.snapshot.value);
      }
    });

  }

  @override
  Future<UserModel> getUser({required String userID}) async {
    var ref = FirebaseDatabase.instance.ref("users/$userID");
    var snapshot = await ref.get();
    if(snapshot.exists){
      return UserModel.fromJson (FirebaseObjectsElementsToMap.objectToMap(snapshot.value as Map));
    }else {
      return throw ("user doesn't exists");
    }
  }

  @override
  Future<void> deleteAccount()async{
   var result = FirebaseAuth.instance.currentUser == null;
    if(!result) {
      await FirebaseDatabase.instance.ref("users/${FirebaseAuth.instance.currentUser?.uid}").remove();
      await FirebaseAuth.instance.currentUser?.delete();
    }
  }

  @override
  Future<void> acceptRdm({required String uid}) async{
    var result = FirebaseAuth.instance.currentUser == null;
    if(result) {
       throw("you're not connected");
    }
    User? user = FirebaseAuth.instance.currentUser;
    var snapshot = await FirebaseDatabase.instance.ref("users/${user!.uid}/rdm/$uid").get();

    if(!snapshot.exists){

      throw ("demand doesn't exists");
    }
    Rdm rdm = Rdm.fromJson( FirebaseObjectsElementsToMap.objectToMap(snapshot.value as Map));
    var refFollower = FirebaseDatabase.instance.ref("users/${user.uid}/followers").child(uid);
    var refFollowerSender = FirebaseDatabase.instance.ref("users/$uid/followers").child(user.uid);
    await refFollower.set(Follower(followerUid: uid,chatID: rdm.chatID).toJson());
    await refFollowerSender.set(Follower(chatID: rdm.chatID,followerUid: user.uid).toJson());
    await subRdm(uid: uid);
  }

  @override
  Future<void> sendDm({required String uid, Chat? chat}) async{
    var result = FirebaseAuth.instance.currentUser == null;
    if(result) {
      throw("you're not connected");
    }
    User? user = FirebaseAuth.instance.currentUser;
    var refDm = FirebaseDatabase.instance.ref("users/${user?.uid}/dm").child(uid);
    var snapshot = await refDm.get();
    if(snapshot.exists){
      throw ("demand already sent");
    }
    var datTime = DateTime.now().millisecondsSinceEpoch;
    await refDm.set(Dm(targetUid: uid,createAt: datTime, chatID: chat?.id).toJson());
    await FirebaseDatabase.instance.ref("users/$uid/rdm").child(user!.uid).set(Rdm(createAt:datTime,senderUid: user.uid,chatID: chat?.id).toJson());


  }

  @override
  Future<void> subDm({required String uid}) async{
    var result = FirebaseAuth.instance.currentUser == null;
    if(result) {
      throw("you're not connected");
    }
    User? user = FirebaseAuth.instance.currentUser;
    var refDm = FirebaseDatabase.instance.ref("users/${user!.uid}/dm/$uid");
    var snapshot =await refDm.get();
    if(!snapshot.exists){
      throw("demand doesn't exists");
    }
    await refDm.remove();
    await FirebaseDatabase.instance.ref("users/$uid/rdm/${user.uid}").remove();


  }

  @override
  Future<void> subRdm({required String uid})async {
    var result = FirebaseAuth.instance.currentUser == null;
    if(result) {
      throw("you're not connected");
    }
    User? user = FirebaseAuth.instance.currentUser;
    var refRdm = FirebaseDatabase.instance.ref("users/${user!.uid}/rdm/$uid");
    var snapshot = await refRdm.get();
    if(!snapshot.exists){
      throw("demand doesn't exists");
    }
    await refRdm.remove();
    await FirebaseDatabase.instance.ref("users/$uid/dm/${user.uid}").remove();
  }

  @override
  Future<Dm> getDm({required String uid}) async{
    var result = FirebaseAuth.instance.currentUser == null;
    if(result) {
     return throw("you're not connected");
    }
    User? user = FirebaseAuth.instance.currentUser;
    var refDm = FirebaseDatabase.instance.ref("users/${user!.uid}/dm/$uid");
    var snapshot = await refDm.get();
    if(!snapshot.exists){
     return throw("demand doesn't exists");
    }
    return Dm.fromJson(FirebaseObjectsElementsToMap.objectToMap(snapshot.value as Map));
  }

  @override
  Future<List<Dm>> getDms([int limit = 10, String? key])async {
    List<Dm> list = [];
    var result = FirebaseAuth.instance.currentUser == null;
    if(result) {
      return throw("you're not connected");
    }
    User? user = FirebaseAuth.instance.currentUser;
    var refRdm = FirebaseDatabase.instance.ref("users/${user!.uid}/dm");
    var snapshot = await refRdm.startAt(null,key: key).limitToFirst(limit).get();

    if(!snapshot.exists){
      return throw("demands doesn't exists");
    }
    Map<String, dynamic> map = FirebaseObjectsElementsToMap.objetsToMap(snapshot.value as Map);
    map.forEach((key, value) {list.add(Dm.fromJson(FirebaseObjectsElementsToMap.objectToMap(value))); });

    return list;
  }

  
  @override
  Future<Rdm> getRdm({required String uid})async {
    var result = FirebaseAuth.instance.currentUser == null;
    if(result) {
      return throw("you're not connected");
    }
    User? user = FirebaseAuth.instance.currentUser;
    var refRdm = FirebaseDatabase.instance.ref("users/${user!.uid}/rdm/$uid");
    var snapshot = await refRdm.get();
    if(!snapshot.exists){
      return throw("demand doesn't exists");
    }
    return Rdm.fromJson(FirebaseObjectsElementsToMap.objectToMap(snapshot.value as Map));
  }

  @override
  Future<List<Rdm>> getRdms([int limit = 10,  String? key]) async{
    List<Rdm> list = [];
    var result = FirebaseAuth.instance.currentUser == null;
    if(result) {
      return throw("you're not connected");
    }
    User? user = FirebaseAuth.instance.currentUser;
    var refRdm = FirebaseDatabase.instance.ref("users/${user!.uid}/rdm");
    var snapshot = await refRdm.startAt(null,key: key).limitToFirst(limit).get();

    if(!snapshot.exists){
      return throw("demand doesn't exists");
    }
    Map<String, dynamic> map = FirebaseObjectsElementsToMap.objetsToMap(snapshot.value as Map);
    map.forEach((key, value) {list.add(Rdm.fromJson(FirebaseObjectsElementsToMap.objectToMap(value))); });

    return list;
  }

  
  @override
  Future<List<Rdm>> getRdmsWithChat([int limit = 10, String? key]) async{
    List<Rdm> list = [];

    var result = FirebaseAuth.instance.currentUser == null;
    if(result) {
      return throw("you're not connected");
    }
    User? user = FirebaseAuth.instance.currentUser;
    var refRdm = FirebaseDatabase.instance.ref("users/${user!.uid}/rdm");
    var snapshot = await refRdm.orderByChild("chatID").startAt(null,key: key).limitToFirst(limit).get();

    if(!snapshot.exists){
      return throw("demand doesn't exists");
    }
    Map<String, dynamic> map = FirebaseObjectsElementsToMap.objetsToMap(snapshot.value as Map);
    map.forEach((key, value) {list.add(Rdm.fromJson(FirebaseObjectsElementsToMap.objectToMap(value))); });

    return list;
  }

  @override
  Future<List<Follower>> getFollowers([int limit = 10, String? key]) async{
    List<Follower> list = [];

    bool exists = FirebaseAuth.instance.currentUser == null;
    if(exists) {
      return throw("you're not connected");
    }
    User? user = FirebaseAuth.instance.currentUser;
    var refRdm = FirebaseDatabase.instance.ref("users/${user!.uid}/followers");
    var snapshot = await refRdm.startAt(null,key: key).limitToFirst(limit).get();

    if(!snapshot.exists){
      return throw("demand doesn't exists");
    }
    Map<String, dynamic> map = FirebaseObjectsElementsToMap.objetsToMap(snapshot.value as Map);
    map.forEach((key, value) {list.add(Follower.fromJson(FirebaseObjectsElementsToMap.objectToMap(value))); });

    return list;
  }

  @override
  Future<List<Follower>> getFollowersWithChat([int limit = 10, String? key]) async{
    List<Follower> list = [];

    var result = FirebaseAuth.instance.currentUser == null;
    if(result) {
      return throw("you're not connected");
    }
    User? user = FirebaseAuth.instance.currentUser;
    var refRdm = FirebaseDatabase.instance.ref("users/${user!.uid}/followers");
    var snapshot = await refRdm.orderByChild("chatID").startAt(null,key: key).limitToFirst(limit).get();

    if(!snapshot.exists){
      return throw("demand doesn't exists");
    }
    Map<String, dynamic> map = FirebaseObjectsElementsToMap.objetsToMap(snapshot.value as Map);
    map.forEach((key, value) {list.add(Follower.fromJson(FirebaseObjectsElementsToMap.objectToMap(value))); });

    return list;
  }

  @override
  Future<void> emailVerification()async {

    print("dans email vérification hhhhh");
    bool isConnected = FirebaseAuth.instance.currentUser == null;
    if(!isConnected){ FirebaseAuth.instance.currentUser?.sendEmailVerification();}

  }

  @override
  Future<UserModel> getMyProfile() async{

    bool exists = FirebaseAuth.instance.currentUser == null;
    if(exists) {
      return throw("you're not connected");
    }
    User? user = FirebaseAuth.instance.currentUser;
    DatabaseReference ref = FirebaseDatabase.instance.ref("users/${user!.uid}");
    DataSnapshot snapshot = await ref.get();
    if(!snapshot.exists){
      return throw("profile doesn't exists");
    }
    return UserModel.fromJson(FirebaseObjectsElementsToMap.objectToMap(snapshot.value as Map));

  }

  @override
  Future<List<UserModel>> getUsersPage({int limit = 10, String? key}) async{
    List<UserModel> list = [];

    bool exists = FirebaseAuth.instance.currentUser == null;
    if(exists) {
      return throw("you're not connected");
    }
    User? user = FirebaseAuth.instance.currentUser;
    var refRdm = FirebaseDatabase.instance.ref("users");
    var snapshot = await refRdm.startAt(null,key: key).limitToFirst(limit).get();

    if(!snapshot.exists){
      return throw("demand doesn't exists");
    }
    Map<String, dynamic> map = FirebaseObjectsElementsToMap.objetsToMap(snapshot.value as Map);
    map.forEach((key, value) {list.add(UserModel.fromJson(FirebaseObjectsElementsToMap.objectToMap(value))); });

    return list;
  }

  @override
  Future<UserModel> createUserModel() async{

    User? user = FirebaseAuth.instance.currentUser;
    var ref = FirebaseDatabase.instance.ref("users");//.child('${credential.user?.uid}');
    UserModel userModel = UserModel(displayname:user?.displayName, email:user?.email, photoUrl:user?.photoURL ,uid: user?.uid );
    try {
      await ref.child(user!.uid).set({
        "profile": userModel.toJson()
      });
    } on Exception catch (e) {
      return throw("error on creating user profile");
    }

    return userModel;
  }


}