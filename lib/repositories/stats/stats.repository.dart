import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:modnsport/models/activity.model.dart';
import 'package:modnsport/repositories/stats/stats.repository.firebase.dart';
import 'package:modnsport/utils/fierebase.covertomap.dart';

import '../../models/stats.model.dart';

class StatsRepository extends StatsRepositoryFirebase{


  @override
  Future<void> updateStatActivity({required Stream<int> stream, required StatsModel stats}) async{
    bool exists = FirebaseAuth.instance.currentUser == null;
    if(exists){
      throw("you're not connected");
    }
    User? user =  FirebaseAuth.instance.currentUser;
    DateTime date = DateTime.now();
    stats.date = "${date.year}-${date.month}-${date.day}";
    var refStats = FirebaseDatabase.instance.ref("stats/${user?.uid}/${stats.date}/${stats.id}");
    DataSnapshot snapshot = await refStats.get();
    if(!snapshot.exists){
      await refStats.set(stats.toJson());
    }

     stream.listen((event) {
      try{
         refStats.update({"kcaDone":ServerValue.increment((event * stats.kca!)) });
      }catch(e){
        throw("error on updating activity stats: $e");
      }
    });

  }


  @override
  Future<List<StatsModel>> getMyStats() async{
    bool exists = FirebaseAuth.instance.currentUser == null;
    if(exists){
      throw("you're not connected");
    }
    User? user =  FirebaseAuth.instance.currentUser;
    var refStats = FirebaseDatabase.instance.ref("stats/${user?.uid}").orderByKey();
    DataSnapshot snapshot = await refStats.get();
    if(!snapshot.exists){
      return throw("there aren't no data stats yet");
    }
    List<StatsModel> list = [];
    Map<String, dynamic> map = FirebaseObjectsElementsToMap.objetsToMap(snapshot.value as Map);
    map.forEach((key, value) {
      FirebaseObjectsElementsToMap.objetsToMap(value as Map).forEach((key, value) {
        list.add(StatsModel.fromJson(FirebaseObjectsElementsToMap.objectToMap(value as Map)));
      });
    });

    return list;
  }

  @override
  Future<Map<String, dynamic>> getStats() async{
    var refStats = FirebaseDatabase.instance.ref("stats").orderByKey();
    DataSnapshot snapshot = await refStats.get();
    if(!snapshot.exists){
      return throw("there aren't no data stats yet");
    }
    Map<String, dynamic> list = {};

    Map<String, dynamic> map = FirebaseObjectsElementsToMap.objetsToMap(snapshot.value as Map);
    map.forEach((key, value) {
     list.putIfAbsent(key, () => value);
    });

    return list;
  }

  @override
  Future<List<StatsModel>> getUserStats({required String uid})async {
    var refStats = FirebaseDatabase.instance.ref("stats/$uid").orderByKey();
    DataSnapshot snapshot = await refStats.get();
    if(!snapshot.exists){
      return throw("there aren't no data stats yet");
    }
    List<StatsModel> list = [];
    Map<String, dynamic> map = FirebaseObjectsElementsToMap.objetsToMap(snapshot.value as Map);
    map.forEach((key, value) {
      FirebaseObjectsElementsToMap.objetsToMap(value as Map).forEach((key, value) {
        list.add(StatsModel.fromJson(FirebaseObjectsElementsToMap.objectToMap(value as Map)));
      });
    });

    return list;
  }






}