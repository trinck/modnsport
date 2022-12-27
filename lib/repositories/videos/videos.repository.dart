import 'dart:async';
import 'dart:io';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:modnsport/models/video.model.dart';
import 'package:modnsport/utils/fierebase.covertomap.dart';

import 'videos.repository.firebase.dart';

class VideosRepository extends VideosRepositoryFirebase{
  @override
  Future<Video> deleteVideo({required String videoID, required String uid}) async{
    var refVideo = FirebaseDatabase.instance.ref("videos/$uid/$videoID");

    var snapshot = await refVideo.get();
    if(!snapshot.exists){
      return throw("video doesn't exist");
    }
    Video video = Video.fromJson(FirebaseObjectsElementsToMap.objectToMap(snapshot.value as Map));
    await refVideo.remove();
    return video;
  }

  @override
  Future<List<Video>> getAll() async{
    List<Video> listVideo= [];
    var ref = FirebaseDatabase.instance.ref("videos");
    var list = ref.get();
    await list.then((value) {
      if(value.exists){
        Map<String, dynamic> map = FirebaseObjectsElementsToMap.objetsToMap(value.value as Map);
        map.entries.map((e) => listVideo.add(Video.fromJson(FirebaseObjectsElementsToMap.objetsToMap(e.value))));
      }
    });

    return listVideo;
  }

  @override
  Future<List<Video>> getAllMyVideos() async{
    List<Video> listVideo= [];
    bool connected = FirebaseAuth.instance.currentUser == null;
    if(!connected){
      return throw("you're not connected");
    }

    User? user = FirebaseAuth.instance.currentUser;
    var ref = FirebaseDatabase.instance.ref("videos/${user?.uid}");
    var list = ref.get();
    await list.then((value) {
      if(value.exists){
        Map<String, dynamic> map = FirebaseObjectsElementsToMap.objetsToMap(value.value as Map);
        map.entries.map((e) => listVideo.add(Video.fromJson(FirebaseObjectsElementsToMap.objectToMap(e.value))));
      }
    });
    return listVideo;
  }

  @override
  Future<List<Video>> getPage({int limit = 30, String? start})async {
    List<Video> listVideo = [];
    var ref = FirebaseDatabase.instance.ref("videos");
    var list = ref.startAt(null,key: start).limitToFirst(limit).get();
    await list.then((value) {
      if(value.exists){
        Map<String, dynamic> map = FirebaseObjectsElementsToMap.objetsToMap(value.value as Map);
        map.entries.map((e) => listVideo.add(Video.fromJson(FirebaseObjectsElementsToMap.objetsToMap(e.value))));
      }
    });

    return listVideo;
  }

  @override
  Future<List<Video>> getPageMyVideos({int limit = 30, String? start}) async{
    List<Video> listVideo = [];
    bool connected = FirebaseAuth.instance.currentUser == null;

    if(connected){
      return throw("you're not connected");
    }

    User? user = FirebaseAuth.instance.currentUser;
    var ref = FirebaseDatabase.instance.ref("videos/${user?.uid}");
    var list = ref.startAt(null,key: start).limitToFirst(limit).get();
    await list.then((value) {
      if(value.exists){
        Map<String, dynamic> map = FirebaseObjectsElementsToMap.objetsToMap(value.value as Map);
        map.entries.map((e) => listVideo.add(Video.fromJson(FirebaseObjectsElementsToMap.objectToMap(e.value))));
      }
    });
    return listVideo;
  }

  @override
  Future<Video> getVideo({required String videoID, required String uid})async {
    var refVideo = FirebaseDatabase.instance.ref("messages/$uid/$videoID");

    var snapshot = await refVideo.get();
    if(!snapshot.exists){
      return throw("video doesn't exist");
    }
    Video video = Video.fromJson(FirebaseObjectsElementsToMap.objectToMap(snapshot.value as Map));
    return video;
  }

  @override
  Future<TransactionResult > likeVideo({required String videoID, required String uid})async {
    bool connected = FirebaseAuth.instance.currentUser == null;

    if(connected){
      throw("you're not connected");
    }
    User? user = FirebaseAuth.instance.currentUser;
    final videosRef = FirebaseDatabase.instance.ref("videos/$uid/$videoID/metrics");

    TransactionResult result = await videosRef.runTransaction((Object? metrics) {
      // Ensure a post at the ref exists.
      if (metrics == null) {
        return Transaction.abort();
      }

      Map<String, dynamic> map = FirebaseObjectsElementsToMap.objectToMap(metrics as Map);
      if (map["users"] is Map && map["users"][user?.uid] != null) {
        map["likes"] = (map["likes"] ?? 1) - 1;
        map["users"][user?.uid] = null;
      } else {
        map["likes"] = (map["likes"] ?? 0) + 1;
        if (!map.containsKey("users")) {
          map["users"] = {};
        }
        map["users"][user?.uid] = true;
      }

      // Return the new data.
      return Transaction.success(map);
    }, applyLocally: false);

    return result;
  }

  @override
  Future<void> onValue({required String childIdField, required StreamController streamController}) {
    // TODO: implement onValue
    throw UnimplementedError();
  }

  @override
  Future<void> onVideoEvent({required StreamController streamController}) async{

    bool connected = FirebaseAuth.instance.currentUser == null;
    if(connected){
      throw("you're not connected");
    }
    User? user = FirebaseAuth.instance.currentUser;
    final videosRef = FirebaseDatabase.instance.ref("videos/${user?.uid}");
    /*************************************************************
     * ****************onchanged*****************************************
     * ***************************************************************/
     videosRef.onChildChanged.listen((event) {

      streamController.add(Video.fromJson(FirebaseObjectsElementsToMap.objectToMap(event.snapshot.value as Map)));
    });

    /*************************************************************
     * ****************onremoved*****************************************
     * ***************************************************************/
    videosRef.onChildRemoved.listen((event) {

      streamController.add(Video.fromJson(FirebaseObjectsElementsToMap.objectToMap(event.snapshot.value as Map)));
    });

    /*************************************************************
     * **************** onadded *****************************************
     * ***************************************************************/
    videosRef.onChildAdded.listen((event) {

      streamController.add(Video.fromJson(FirebaseObjectsElementsToMap.objectToMap(event.snapshot.value as Map)));
    });

  }

  @override
  Future<void> updateVideo({required Video video})async {
    var refVideo = FirebaseDatabase.instance.ref("videos/${video.uid}/${video.id}");
    await refVideo.update(video.toJson());

  }

  @override
  Future<void> updateVideoPermission({required Video video})async {
    var refVideo = FirebaseDatabase.instance.ref("videos/${video.uid}/${video.id}");
    await refVideo.update({
      "permission":video.permission
    });

  }

  @override
  Future<void> updateTitle({required Video video}) async{
    var refVideo = FirebaseDatabase.instance.ref("videos/${video.uid}/${video.id}");
    await refVideo.update({
      "title":video.title
    });

  }

  @override
  Future<void> updateUrl({required Video video}) async{
    var refVideo = FirebaseDatabase.instance.ref("videos/${video.uid}/${video.id}");
    await refVideo.update({
      "url":video.url
    });
  }

  @override
  Future<void> uploadVideo({required Video video})async{
    bool connected = FirebaseAuth.instance.currentUser == null;
    if(connected){
       throw("you're not connected");
    }
    var refVideos = FirebaseDatabase.instance.ref("videos/${video.uid}").push();
    video.createAt = DateTime.now().millisecondsSinceEpoch;
    video.id = refVideos.key;
    User? user = FirebaseAuth.instance.currentUser;
    try{
      await refVideos.set(video.toJson());
    }catch(e){
      throw("error: $e");
    }
  }

}