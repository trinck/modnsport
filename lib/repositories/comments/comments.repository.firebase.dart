import 'dart:async';
import 'package:modnsport/models/comment.model.dart';

abstract class CommentsRepositoryFirebase{

  Future<List<CommentModel>> getPage({int limit = 30, String? start,required String commentaryID});
  Future<List<CommentModel>> getAll({required String commentaryID});
  Future<CommentModel> sendComment({required CommentModel comment,required String commentaryID});
  Future<CommentModel> getComment({required String commentID, required String commentaryID});
  Future<void> updateComment({required CommentModel comment, required String commentaryID});
  Future<CommentModel> deleteMessage({required String commentID, required String commentaryID});
  Future<void> onCommentEvent({required String commentaryID,required StreamController streamController});
  Future<void> onValue({required String childIdField, required StreamController streamController});

}