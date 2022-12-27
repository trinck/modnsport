
 import 'dart:convert';

 import 'package:http/http.dart' as http;
import 'package:modnsport/repositories/uri/ModelType.dart';
abstract class Repository<T extends ModelType> {
 String? baseUri;
 T Function(Map<String, dynamic>)? fromJson;

 Repository.baseUri(this.baseUri,this.fromJson);

 Future<T> getAll(String root) async {

  String url = "${baseUri!}$root";
  try {

   http.Response response = await http.get(Uri.parse(url));

   if (response.statusCode == 200) {

    var map =json.decode(response.body) ;

    T t = fromJson!(map);

    return t;
   } else {
    return throw ("Error => ${response.statusCode}");
   }
  } catch (e) {
   return throw('Error => $e');
  }


 }


 Future<T> getOne(String root, int id) async {
  String url = "${baseUri!}$root$id";

  try {

   http.Response response = await http.get(Uri.parse(url));

   if (response.statusCode == 200) {

     var map =json.decode(response.body) ;

    T t = fromJson!(map);
      print("apres from");
      print(map);
    return t;
   } else {
    return throw ("Error => ${response.statusCode}");
   }
  } catch (e) {
   return throw('Error => $e');
  }

 }

 Future<T> setOne() async{


  return await Future.delayed(Duration.zero);
 }

 Future<T> setAll() async{


  return await Future.delayed(Duration.zero);
 }

 Future<T> updateOne() async{


  return await Future.delayed(Duration.zero);
 }

}