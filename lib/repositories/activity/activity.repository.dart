import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:modnsport/blocs/activity/activity.event.dart';
import 'package:modnsport/blocs/home/home.event.dart';
import 'package:modnsport/models/activity.model.dart';
import 'package:modnsport/repositories/activity/activity.repository.firebase.dart';
import 'package:modnsport/utils/fierebase.covertomap.dart';

class ActivityRepository extends ActivityRepositoryFirebase{
  @override
  Future<void> createActivity({required Activity activity}) async {


    var ref = FirebaseDatabase.instance.ref("activities").push();
    activity.id = ref.key;
    try{await ref.set(activity.toJson());
    }
    catch(e){
        throw("error on creating Activity: $e");
        }

  }

  @override
  Future<void> deleteActivity({required Activity activity}) async{
    var ref = FirebaseDatabase.instance.ref("activities/${activity.id}");
    var snapshot = await ref.get();
    if(snapshot.exists){
       ref.remove();
    }else {
      throw ("activity doesn't exists");
    }

  }

  @override
  Future<Activity> getActivity({required String activityID}) async{
    var ref = FirebaseDatabase.instance.ref("activities/$activityID");
     var snapshot = await ref.get();
     if(snapshot.exists){

       return Activity.fromJson (FirebaseObjectsElementsToMap.objectToMap(snapshot.value as Map));
     }else {
       return throw ("activity doesn't exists");
     }
  }


  @override
  Future<void> updateActivity({required Activity activity}) async{
    var ref = FirebaseDatabase.instance.ref("activities/${activity.id}");
    try{
      await ref.update(activity.toJson());
    }catch(e){
      throw ("error on update Activity: $e");
    }


  }




  @override
  Future<List<Activity>> getPage([int limit = 30, String? start]) async{

    List<Activity> listActivity = [];
    var ref = FirebaseDatabase.instance.ref("activities");
    var list = ref.startAt(null,key: start).limitToFirst(limit).get();
    await list.then((value) {
      if(value.exists){

        Map<String, dynamic> map = FirebaseObjectsElementsToMap.objetsToMap(value.value as Map);
        for(var item in map.entries){
          listActivity.add(Activity.fromJson(FirebaseObjectsElementsToMap.objectToMap(item.value)));
        }

      }
    });

    return listActivity;
  }


   Future<void> onActivityEvent({required StreamController<OnActivityEvent> streamController})async{
    final activityRef = FirebaseDatabase.instance.ref("activities");

    /*************************************************************
     * ****************onchanged*****************************************
     * ***************************************************************/
    activityRef.onChildChanged.listen((event) {

      streamController.add(OnActivityEvent(action: "changed", event: Activity.fromJson(FirebaseObjectsElementsToMap.objectToMap(event.snapshot.value as Map))));
    });

    /*************************************************************
     * ****************onremoved*****************************************
     * ***************************************************************/
    activityRef.onChildRemoved.listen((event) {

      streamController.add(OnActivityEvent(action: "removed", event: Activity.fromJson(FirebaseObjectsElementsToMap.objectToMap(event.snapshot.value as Map))));
    });

    /*************************************************************
     * **************** onadded *****************************************
     * ***************************************************************/
    activityRef.onChildAdded.listen((event) {

      streamController.add(OnActivityEvent(action: "added", event: Activity.fromJson(FirebaseObjectsElementsToMap.objectToMap(event.snapshot.value as Map))));
    });

  }

  @override
  Future<void> onValue({required String childIdField,required StreamController streamController}) async {

    final childActivityRef = FirebaseDatabase.instance.ref("activities/$childIdField");
    childActivityRef.onValue.listen((event) {
      if(event.snapshot.exists){
        streamController.add(event.snapshot.value);
      }
    });

  }

  @override
  Future<List<Activity>> getAll()async {

    List<Activity> listActivity = [];
    var ref = FirebaseDatabase.instance.ref("activities");
    var list = ref.get();
    await list.then((value) {
      if(value.exists){

        Map<String, dynamic> map = FirebaseObjectsElementsToMap.objetsToMap(value.value as Map);
        map.forEach((key, value) {listActivity.add(Activity.fromJson(FirebaseObjectsElementsToMap.objectToMap(value))); });

      }
    });

    return listActivity;
  }


}