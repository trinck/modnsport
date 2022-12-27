import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:modnsport/models/comment.model.dart';
import 'package:modnsport/repositories/comments/comments.repository.firebase.dart';
import 'package:modnsport/utils/fierebase.covertomap.dart';

class CommentsRepository extends CommentsRepositoryFirebase{
  @override
  Future<CommentModel> deleteMessage({required String commentID, required String commentaryID})async {
    var refComment = FirebaseDatabase.instance.ref("comments/$commentaryID/$commentID");

    var snapshot = await refComment.get();
    if(!snapshot.exists){
      return throw("comment doesn't exist");
    }
    CommentModel comment = CommentModel.fromJson(FirebaseObjectsElementsToMap.objectToMap(snapshot.value as Map));
    await refComment.remove();
    return comment;
  }

  @override
  Future<List<CommentModel>> getAll({required String commentaryID})async {
    List<CommentModel> listComments = [];
    var ref = FirebaseDatabase.instance.ref("comments/$commentaryID");
    var list = ref.get();
    await list.then((value) {
      if(value.exists){
        Map<String, dynamic> map = FirebaseObjectsElementsToMap.objetsToMap(value.value as Map);
        map.entries.map((e) => listComments.add(CommentModel.fromJson(FirebaseObjectsElementsToMap.objectToMap(e.value))));
      }
    });
    return listComments;
  }

  @override
  Future<CommentModel> getComment({required String commentID, required String commentaryID}) async{
    var refComment = FirebaseDatabase.instance.ref("comments/$commentaryID/$commentID");
    var snapshot = await refComment.get();
    if(!snapshot.exists){
      return throw("comment doesn't exist");
    }
    CommentModel comment = CommentModel.fromJson(FirebaseObjectsElementsToMap.objectToMap(snapshot.value as Map));
    return comment;
  }

  @override
  Future<List<CommentModel>> getPage({int limit = 30, String? start, required String commentaryID})async {
    List<CommentModel> listComments = [];
    var ref = FirebaseDatabase.instance.ref("comments/$commentaryID");
    var list = ref.startAt(null,key: start).limitToFirst(limit).get();
    await list.then((value){
      if(value.exists){
        Map<String, dynamic> map = FirebaseObjectsElementsToMap.objetsToMap(value.value as Map);
        map.entries.map((e) => listComments.add(CommentModel.fromJson(FirebaseObjectsElementsToMap.objectToMap(e.value))));
      }
    });
    return listComments;
  }

  @override
  Future<void> onCommentEvent({required String commentaryID, required StreamController streamController}) async{
    final commentRef = FirebaseDatabase.instance.ref("comments/$commentaryID");

    /*************************************************************
     * ****************onchanged*****************************************
     * ***************************************************************/
    commentRef.onChildChanged.listen((event) {

      streamController.add(CommentModel.fromJson(FirebaseObjectsElementsToMap.objectToMap(event.snapshot.value as Map)));
    });

    /*************************************************************
     * ****************onremoved*****************************************
     * ***************************************************************/
    commentRef.onChildRemoved.listen((event) {

      streamController.add(CommentModel.fromJson(FirebaseObjectsElementsToMap.objectToMap(event.snapshot.value as Map)));
    });

    /*************************************************************
     * **************** onadded *****************************************
     * ***************************************************************/
    commentRef.onChildAdded.listen((event) {

      streamController.add(CommentModel.fromJson(FirebaseObjectsElementsToMap.objectToMap(event.snapshot.value as Map)));
    });

  }


  @override
  Future<void> onValue({required String childIdField, required StreamController streamController}) {
    // TODO: implement onValue
    throw UnimplementedError();
  }

  @override
  Future<CommentModel> sendComment({required CommentModel comment, required String commentaryID}) async{
    var result = FirebaseAuth.instance.currentUser == null;
    if(result) {
      throw("you're not connected");
    }
    User? user = FirebaseAuth.instance.currentUser;
    comment.sender = user!.uid;
    comment.createAt = DateTime.now().millisecondsSinceEpoch;
    var refComments = FirebaseDatabase.instance.ref("comments/$commentaryID").push();
    comment.id = refComments.key;
    await refComments.set(comment.toJson());

    return comment;
  }

  @override
  Future<void> updateComment({required CommentModel comment, required String commentaryID})async {
    var refMessages = FirebaseDatabase.instance.ref("comments/$commentaryID/${comment.id}");
    await refMessages.update(comment.toJson());
  }

}