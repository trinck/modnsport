import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';
import 'package:modnsport/models/chat.model.dart';
import 'package:modnsport/models/message.model.dart';
import 'package:modnsport/repositories/chat/chat.repository.dart';
import 'package:modnsport/repositories/chat/chat.repository.firebase.dart';
import 'package:modnsport/repositories/messages/message.repository.firebase.dart';
import 'package:modnsport/utils/fierebase.covertomap.dart';

class MessageRepository extends MessageRepositoryFirebase{

  ChatRepositoryFirebase chatRepository = GetIt.I.get<ChatRepositoryFirebase>();

  @override
  Future<Message> deleteMessage({required String messageID, required String chatID}) async{
    var refMessages = FirebaseDatabase.instance.ref("messages/$chatID/$messageID");

    var snapshot = await refMessages.get();
    if(!snapshot.exists){
      return throw("message doesn't exist");
    }
    Message message = Message.fromJson(FirebaseObjectsElementsToMap.objectToMap(snapshot.value as Map));
    await refMessages.remove();
   return message;
  }


  @override
  Future<List<Message>> getAll({required String chatID})async {
    List<Message> listActivity = [];
    var ref = FirebaseDatabase.instance.ref("messages/$chatID");
    var list = ref.get();
    await list.then((value) {
      if(value.exists){
        Map<String, dynamic> map = FirebaseObjectsElementsToMap.objetsToMap(value.value as Map);
        map.entries.map((e) => listActivity.add(Message.fromJson(FirebaseObjectsElementsToMap.objectToMap(e.value))));
      }
    });

    return listActivity;
  }


  @override
  Future<Message> getMessage({required String messageID,required String chatID})async {
    var refMessages = FirebaseDatabase.instance.ref("messages/$chatID/$messageID");

    var snapshot = await refMessages.get();
    if(!snapshot.exists){
      return throw("message doesn't exist");
    }
    Message message = Message.fromJson(FirebaseObjectsElementsToMap.objectToMap(snapshot.value as Map));
    return message;
  }

  @override
  Future<List<Message>> getPage({int limit = 30, String? start, required String chatID})async {
    List<Message> listActivity = [];
    var ref = FirebaseDatabase.instance.ref("messages/$chatID");
    var list = ref.startAt(null,key: start).limitToFirst(limit).get();
    await list.then((value) {
      if(value.exists){
        Map<String, dynamic> map = FirebaseObjectsElementsToMap.objetsToMap(value.value as Map);
        map.entries.map((e) => listActivity.add(Message.fromJson(FirebaseObjectsElementsToMap.objectToMap(e.value))));
      }
    });

    return listActivity;
  }


  @override
  Future<void> onMessageEvent({required String chatID, required StreamController streamController})async {
    final messagesRef = FirebaseDatabase.instance.ref("messages/$chatID");

    /*************************************************************
     * ****************onchanged*****************************************
     * ***************************************************************/
    messagesRef.onChildChanged.listen((event) {

      streamController.add(Message.fromJson(FirebaseObjectsElementsToMap.objectToMap(event.snapshot.value as Map)));
    });

    /*************************************************************
     * ****************onremoved*****************************************
     * ***************************************************************/
    messagesRef.onChildRemoved.listen((event) {

      streamController.add(Message.fromJson(FirebaseObjectsElementsToMap.objectToMap(event.snapshot.value as Map)));
    });

    /*************************************************************
     * **************** onadded *****************************************
     * ***************************************************************/
    messagesRef.onChildAdded.listen((event) {

      streamController.add(Message.fromJson(FirebaseObjectsElementsToMap.objectToMap(event.snapshot.value as Map)));
    });

  }

  @override
  Future<void> onValue({required String childIdField, required StreamController streamController}) {
    // TODO: implement onValue
    throw UnimplementedError();
  }

  @override
  Future<Message> sendMessage({required Message message, required String chatID}) async{
    var result = FirebaseAuth.instance.currentUser == null;
    if(result) {
      throw("you're not connected");
    }
    User? user = FirebaseAuth.instance.currentUser;
    message.sender = user!.uid;
    message.createAt = DateTime.now().millisecondsSinceEpoch;
    var refMessages = FirebaseDatabase.instance.ref("messages/$chatID").push();
    message.id = refMessages.key;
    await refMessages.set(message.toJson());
    Chat chat = Chat(lastmessage: "${user.displayName}: ${message.body}", id: chatID);
    await chatRepository.updateChat(chat: chat);

    return message;
  }

  @override
  Future<void> updateMessage({required Message message, required String chatID})async {
    var refMessages = FirebaseDatabase.instance.ref("messages/$chatID/${message.id}");
    await refMessages.update(message.toJson());

  }

}