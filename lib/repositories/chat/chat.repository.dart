import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:modnsport/models/chat.model.dart';
import 'package:modnsport/repositories/chat/chat.repository.firebase.dart';
import 'package:modnsport/utils/fierebase.covertomap.dart';

class ChatRepository extends ChatRepositoryFirebase{
  @override
  Future<String?> createChat({required Chat chat})async {

    var ref = FirebaseDatabase.instance.ref("chats").push();
    chat.id = ref.key;
    chat.createAt = DateTime.now().millisecondsSinceEpoch;
    try{

       await ref.set(chat.toJson());
    }
    catch(e){
      throw("error on creating chat: $e");
    }

    return chat.id;
  }

  @override
  Future<Chat> deleteChat({required String chatID})async {
    var ref = FirebaseDatabase.instance.ref("chats/$chatID");
    var snapshot = await ref.get();
    if(snapshot.exists){
      ref.remove();
    }else {
      throw ("chat doesn't exists");
    }
    return Chat.fromJson(FirebaseObjectsElementsToMap.objectToMap(snapshot.value as Map));
  }

  @override
  Future<Chat> getChat({required String chatID}) async{
    var ref = FirebaseDatabase.instance.ref("chats/$chatID");
    var snapshot = await ref.get();
    if(snapshot.exists){

      return Chat.fromJson (FirebaseObjectsElementsToMap.objectToMap(snapshot.value as Map));
    }else {
      return throw ("Chat doesn't exists");
    }
  }

  @override
  Future<List<Chat>> getPage([int limit = 30, String? start]) async{
    List<Chat> listActivity = [];
    var ref = FirebaseDatabase.instance.ref("chats");
    var list = ref.startAt(null,key: start).limitToFirst(limit).get();
    await list.then((value) {
      if(value.exists){
        Map<String, dynamic> map = FirebaseObjectsElementsToMap.objetsToMap(value.value as Map);
        map.forEach((key, value) {listActivity.add(Chat.fromJson(FirebaseObjectsElementsToMap.objectToMap(value))); });
      }
    });

    return listActivity;
  }
  /// ***************************************************
  /// ************feature incoming soon************************
  /// ********************************************************
  /// ******************************************************/
  @override
  Future<void> onChatEvent({required StreamController streamController})async {
    // TODO: implement onChatEvent
    throw UnimplementedError();
  }
  /// ***************************************************
  /// ************feature incoming soon************************
  /// ********************************************************
  /// ******************************************************/
  @override
  Future<void> onValue({required String childIdField, required StreamController streamController})async {
    // TODO: implement onValue
    throw UnimplementedError();
  }

  @override
  Future<void> updateChat({required Chat chat}) async{
    var ref = FirebaseDatabase.instance.ref("chats/${chat.id}");
    try{
      await ref.update(chat.toJson());
    }catch(e){
      throw ("error on update chat ${chat.id}: $e");
    }
  }

  @override
  Future<List<Chat>> getAll() async{
    List<Chat> listChat = [];
    var ref = FirebaseDatabase.instance.ref("chats");
    var list = ref.get();
    await list.then((value) {
      if(value.exists){

        Map<String, dynamic> map = FirebaseObjectsElementsToMap.objetsToMap(value.value as Map);
        map.forEach((key, value) {listChat.add(Chat.fromJson(FirebaseObjectsElementsToMap.objectToMap(value))); });
      }
    });

    return listChat;
  }




}