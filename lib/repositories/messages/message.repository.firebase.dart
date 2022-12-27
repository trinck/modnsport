import 'dart:async';

import 'package:modnsport/models/chat.model.dart';
import 'package:modnsport/models/message.model.dart';

abstract class MessageRepositoryFirebase{


  Future<List<Message>> getPage({int limit = 30, String? start,required String chatID});
  Future<List<Message>> getAll({required String chatID});
  Future<Message> sendMessage({required Message message,required String chatID});
  Future<Message> getMessage({required String messageID, required String chatID});
  Future<void> updateMessage({required Message message, required String chatID});
  Future<Message> deleteMessage({required String messageID, required String chatID});
  Future<void> onMessageEvent({required String chatID,required StreamController streamController});
  Future<void> onValue({required String childIdField, required StreamController streamController});


}