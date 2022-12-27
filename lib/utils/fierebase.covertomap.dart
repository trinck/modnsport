abstract class FirebaseObjectsElementsToMap{

 static Map<String,dynamic> objetsToMap(Map<Object?, Object?> json){
   Map<String,dynamic> data = {};
   for(var item in json.entries){
     List<String> keys = [];
     List<dynamic> values = [];
     for(var item2 in (item.value as Map).entries){
       keys.add(item2.key);
       values.add(item2.value);
     }
     data[item.key as String]=Map.fromIterables(keys, values);
   }
   return data;

 }

 static Map<String,dynamic> objectToMap(Map<Object?, Object?> json){
  Map<String,dynamic> data;
   List<String> keys = [];
   List<dynamic> values = [];
   for(var item in json.entries){
     keys.add(item.key as String);
     values.add(item.value);
   }
   data = Map.fromIterables(keys, values);
   return data;
 }
}