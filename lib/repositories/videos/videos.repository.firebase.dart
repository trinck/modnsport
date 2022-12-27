import 'dart:async';
import 'dart:io';


import 'package:firebase_database/firebase_database.dart';
import 'package:modnsport/models/video.model.dart';

abstract class VideosRepositoryFirebase{

  Future<List<Video>> getPage({int limit = 30, String? start});
  Future<List<Video>> getPageMyVideos({int limit = 30, String? start});
  Future<List<Video>> getAll();
  Future<List<Video>> getAllMyVideos();
  Future<void> uploadVideo({ required Video video});
  Future<Video> getVideo({required String videoID, required String uid});
  Future<void> updateVideo({required Video video});
  Future<void> updateTitle({required Video video});
  Future<void> updateUrl({required Video video});
  Future<void> updateVideoPermission({required Video video});
  Future<TransactionResult> likeVideo({required String videoID,required String uid});
  Future<Video> deleteVideo({required String videoID, required String uid});
  Future<void> onVideoEvent({required StreamController streamController});
  Future<void> onValue({required String childIdField, required StreamController streamController});

}