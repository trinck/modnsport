import 'package:firebase_database/firebase_database.dart';
import 'package:modnsport/utils/fierebase.covertomap.dart';

import 'demo.repository.firebase.dart';

class DemoRepository extends DemoRepositoryFirebase{
  @override
  Future<List<String>> getDemo() async{
    List<String> demo =[];
   DatabaseReference refDemo = FirebaseDatabase.instance.ref("demo");
   DataSnapshot snapshot = await refDemo.get();
   if(!snapshot.exists){return throw("no demo for moment");}

   FirebaseObjectsElementsToMap.objectToMap(snapshot as Map).forEach((key, value) {demo.add(value);});
   return demo;
  }

  @override
  Future<void> setDemo({required String imageDemoUrl}) async{
    DatabaseReference refDemo = FirebaseDatabase.instance.ref("demo").push();
    try {
      refDemo.set(imageDemoUrl);
    } on Exception catch (e) {
      throw("error on updating demo $imageDemoUrl");
    }
  }
}