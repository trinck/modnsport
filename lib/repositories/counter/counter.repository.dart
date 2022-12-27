import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:modnsport/models/activity.model.dart';

import 'package:modnsport/models/counter.model.dart';
import 'package:modnsport/repositories/counter/counter.repository.firebase.dart';
import 'package:modnsport/utils/fierebase.covertomap.dart';

class CounterRepository extends CounterRepositoryFirebase{


  @override
  Future<void> updateCounterName({required String oldKeyName, required String newName}) async{
    var ref = FirebaseDatabase.instance.ref("counter/$oldKeyName");
    try{
      ref.set(null);
      FirebaseDatabase.instance.ref("counter").child(newName).set(true);
    }catch(e){
       throw('error on rename counter $oldKeyName to $newName');
    }
}

  @override
  Future<void> createCounter({required CounterModel counterModel}) async{
    var ref = FirebaseDatabase.instance.ref("counter").child('${counterModel.keyname}');

    try{
      await ref.set(counterModel.toJson());
    }catch(e){
      throw("error on creatting counter ${counterModel.keyname}: $e");
    }
  }

  @override
  Future<void> createCounterProgramActivity({required ActivityCounter activityCounter, required String counterKeyName}) async{
    var ref = FirebaseDatabase.instance.ref("counter/$counterKeyName/activities");
    try{
      ref.set(activityCounter.toJson());
    }catch(e){
       throw("error: $e");
    }

  }

  @override
  Future<List<CounterModel>> getAll() async{

    var ref = FirebaseDatabase.instance.ref("counter");
     var datasnapshot = await ref.get();
      if(datasnapshot.exists){

        try{ List<CounterModel> list = [];
        Map<String,dynamic> map = FirebaseObjectsElementsToMap.objetsToMap(datasnapshot.value as Map);
        map.forEach((key, value) {list.add(CounterModel.fromJson(value));});

        return list;
       }catch(e){
         return throw("error occurred on listing counters: $e");
       }
      }

   return throw("error on listing counters: unknown");
  }


  @override
  Future<CounterModel> getCounter({required String counterKeyName})async {
    var ref = FirebaseDatabase.instance.ref("counter/$counterKeyName");
   var datasnapshot =await ref.get();

    if(datasnapshot.exists) {
      try {
        Map<String, dynamic> map = FirebaseObjectsElementsToMap.objectToMap(datasnapshot.value as Map);
        return CounterModel.fromJson(map);
      } catch (e) {
        return throw("error occurred: $e");
      }
    }
    return throw("error on retrieving counter $counterKeyName");
  }

  @override
  Future<ActivityCounter> getCounterProgramActivity({required String activityProgramID, required String counterKeyName}) {
    var ref = FirebaseDatabase.instance.ref("counter/$counterKeyName/activities/$activityProgramID");
    ref.get().then((value) {
      
        return ActivityCounter.fromJson(FirebaseObjectsElementsToMap.objectToMap(value.value as Map));
    }).onError((error, stackTrace) => throw("error: $error"));

    return throw("error on retrieving counterActivity $activityProgramID ");
  }

  @override
  Future<void> onCounterActivitiesEvent({required StreamController streamController}) {
    // TODO: implement onCounterActivitiesEvent
    throw UnimplementedError();
  }

  @override
  Future<void> updateCounterProgramActivity({required ActivityCounter activityCounter, required String counterKeyName}) async{
    var ref = FirebaseDatabase.instance.ref("counter/$counterKeyName/activities/${activityCounter.id}");
    try{
      await ref.update(activityCounter.toJson());
    }catch(e){
      throw("error on updating counter activity ${activityCounter.id} : $e");
    }
  }

  @override
  Future<void> updateCounterVerified({required String counterKeyName, required bool verified}) async{
    var ref = FirebaseDatabase.instance.ref("counter/$counterKeyName");
        try{
          await ref.update({
            'verified': verified
          });
        }catch(e){
          throw("error occurred on updateCounterVerified: $e");
        }
  }



}