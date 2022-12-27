import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';
import 'package:modnsport/models/discipline.model.dart';
import 'package:modnsport/repositories/discipline/discipline.repository.firebase.dart';
import 'package:modnsport/utils/fierebase.covertomap.dart';

class DisciplineRepository extends DisciplineRepositoryFirebase{

  @override
  Future<void> addDiscipline({required Discipline discipline}) async{
    var ref = FirebaseDatabase.instance.ref("discipline").child('${discipline.name}');
    try{
      await ref.set(discipline.toJson());
    }
    catch(e){
      throw("error on adding discipline: $e");
    }
  }

  @override
  Future<void> addDisciplineActivity({required ActivityDiscipline activityDiscipline, required String disciplineName}) async{
    var ref = FirebaseDatabase.instance.ref("discipline/$disciplineName/activities").child("${activityDiscipline.activityID}");
    try{
      ref.set(true);
    }catch(e){
      throw("error: $e");
    }

  }

  @override
  Future<void> deleteDiscipline({required String disciplineName})async {
    var ref = FirebaseDatabase.instance.ref("discipline/$disciplineName");
    var snapshot = await ref.get();
    if(snapshot.exists){
      ref.remove();
    }else {
      throw ("discipline doesn't exists for deleting");
    }
  }

  @override
  Future<void> deleteDisciplineActivity({required String disciplineName, required String activityDiscipline}) async{
    var ref = FirebaseDatabase.instance.ref("discipline/$disciplineName/activities/$activityDiscipline");
    var snapshot = await ref.get();
    if(snapshot.exists){
      ref.remove();
    }else {
      throw ("discipline activity doesn't exists for deleting");
    }
  }

  @override
  Future<List<Discipline>> getAll() async{
    List<Discipline> listDiscipline = [];
    var ref = FirebaseDatabase.instance.ref("discipline");
    var list = ref.get();
    await list.then((value) {
      if(value.exists){

        Map<String,dynamic> map = FirebaseObjectsElementsToMap.objetsToMap(value.value as Map);

        for(var item in map.entries){
          listDiscipline.add(Discipline.fromJson(item.value));

        }
      }
    });

    return listDiscipline;
  }

  @override
  Future<Discipline> getDiscipline({required String disciplineName})async {
    var ref = FirebaseDatabase.instance.ref("discipline/$disciplineName");
    var snapshot = await ref.get();
    if(snapshot.exists){
      return Discipline.fromJson (FirebaseObjectsElementsToMap.objectToMap(snapshot.value as Map));
    }else {
      return throw ("discipline doesn't exists");
    }
  }

  @override
  Future<List<ActivityDiscipline>> getDisciplineActivities({required String disciplineName}) async{
    List<ActivityDiscipline> listActivity = [];
    var ref = FirebaseDatabase.instance.ref("discipline/$disciplineName/activities");
    var list = ref.get();
    await list.then((value) {
      if(value.exists){

        Map<String,dynamic> map = FirebaseObjectsElementsToMap.objetsToMap(value.value as Map);
       map.entries.map((e) => listActivity.add(ActivityDiscipline.fromJson(e.value)));

      }
    });

    return listActivity;
  }

  @override
  Future<List<Discipline>> getPage([int limit = 30, String? start]) async{
    List<Discipline> listDiscipline = [];
    var ref = FirebaseDatabase.instance.ref("discipline");
    var list = ref.startAfter(null,key: start).limitToFirst(limit).get();
    await list.then((value) {
      if(value.exists){
        Map<String,dynamic> map = FirebaseObjectsElementsToMap.objetsToMap(value.value as Map);
        for(var item in map.entries){

          listDiscipline.add(Discipline.fromJson(item.value));

        }

      }
    });

    return listDiscipline;
  }

  @override
  Future<void> updateDisciplineName({required String oldName, required String newName}) {
    // TODO: implement updateDisciplineName
    throw UnimplementedError();
  }

  @override
  Future<void> updateDisciplineVerified({required String disciplineName, required bool verified}) async{
    var ref = FirebaseDatabase.instance.ref("discipline/$disciplineName");
    var snapshot = await ref.get();
    if(snapshot.exists){
      ref.update({"verified": verified});
    }else {
       throw ("discipline doesn't exists");
    }
  }


}