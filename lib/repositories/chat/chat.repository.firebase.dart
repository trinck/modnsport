import 'dart:async';

import 'package:modnsport/models/chat.model.dart';

abstract class ChatRepositoryFirebase{

  Future<List<Chat>> getPage([int limit = 30, String? start]);
  Future<List<Chat>> getAll();
  Future<String?> createChat({required Chat chat});
  Future<Chat> getChat({required String chatID});
  Future<void> updateChat({required Chat chat});
  Future<Chat> deleteChat({required String chatID});
  Future<void> onChatEvent({required StreamController streamController});
  Future<void> onValue({required String childIdField, required StreamController streamController});
}