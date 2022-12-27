import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:modnsport/blocs/programs/programs.event.dart';
import 'package:modnsport/models/activity.model.dart';
import 'package:modnsport/models/programs.model.dart';
import 'package:modnsport/repositories/programs/programs.repository.firebase.dart';
import 'package:modnsport/utils/fierebase.covertomap.dart';

class ProgramRepository extends ProgramsRepositoryFirebase{
  @override
  Future<void> createProgram({required Programs programs}) async{
    var ref = FirebaseDatabase.instance.ref("programmes").push();
    programs.id = ref.key;
    programs.createAt = DateTime.now().millisecondsSinceEpoch;
    try{
      await ref.set(programs.toJson());
    }
    catch(e){
      throw("error on creating Program: $e");
    }
  }

  @override
  Future<void> deletePrograms({required String programID}) async{
    var ref = FirebaseDatabase.instance.ref("programmes/$programID");
    var snapshot = await ref.get();
    if(snapshot.exists){
      ref.remove();
    }else {
      throw ("program doesn't exists for deleting");
    }

  }

  @override
  Future<List<Programs>> getPage([int limit = 30, String? start]) async{
    List<Programs> listActivity = [];
    var ref = FirebaseDatabase.instance.ref("programmes");
    var list = ref.startAt(null,key: start).limitToFirst(limit).get();
    await list.then((value) {
      if(value.exists){

        Map<String,dynamic> map = FirebaseObjectsElementsToMap.objetsToMap(value.value as Map);
          for(var item in map.entries){

            listActivity.add(Programs.fromJson(item.value));

          }
      }
    });

    return listActivity;
  }

  @override
  Future<Programs> getProgram({required String programID})async {
    var ref = FirebaseDatabase.instance.ref("programmes/$programID");
    var snapshot = await ref.get();
    if(snapshot.exists){
      return Programs.fromJson (FirebaseObjectsElementsToMap.objectToMap(snapshot.value as Map));
    }else {
      return throw ("Program doesn't exists");
    }
  }


  @override
  Future<void> onProgramsEvent({required StreamController<OnProgramsEvent> streamController}) async {
    final programsyRef = FirebaseDatabase.instance.ref("programmes");

    /*************************************************************
     * ****************onchanged*****************************************
     * ***************************************************************/
    programsyRef.onChildChanged.listen((event) {

      streamController.add(OnProgramsEvent(action: "changed", event: Programs.fromJson(FirebaseObjectsElementsToMap.objectToMap(event.snapshot.value as Map))));
    });

    /*************************************************************
     * ****************onremoved*****************************************
     * ***************************************************************/
    programsyRef.onChildRemoved.listen((event) {

      streamController.add(OnProgramsEvent(action: "removed", event: Programs.fromJson(FirebaseObjectsElementsToMap.objectToMap(event.snapshot.value as Map))));
    });

    /*************************************************************
     * **************** onadded *****************************************
     * ***************************************************************/
    programsyRef.onChildAdded.listen((event) {

      streamController.add(OnProgramsEvent(action: "added", event: Programs.fromJson(FirebaseObjectsElementsToMap.objectToMap(event.snapshot.value as Map))));
    });

  }

  @override
  Future<void> onValue({required String childIdField, required StreamController streamController})async {
    final childActivityRef = FirebaseDatabase.instance.ref("programmes/$childIdField");
    childActivityRef.onValue.listen((event) {
      if(event.snapshot.exists){
        streamController.add(event.snapshot.value);
      }
    });
  }


  @override
  Future<void> followProgram({required String programID}) async{
    final followersRef = FirebaseDatabase.instance.ref("programmes/$programID/followers");

    var auth = FirebaseAuth.instance.currentUser;
    if(auth == null){throw("you're not connected");}
    final userProgrammeRef = FirebaseDatabase.instance.ref("users-programmes/${auth.uid}/$programID");
    try{
     await followersRef.child(auth.uid).set(true);
     userProgrammeRef.set({
       "Start": ServerValue.timestamp
     });
    }catch(e){
        throw("error: $e");
    }

  }


  @override
  Future<void> unFollowProgram({required String programID})async {
    final followersRef = FirebaseDatabase.instance.ref("programmes/$programID/followers");
    var auth = FirebaseAuth.instance.currentUser;
    if(auth!=null){
      followersRef.child(auth.uid).remove();
      return;
    }else
    {
      throw("you're not connected");
    }
  }

  @override
  Future<void> updateProgram({required Programs program})async {
    var ref = FirebaseDatabase.instance.ref("programmes/${program.id}");
    try{
      await ref.update(program.toJson());
    }catch(e){
      throw ("error on update program: $e");
    }
  }

  @override
  Future<void> deleteProgramsActivity({required String programID, required String activityID}) async{
    final followersRef = FirebaseDatabase.instance.ref("programmes/$programID/followers");
    var auth = FirebaseAuth.instance.currentUser;
    if(auth!=null){
      followersRef.child(auth.uid).set(true);
      return;
    }else
    {
      throw("you're not connected");
    }
  }

  @override
  Future<void> deleteProgramsImage({required String programID, required String imageID}) async{
    var imageRef = FirebaseDatabase.instance.ref("programmes/$programID/images/$imageID");
    try{
      await imageRef.remove();
    }catch(e){
      throw ("error on delete image from program: $e");
    }
  }

  @override
  Future<void> subscribeOtherToProgram({required String programID, required String uid}) async{
    var ref = FirebaseDatabase.instance.ref("programmes/$programID/images").child(uid);
    try{
      await ref.set(true);
    }catch(e){
      throw ("error on subscribing user to this program: $e");
    }
  }


  @override
  Future<void> unSubscribeOtherToProgram({required String programID, required String uid})async {
    var ref = FirebaseDatabase.instance.ref("programmes/$programID/images/$uid");
    try{
      await ref.remove();
    }catch(e){
      throw ("error on unsubscribing user to this program: $e");
    }
  }


  @override
  Future<void> updateProgramDuree({required Programs program}) async{
    var ref = FirebaseDatabase.instance.ref("programmes/${program.id}");
    try{
      await ref.update({"duree": program.duree});
    }catch(e){
      throw ("error on update duree to this program: $e");
    }
  }

  @override
  Future<void> updateProgramInfos({required Programs program})async {
    var ref = FirebaseDatabase.instance.ref("programmes/${program.id}");
    try{
      await ref.update({"infos": program.infos});
    }catch(e){
      throw ("error on update infos to this program: $e");
    }
  }

  @override
  Future<void> updateProgramTitle({required Programs program}) async{
    var ref = FirebaseDatabase.instance.ref("programmes/${program.id}");
    try{
      await ref.update({"title": program.title});
    }catch(e){
      throw ("error on update title to this program: $e");
    }
  }

  @override
  Future<void> updateProgramsActivities({required Programs program}) async {
    var ref = FirebaseDatabase.instance.ref("programmes/${program.id}/activities");
    try{
      await ref.update(program.toJson()['activities']);
    }catch(e){
      throw ("error on update activities to this program: $e");
    }
  }

  @override
  Future<void> updateProgramsActivity({required Programs program, required String activityID}) async {
    var ref = FirebaseDatabase.instance.ref("programmes/${program.id}/activities/$activityID");
    try{
      await ref.update(program.toJson()['activities'][activityID]);
    }catch(e){
      throw ("error on update activity $activityID on this program: $e");
    }
  }

  @override
  Future<void> updateProgramsFollowers({required Programs program}) async{
    var ref = FirebaseDatabase.instance.ref("programmes/${program.id}/followers");
    try{
      await ref.update(program.toJson()['followers']);
    }catch(e){
      throw ("error on update followers on this program: $e");
    }
  }

  @override
  Future<void> updateProgramsImages({required Programs program})async {
    var ref = FirebaseDatabase.instance.ref("programmes/${program.id}/images");
    try{
      await ref.update(program.toJson()['images']);
    }catch(e){
      throw ("error on update images on this program: $e");
    }
  }

  @override
  Future<void> addProgramsActivity({required String programID, required ProgramsActivity activity}) async{
    var ref = FirebaseDatabase.instance.ref("programmes/$programID/activities").push();
    activity.id =ref.key;
    try{
      await ref.set(activity.toJson());
    }catch(e){
      throw ("error on setting activity on this program: $e");
    }
  }

  @override
  Future<void> addProgramsImage({required String programID, required ProgramsImages image}) async{
    var ref = FirebaseDatabase.instance.ref("programmes/$programID/images").push();
    image.id = ref.key;
    try{
      await ref.set(image.toJson());
    }catch(e){
      throw ("error on setting image on this activity: $e");
    }
  }

  @override
  Future<List<Programs>> getAll() async{
    List<Programs> listActivity = [];
    var ref = FirebaseDatabase.instance.ref("programmes");
    var list = ref.get();
    await list.then((value) {
      if(value.exists){

        Map<String,dynamic> map = FirebaseObjectsElementsToMap.objetsToMap(value.value as Map);
        for(var item in map.entries){

          listActivity.add(Programs.fromJson(item.value));

        }

      }
    });

    return listActivity;
  }

  @override
  Future<void> progressOnProgram({required String programID,required Stream<int> stream, required UserProgramsActivity activity})async {

    bool exists = FirebaseAuth.instance.currentUser == null;
    if(exists){
      throw("you're not connected");
    }
    User? user =  FirebaseAuth.instance.currentUser;
    var ref = FirebaseDatabase.instance.ref("users-programmes/${user?.uid}/$programID/activities/${activity.id}");
    DataSnapshot snapshot = await ref.get();
    if(!snapshot.exists){
      activity.start = DateTime.now().millisecondsSinceEpoch;
      await ref.set({activity.toJson()});
    }

    stream.listen((event) {
      try{
        ref.update({
          "step": event
        });
      }catch(e){
        throw ("error progress on this activity: $e");
      }
    });

  }

  @override
  Future<UserProgramsActivity> getUserProgramActivity({required String programID,required String uid, required String activityID})async {
    var ref = FirebaseDatabase.instance.ref("users-programmes/$uid/$programID/activities/$activityID");
    DataSnapshot snapshot = await ref.get();
    if(!snapshot.exists){
     return throw("progress activity doesn't exists");
    }

    return UserProgramsActivity.fromJson(FirebaseObjectsElementsToMap.objectToMap(snapshot.value as Map));
  }


}